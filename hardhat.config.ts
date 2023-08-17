import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from 'dotenv';
dotenv.config();

const { API_URL, PRIVATE_KEY } = process.env;
const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    polygon: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/x5CxkSPFltlV8IbifVwoFjkmIKrLbMDK",
      chainId: 80001,
      accounts: [`0x${PRIVATE_KEY}`]
    }
  }
};

export default config;
