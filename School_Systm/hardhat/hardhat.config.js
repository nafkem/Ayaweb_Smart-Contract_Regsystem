require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.17",
  networks:{
    goerli:{
      url: process.env.API_KEY_URL
     // PRIVATE_KEY loaded from .env file
      accounts: [`0x${process.env.GOERLI_PRIVATE_KEY}`]
    }
  }
};