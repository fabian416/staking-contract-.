import { ethers } from "hardhat";

async function main() {

  const addresTareagle = "0xc4Dbef9855600b3f071eFE0Aad561ef28559eaBC";

  const Tar = await ethers.getContractFactory("Tar");
  const tar = await Tar.attach(addresTareagle);

  const setTareagleContract = await tar.setTareagleContract(addresTareagle);
  console.log(`Tar.setTareagleContract result: ${JSON.stringify(setTareagleContract)}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
