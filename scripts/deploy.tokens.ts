const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();

    console.log("Deploying tokens with the account:", deployer.address);

    // Desplegar STK token con 1 millón de suministro.
    const STKFactory = await hre.ethers.getContractFactory("STK");
    const stkToken = await STKFactory.deploy("StakingToken", "STK", hre.ethers.utils.parseEther("1000000"));
    await stkToken.deployed();
    console.log("STK deployed to:", stkToken.address);

    // Desplegar RWD token con 1 millón de suministro.
    const RWDFactory = await hre.ethers.getContractFactory("RWD");
    const rwdToken = await RWDFactory.deploy("RewardsToken", "RWD", hre.ethers.utils.parseEther("1000000"));
    await rwdToken.deployed();
    console.log("RWD deployed to:", rwdToken.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
