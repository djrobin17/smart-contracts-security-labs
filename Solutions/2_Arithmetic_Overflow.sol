// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        assert(c >= a);
        return c;
    }
}

contract TimeLockedWallet {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;
    mapping(address => uint256) public unlockTime;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        unlockTime[msg.sender] = block.timestamp + 1 hours;
    }

    function extendLockTime(uint256 _secondsToExtend) public {
        unlockTime[msg.sender] = unlockTime[msg.sender].add(_secondsToExtend);
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");
        require(
            block.timestamp > unlockTime[msg.sender],
            "Unlock time not reached"
        );

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to withdraw funds");
    }
}
