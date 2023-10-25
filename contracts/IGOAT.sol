// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./IERC20.sol";

interface IGOAT is IERC20 {
    function mintWithBacking(uint256 numTokens, address recipient) external returns (uint256);
    function redeem(uint256 tokenAmount) external returns (uint256);
    function redeemTo(uint256 tokenAmount, address recipient) external returns (uint256);
    
    function calculateTokensForExactWPLS(uint256 amount) external view returns (uint256);

    function estimateMinted(uint256 numTokens) external view returns (uint256);
    function estimateRedeemed(uint256 numTokens) external view returns (uint256);

    function getValueOfHoldings(address holder) external view returns(uint256);
}