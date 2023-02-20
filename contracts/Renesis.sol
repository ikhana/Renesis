// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract RenesisNFT is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 100;
    uint256 USERLIMIT = 5;
    mapping(address => uint)  public maxWalletMints;

    constructor() ERC721("Renesis", "RNS") {}

  
    function safeMint(address to) public  {
        uint256 tokenId = _tokenIdCounter.current();

        require(tokenId < MAX_SUPPLY, "maximum number of REnesis NFT's have been minted");
        require(maxWalletMints[to] < USERLIMIT, "you have reached the max Renesis per wallet and user.");
        maxWalletMints[to]+=1;
        
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount,uint batchsize) internal virtual override(ERC721,ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, amount,batchsize);
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