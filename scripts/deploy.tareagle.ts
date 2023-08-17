import { ethers } from "hardhat";

async function main() {

  const addresUSDT = "0x1BD7B233B054AD4D1FBb767eEa628f28fdE314c6";

  const TarEagle = await ethers.getContractFactory("TarEagle");
  const tarEagle = await TarEagle.deploy(addresUSDT);

  await tarEagle.deployed();

  console.log(
    `TarEagle deployed to ${tarEagle.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
