import { ethers } from "hardhat";

async function main() {
    const contractTareagleAddress = "0x833D5b1B3aa49aCbFD4FC8275359a5BEE0e53f71";
    const contractUsdtAddress = "0x1BD7B233B054AD4D1FBb767eEa628f28fdE314c6";
    const owner = "0xd34C2940AB2E9BB339460f618E2748c34afF0Dc1";
    const amountUsdt = "10000000000000000000";

    const TERC20 = await ethers.getContractFactory("TERC20");
    const terc20 = TERC20.attach(contractUsdtAddress);

    const allowance = await terc20.allowance(owner, contractTareagleAddress);
    console.log(`TERC20.allowance result: ${JSON.stringify(allowance)}`);

    const approve = await terc20.approve(contractTareagleAddress, amountUsdt);
    console.log(`TERC20.approve result: ${JSON.stringify(approve)}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});