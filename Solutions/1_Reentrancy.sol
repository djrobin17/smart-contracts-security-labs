// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract BankOfEther is ReentrancyGuard {
    using Address for address payable;

    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external nonReentrant {
        require(balances[msg.sender] > 0, "Insufficient funds");
        uint256 temp = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).sendValue(temp);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
