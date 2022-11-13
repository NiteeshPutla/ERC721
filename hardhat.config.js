require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    goerli:{
      url:"https://eth-goerli.g.alchemy.com/v2/KSM93xJEEY9dwqbegaro7RrB8sEiNsyu",
      accounts:["c0f80f819b6e946774a72aad90a2b43862421ffbda4e72b97e633e4d5ef99609"]
    },
  },
  etherscan:{
    apiKey:{
      goerli:"DA2SATVJD49RD2J4VTEPK3X2W7Q7Y6V1WX",
    },
  }

 
};
