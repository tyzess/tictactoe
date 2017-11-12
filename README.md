# Ethereum - Everything you need to know

# Setup

We will be using a VM running Ubuntu 16.04 with WMware Workstation Player

### Install Node.js and npm

> sudo apt-get install curl  
> curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -  
> sudo apt-get install -y nodejs  
> sudo apt-get install -y build-essential

Hence we should have node.js v8.x installed

> node --version
> v8.9.1


### Install testrpc

Using 4.1.3 ATM, due to issues with gasLimit on contract creation

> npm install -g ethereumjs-testrpc@4.1.3


### Install solcjs and solc

There are actually two Solidity compilers: solc, written in C++, and solc-js, which uses Emscripten to cross-compile from the solc C++ source code to JavaScript. Technically they’re built from the same source code, but in practice they appear to produce slightly different results. They also have different command line interfaces, and solcjs is (as expected) quite a bit slower than solc.  
First we start with 'solcjs'

> npm install -g solc 

Additionally, we install the command line compiler 'solc' 

> sudo add-apt-repository ppa:ethereum/ethereum  
> sudo apt-get update  
> sudo apt-get install solc

### Install geth


> sudo apt-get install software-properties-common  
> sudo add-apt-repository ppa:ethereum/ethereum  
> sudo apt-get update  
> sudo apt-get install ethereum


### Setup project

> mkdir <your_project_name>  
> cd <your_project_name>  
> npm init

Configure your npm project

> npm install ethereum/web3.js --save

## Running

Start the full client simulator

> testrpc

Head with your browser of choice to 'remix.ethereum.org'  
As Environment choose 'Web3 Provider' and connect to 'localhost:8545'
