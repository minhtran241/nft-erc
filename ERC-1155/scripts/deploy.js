// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require('hardhat');
require('dotenv').config();

const { PAYEE_1, PAYEE_2, SHARE_1, SHARE_2 } = process.env;

async function main() {
	const Web3BuilderNFT = await ethers.getContractFactory(
		'Web3Builder'
	);
	const web3BuilderNFT = await Web3BuilderNFT.deploy(
		[PAYEE_1, PAYEE_2],
		[parseInt(SHARE_1), parseInt(SHARE_2)]
	);
	const txHash = web3BuilderNFT.deployTransaction.hash;
	const txReceipt = await ethers.provider.waitForTransaction(
		txHash
	);
	console.log(
		'Contract deployed to address:',
		txReceipt.contractAddress
	);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
