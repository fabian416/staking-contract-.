// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./Tar.sol";
import "./Eagle.sol";

contract TarEagle {
    Tar public tarToken;
    Eagle public eagleToken;
    IERC20 public usdtToken;

    uint256 public tarPrice = 1 ether; // 1 TAR = 1 USDT

    constructor(address _usdtAddress) {
        tarToken = new Tar(address(this));
        eagleToken = new Eagle(address(this));
        usdtToken = IERC20(_usdtAddress);
    }

    function buyTAR(uint256 tarAmount) external {
        uint256 totalCost = tarAmount * tarPrice; 

        usdtToken.transferFrom(msg.sender, address(this), totalCost); 

        tarToken.transfer(msg.sender, tarAmount); // Transferimos los TAR al comprador

        uint256 eagleAmount = tarAmount / 100; // Calculamos la cantidad de EAGLE (1% de la cantidad de TAR)
        eagleToken.mint(msg.sender, eagleAmount); // Emitimos EAGLE al comprador
    }
}
