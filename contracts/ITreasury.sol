// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface ITreasury {
    function getBalance() external view returns (uint256);

    function withdraw(uint256 tokenAmount) external;
    function withdrawTo(address _to, uint256 _amount) external;
}