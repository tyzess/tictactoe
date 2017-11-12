# Ethereum - Everything you need to know

# Setup

We will be using a VM running Ubuntu 16.04 with WMware Workstation Player

### Install Node.js and npm

sudo apt-get install curl
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

node --version
v8.9.1


### Install testrpc

// npm install -g ethereumjs-testrpc
npm install -g ethereumjs-testrpc@4.1.3 // ATM, due to issues 


### Install solcjs and solc

There are actually two Solidity compilers: solc, written in C++, and solc-js, which uses Emscripten to cross-compile from the solc C++ source code to JavaScript. Technically they’re built from the same source code, but in practice they appear to produce slightly different results. They also have different command line interfaces, and solcjs is (as expected) quite a bit slower than solc.

npm install -g solc 

sudo add-apt-repository ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install solc

### Install geth

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install ethereum


### Setup project

mkdir <your_project_name>
cd <your_project_name>
npm init
<setup_npm>
npm install web3 --save or npm install ethereum/web3.js --save

## Running

Start the full client simulator
testrpc

Head with your browser of choice to 'remix.ethereum.org'
As Environment choose 'Web3 Provider' and connect to 'localhost:8545'
