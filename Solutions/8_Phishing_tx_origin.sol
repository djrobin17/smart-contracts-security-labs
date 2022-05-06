// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function deposit() public payable {}

    function transfer(address payable _to, uint256 _amount) public {
        require(msg.sender == owner, "Not owner");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
