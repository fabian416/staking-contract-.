import { ethers } from "hardhat";

async function main() {

  const addresTareagle = "0x833D5b1B3aa49aCbFD4FC8275359a5BEE0e53f71";

  const Eagle = await ethers.getContractFactory("Eagle");
  const eagle = await Eagle.deploy(addresTareagle);

  await eagle.deployed();

  console.log(
    `Eagle deployed to ${eagle.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
