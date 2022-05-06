// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract RulerOfEther {
    address public ruler;
    uint256 public balance;
    mapping(address => uint256) public balances;

    function claimRule() external payable {
        require(msg.value > balance, "Need to pay more to become the ruler");

        balances[ruler] += balance;

        balance = msg.value;
        ruler = msg.sender;
    }

    function withdrawEther() public {
        require(msg.sender != ruler, "Current ruler cannot withdraw Ether");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
