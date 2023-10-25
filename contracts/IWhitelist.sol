// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IWhitelist {
    function addAddressToWhitelist(address addr) external returns (bool success);
    function addAddressesToWhitelist(address[] memory addrs) external returns (bool success);
    function removeAddressFromWhitelist(address addr) external returns (bool success);
    function removeAddressesFromWhitelist(address[] memory addrs) external returns (bool success);
}