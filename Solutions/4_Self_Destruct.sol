// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
contract EtherGame {
    uint256 public targetAmount = 5 ether;
    address public winner;
    uint256 public balance;
    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        balance += msg.value;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }
    function claimReward() public {
        require(msg.sender == winner, "Not winner");

        (bool sent, ) = msg.sender.call{value: balance}("");
        require(sent, "Failed to send Ether");
    }
}
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}