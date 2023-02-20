// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract RenesisChainLink is ERC721, ERC721Enumerable, VRFConsumerBase{
       using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY = 100;
    uint256 USER_LIMIT = 5;

    
    uint256 private randomResult;
    bytes32 private keyHash;
    uint256 private fee;
    mapping(address => uint)  public maxWalletMints;


    constructor(address vrfCoordinator, address link, bytes32 keyHash, uint256 fee)
     ERC721("Renesis", "RNS") 
     VRFConsumerBase(vrfCoordinator, link) 
     {
        keyHash = keyHash;
        fee = fee;
        
    }
     function safeMint(address to) public {
        uint256 tokenId = _tokenIdCounter.current();

        require(tokenId < MAX_SUPPLY, "maximum number of REnesis NFT's have been minted");
        require(maxWalletMints[to] < USER_LIMIT, "you have reached the max Renesis per wallet and user.");
        maxWalletMints[to]+=1;

        _tokenIdCounter.increment();
        _safeMint(to, tokenId);

        string memory randomNumber = requestRandomNumber();
        uint256 randomResult1 = parseInt(randomNumber);
        uint256 newTokenId = randomResult1 % MAX_SUPPLY;
        _safeMint(to, newTokenId);
    }

    function requestRandomNumber() internal view returns (string memory) {
        require(LINK.balanceOf(address(this)) >= fee, "You don't have enough LINK - fill contract with faucet");
        return "random";
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
    }

    function parseInt(string memory _a) internal pure returns (uint256 _parsedInt) {
        bytes memory bresult = bytes(_a);
        uint256 mintens = 1;
        for (uint i = bresult.length - 1; i >= 0; i--) {
            uint256 cnum = uint256(uint8(bresult[i]));
            if (cnum >= 48 && cnum <= 57) {
                _parsedInt += (cnum - 48) * mintens;
                mintens *= 10;
            }
        }
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