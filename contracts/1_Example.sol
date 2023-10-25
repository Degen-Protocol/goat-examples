// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./IGOAT.sol";
import "./IWPLS.sol";

import "./Whitelist.sol";

contract Battery is Whitelist {

    IGOAT public GOAT;
    IWPLS public WPLS;

    ///////////////////////////////
    // CONFIGURABLES & CONSTANTS //
    ///////////////////////////////

    address public feeRecipient;
    
    uint256 public lastCallTimestamp;

    ////////////////////////////
    // CONSTRUCTOR & FALLBACK //
    ////////////////////////////

    constructor () {
        WPLS.approve(address(GOAT), type(uint256).max);
    }

    receive () external payable {

    }

    ////////////////////
    // VIEW FUNCTIONS //
    ////////////////////

    // Time difference in seconds
    function timespan(uint256 time0, uint256 time1) public pure returns (uint256) {
        return time0 - time1;
    }

    // Emissions per Epoch (day)
    function emissionsPerEpoch() public view returns (uint256) {
        return GOAT.balanceOf(address(this)) * 50 / 10000;
    }

    // Emissions available since last call
    function available() public view returns (uint256) {
        uint256 time = timespan(block.timestamp, lastCallTimestamp);
        
        uint256 emissions = emissionsPerEpoch();

        return ((emissions * time) / 24 hours);
    }

    /////////////////////
    // WRITE FUNCTIONS //
    /////////////////////

    // Deposit PLS, wrap it and mint GOAT
    function deposit() public payable {

        WPLS.deposit{value: msg.value}();

        uint256 wplsBal = WPLS.balanceOf(address(this));

        GOAT.mintWithBacking(wplsBal, address(this));
    }

    // Withdraw PLS, according to Battery regulations
    function withdraw(address to) public returns (uint256 wplsPayable) {
        
        uint256 emissions = available();

        wplsPayable = GOAT.redeem(emissions);

        WPLS.withdraw(wplsPayable);

        payable(to).transfer(wplsPayable);

        lastCallTimestamp = block.timestamp;
    }

    //////////////////////////
    // RESTRICTED FUNCTIONS //
    //////////////////////////

    // Entirely deposit all WPLS into GOAT
    function charge() external onlyWhitelisted() {
        WPLS.approve(address(GOAT), WPLS.balanceOf(address(this)));
        GOAT.mintWithBacking(WPLS.balanceOf(address(this)), address(this));
    }

    // Entirely redeem all GOAT into WPLS
    function discharge() external onlyWhitelisted() {
        GOAT.redeemTo(GOAT.balanceOf(address(this)), address(this));
    }

    //////////////////////////
    // OWNER-ONLY FUNCTIONS //
    //////////////////////////

    function setFeeRecipient(address addr) external onlyOwner() {
        feeRecipient = addr;
    }
}