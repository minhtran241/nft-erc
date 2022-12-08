// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

contract Web3Builder is
    ERC1155,
    Ownable,
    Pausable,
    ERC1155Supply,
    PaymentSplitter
{
    uint256 public publicCurrentPrice = 0.01 ether;
    uint256 public publicMaxSupply = 2000;
    bool public publicMintOpen = false;

    uint256 public VIPCurrentPrice = 0.001 ether;
    uint256 public VIPMaxSupply = 50;
    bool public VIPMintOpen = false;

    mapping(address => bool) VIPList;
    mapping(address => uint256) purchasesPerWallet;
    uint256 public maxPerWallet = 5;

    modifier onlyVIP() {
        require(VIPList[msg.sender], "You are not on the VIP list");
        _;
    }

    constructor(address[] memory _payees, uint256[] memory _shares)
        ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
        PaymentSplitter(_payees, _shares)
    {}

    // Function to modify the mint windows
    function editMintWindows(bool _publicMintOpen, bool _VIPMintOpen)
        external
        onlyOwner
    {
        publicMintOpen = _publicMintOpen;
        VIPMintOpen = _VIPMintOpen;
    }

    // Function to set the VIPList
    function setVIPList(address[] calldata addresses) external onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            VIPList[addresses[i]] = true;
        }
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // Add supply tracking.
    function publicMint(uint256 id, uint256 amount) public payable {
        mint(id, amount, false);
    }

    function VIPMint(uint256 id, uint256 amount) public payable onlyVIP {
        mint(id, amount, true);
    }

    function mint(
        uint256 id,
        uint256 amount,
        bool isVIP
    ) internal {
        require(
            purchasesPerWallet[msg.sender] + amount <= maxPerWallet,
            "Wallet limit reached"
        );
        require(id < 2, "You are trying to mint the wrong NFT");
        if (isVIP) {
            require(VIPMintOpen, "VIP List mint is closed");
            require(msg.value == VIPCurrentPrice * amount, "Not Enough Funds");
            require(
                totalSupply(id) + amount <= VIPMaxSupply,
                "We have minted out!"
            );
        } else {
            require(publicMintOpen, "Public mint closed");
            require(
                msg.value == publicCurrentPrice * amount,
                "Not Enough Funds"
            );
            require(
                totalSupply(id) + amount <= publicMaxSupply,
                "We have minted out!"
            );
        }
        _mint(msg.sender, id, amount, "");
        purchasesPerWallet[msg.sender] += amount;
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     *
     * This implementation returns the same URI for *all* token types. It relies
     * on the token type ID substitution mechanism
     * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
     *
     * Clients calling this function must replace the `\{id\}` substring with the
     * actual token type ID.
     */
    function uri(uint256 _id)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(exists(_id), "URI: Nonexistent Token");
        return
            string(
                abi.encodePacked(super.uri(_id), Strings.toString(_id), ".json")
            );
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) whenNotPaused {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
