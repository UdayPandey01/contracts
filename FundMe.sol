// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PriceConvertor.sol";

contract FundMe {
    using PriceConvertor for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public owner;
    
    constructor(){
        owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't have enough funds");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{value : address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    modifier onlyOwner{
        require(msg.sender == owner, "Sender is not owner");
        _;
    }

}