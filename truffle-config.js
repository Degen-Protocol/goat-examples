const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
const memphrase = fs.readFileSync(".secret").toString().trim();

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 8545,            // Standard BSC port (default: none)
      network_id: "*",       // Any network (default: none)
    },

    mainnet: {
      provider: () => new HDWalletProvider({mnemonic:{phrase:memphrase}, providerOrUrl:`https://rpc.pulsechain.com`, pollingInterval: 60000}, ),
      network_id: 369,
      confirmations: 3,
      timeoutBlocks: 200,
      skipDryRun: true
    },

    testnet: {
      provider: () => new HDWalletProvider({mnemonic:{phrase:memphrase}, providerOrUrl:`https://rpc.v4.testnet.pulsechain.com`, pollingInterval: 60000}, ),
      network_id: 943,
      confirmations: 3,
      timeoutBlocks: 200,
      skipDryRun: true
    },

    bnbTestnet: {
      provider: () => new HDWalletProvider({mnemonic:{phrase:memphrase}, providerOrUrl:`https://bsc-testnet.blockpi.network/v1/rpc/public`, pollingInterval: 60000}, ),
      network_id: 97,
      confirmations: 3,
      timeoutBlocks: 200,
      skipDryRun: true
    },
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
     //timeout: 10000000000000,
    enableTimeouts: false,
    before_timeout: 12000000000000 
  },

  plugins: ["truffle-contract-size", "truffle-plugin-verify"],
  api_keys: {
    etherscan: 'MY_API_KEY'
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "pragma"
    }
  },
}