// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EAGLE {
    string public name = "Token for Social Causes";
    string public symbol = "EAGLE";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    address public TAREAGLEContract;

    constructor(address _TAREAGLEContract) {
        TAREAGLEContract = _TAREAGLEContract;
    }

    modifier onlyTAREAGLE() {
        require(msg.sender == TAREAGLEContract, "Only TAREAGLE can mint");
        _;
    }

    function mint(address account, uint256 amount) external onlyTAREAGLE returns (bool) {
        totalSupply += amount;
        balances[account] += amount;
        emit Minted(account, amount);
        return true;
    }

    event Minted(address indexed account, uint256 amount);
}
