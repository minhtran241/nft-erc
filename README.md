# ERC Data Standard for Creating NFT

***Template contract for NFT project***

## Content

- [Template contract I built based on ***ERC-721***](https://github.com/minhtran241/nft-erc/tree/main/ERC-721)
- [Template contract I built based on ***ERC-1155***](https://github.com/minhtran241/nft-erc/tree/main/ERC-1155)

---

Ethereum has emerged as a groundbreaking open-source blockchain network that allows developers to build decentralized applications and smart contracts. One of Ethereum's most impactful elements is the availability and use of token standards, which encourage innovation by allowing developers to build their own applications.

Two notable Ethereum token standards are ***ERC-721*** and ***ERC-1155***, both of which are tied to the growing popularity of the non-fungible token (NFT) and their applications.

A token is a single smart contract or a segment of code on the blockchain. NFTs are unique crypto tokens that can represent digital or physical assets like artwork, game items, and real estate, sold and purchased on NFT marketplaces. Because of the unique identification and metadata that sets them apart from one another, equal exchange is not possible with NFTs, differentiating them from fungible tokens such as cryptocurrencies.

***Setting the Standards***

In the blockchain world, token standards lay out the rules and functions determining how a particular crypto token works. These application-level specifications empower smart contracts to fulfill their essential functions.

Token standards guide developers in creating and deploying new tokens on the supporting blockchain. Ethereum token standards—which are known as Ethereum Request for Comment (ERC)—designate specific functions for each token type and enable interactions between smart contracts and applications.

Anyone can create and propose an ERC, but it must go through a thorough review, feedback, and revision process before being accepted by Ethereum's development community.

---

## ERC-721 vs ERC-1155: Major Differences

1. ***Batch Transfers: ERC-1155 can facilitate batch transfers, reducing network congestion and lowering gas costs by up to 90%. ERC-721’s need for transactions to be created for individual NFTs leads to slow, inefficient transactions and higher gas fees.*** Gas fees refer to the required cost for conducting a single transaction on the Ethereum blockchain.

2. **Token Support:** ERC-721 only supports the creation of NFTs, while ERC-1155 not only supports the creation of NFTs but also fungible and semi-fungible tokens, facilitating the conversion of these types of tokens to NFTs and vice-versa. This flexibility is a significant advantage for ERC-1155.

3. **Transaction Security:** Unlike ERC-721, ERC-1155 has a transfer security function that enables hassle-free transactions and allows tokens to be reclaimed by the issuer if sent to the wrong address. This asset security capability also includes logging everything during a token's lifecycle, from minting to burning.

4. **Decentralized Exchange (DEX) Support:** ERC-1155 is serviceable for a DEX because it has built-in code that supports a DEX by fulfilling certain smart contract aspects. ERC-721 has no such enhanced support capability.

5. **Metadata Flexibility:** Compared to ERC-721’s use of static metadata incorporated within a smart contract, ERC-1155 has more flexibility in maintaining countless Uniform Resource Identifier (URI) codes.

6. While **ERC-721** is an effective token standard that has served a significant purpose, ERC-1155 brings greater efficiency, flexibility, and security, allowing savings in both time and cost. Existing non-ERC-1155 projects should migrate to the standard to experience expanded functionality.

7. The **ERC-1155** token standard could be a building block for tradable digital assets produced, stored, and exchanged in an NFT marketplace. This marketplace could be developed by blockchain experts at an experienced software development company.
