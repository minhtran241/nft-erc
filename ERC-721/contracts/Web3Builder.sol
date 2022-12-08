// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Web3Builder is ERC721, ERC721Enumerable, Pausable, Ownable {
    using Counters for Counters.Counter;

    uint256 public publicCurrentPrice = 0.01 ether;
    uint256 public publicMaxSupply = 2000;
    bool public publicMintOpen = false;

    uint256 public VIPCurrentPrice = 0.001 ether;
    uint256 public VIPMaxSupply = 50;
    bool public VIPMintOpen = false;

    mapping(address => bool) public VIPList;

    Counters.Counter private _tokenIdCounter;

    modifier onlyVIP() {
        require(VIPList[msg.sender], "You are not on the VIP list");
        _;
    }

    constructor() ERC721("Web3Builder", "W3B") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // Modify the Mint windows.
    function editMintWindows(bool _publicMintOpen, bool _VIPMintOpen)
        external
        onlyOwner
    {
        publicMintOpen = _publicMintOpen;
        VIPMintOpen = _VIPMintOpen;
    }

    // Add payment.
    // Add limiting of supply.
    function publicMint() public payable {
        internalMint(false);
    }

    // require only the VIP people to mint.
    // Add publicMint adn VIPMint open variables.
    function VIPMint() public payable onlyVIP {
        internalMint(true);
    }

    function internalMint(bool isVIP) internal {
        if (isVIP) {
            // VIP minting.
            require(VIPMintOpen, "VIP Mint Closed");
            require(msg.value == VIPCurrentPrice, "Not Enough Funds");
            require(totalSupply() < VIPMaxSupply, "Sold Out!");
        } else {
            // Public minting.
            require(publicMintOpen, "Public Mint Closed");
            require(msg.value == publicCurrentPrice, "Not Enough Funds");
            require(totalSupply() < publicMaxSupply, "Sold Out!");
        }
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function withdraw(address _address) external onlyOwner {
        // Get the balance of the contract.
        uint256 balance = address(this).balance;
        payable(_address).transfer(balance);
    }

    // Populate the VIP List.
    function setVIPList(address[] calldata addresses) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            VIPList[addresses[i]] = true;
        }
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) whenNotPaused {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
