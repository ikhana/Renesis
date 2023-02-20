
## Deployment

To deploy this project run

```bash
  npm install
```
## Test1

To test first task with max 100 nfts you should remove the the user limit to allow automated tests to go beyond 5 mints. you can do this in Renesis.sol file, line 25 and run the following commands

```bash
  npx hardhat compile 
```

```bash
  npx hardhat test test/mintandmaxtest.js 
```

## Test2

To test second task you should run the following commands

```bash
  npx hardhat compile 
```

```bash
  npx hardhat test test/mintandperusertest.js 
```

## Test3

Get you Link from here https://faucets.chain.link/  to feed to your contract.

To test the randomness you can either run the local hardhat node bu running 

```bash
  npx hardhat node
```
then 

```bash
  npx hardhat run scripts/deploy.js 
```

OR alternatively you can test it manually on REMIX IDE here https://remix.ethereum.org/