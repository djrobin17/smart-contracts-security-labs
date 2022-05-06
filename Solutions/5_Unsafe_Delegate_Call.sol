// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Lib {
    function hack(address owner) public {
        owner = msg.sender;
    }
}

contract Hackable {
    address public owner;

    fallback() external payable {
        address(Lib).delegatecall(msg.data);
    }

    receive() external payable {}
}
