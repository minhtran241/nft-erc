# ERC-1155

- Introduced in 2018, ERC-1155 is a multi-token standard that provides a standard interface for smart contracts managing multiple types of tokens. The original intention behind the creation of ERC-1155 involved addressing the challenges experienced by developers in the world of blockchain-based gaming.

- ERC-1155 improves upon the functionality of ERC-721, increasing its efficiency and correcting evident implementation errors. It can support an infinite quantity of tokens in a single contract, underpinning fungible, semi-fungible, and NFTs, which can transition between both of the former during its lifecycle.

- ERC-1155 also has a security function that verifies a transaction's validity, allowing tokens to be returned to the issuer if a transaction fails. This eliminates the anxiety of potential user mistakes such as sending tokens to the wrong address. This function, along with other rules, safeguards against exploitation.

---

The template contract I built based on ***ERC-1155*** is deployed at address [0xe5A5f70d6E1635E0a95b6427FDBA420E7Fc8A9EB](https://goerli.etherscan.io/address/0xe5A5f70d6E1635E0a95b6427FDBA420E7Fc8A9EB) and is available inside [contracts/Web3Builder.sol](https://github.com/minhtran241/nft-erc/tree/main/ERC-1155/contracts/Web3Builder.sol). You can explore the deployed contract on TESTNET Goerli (GTH) Blockchain Explorer (Etherscan) at [here](https://goerli.etherscan.io/address/0xe5A5f70d6E1635E0a95b6427FDBA420E7Fc8A9EB).
