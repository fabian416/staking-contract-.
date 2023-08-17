import { ethers } from "hardhat";

async function main() {
    const contractAddress = "0x833D5b1B3aa49aCbFD4FC8275359a5BEE0e53f71";
    const amountTar = "10000000000000000000";

    const TarEagle = await ethers.getContractFactory("TarEagle");
    const contract = TarEagle.attach(contractAddress);

    const result = await contract.buyTAR(amountTar);

    console.log(`TarEagle.buyTAR result: ${JSON.stringify(result)}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});