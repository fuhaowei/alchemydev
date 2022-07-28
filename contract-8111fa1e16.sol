// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.1/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.1/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.1/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.1/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.1/utils/Counters.sol";

contract Haofirst is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    uint256 MAX_SUPPLY = 10000;

    Counters.Counter private _tokenIdCounter;

    mapping(address => uint256) public _owners;

    constructor() ERC721("haofirst", "FHW") {}
  
    function safeMint(address to, string memory uri) public {
        require (_tokenIdCounter.current() <= MAX_SUPPLY, "I'm sorry max mint reached.");
        require(_owners[to] < 6, "5 nfts max per address! sorry");
        uint256 tokenId = _tokenIdCounter.current();
        _owners[to] += 1;
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }


    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}