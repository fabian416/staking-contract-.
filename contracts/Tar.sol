// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Tar is Ownable {
    address public addressController;
    address public tareagleContract; // dirección del contrato TAREAGLE
    string public name = "Token for Companies";
    string public symbol = "TAR";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1_000_000 * 10**18;
    mapping(address => uint256) public balances;

    constructor(address _addressController) {
        addressController = _addressController;
        balances[addressController] = totalSupply;
    }

    // Función para establecer la dirección de TAREAGLE y darle permisos para transferir tokens TAR
    function setTareagleContract(address _tareagleContract) external onlyOwner {
        tareagleContract = _tareagleContract;
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        // Permitimos que tanto el addressController como el contrato TAREAGLE puedan hacer transferencias
        require(msg.sender == addressController || msg.sender == tareagleContract, "Not authorized");
        require(balances[msg.sender] >= amount, "Not enough tokens");

        balances[msg.sender] -= amount;
        balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function mint(address account, uint256 amount) public {
        require(msg.sender == addressController, "Only the addressController can mint tokens");
        totalSupply += amount;
        balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
}
