//SPDX-License-Identifier:MIT
pragma solidity^0.8.0;

import "./ERC721.sol";
contract OnePiece is ERC721{
    string public name;
    string public symbol;
    uint256 public tokenCount;
    mapping (uint256=>string)private _tokenURIs;

    constructor(string memory _name,string memory _symbol){
        name=_name;
        symbol=_symbol;
    }

    //http url: consists all the information regarding metadata
    function tokenURI(uint256 _tokenId)public view returns (string memory){
        require(_owners[_tokenId]!=address(0), "token doesnot exist");
        return _tokenURIs[_tokenId];

    }
    function mint(string memory _tokenURI)public{
        tokenCount += 1;
        _balances[msg.sender]+=1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount]=_tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

    //support interface to support multi interface
    function supportsInterface(bytes4 interfaceId)public pure override returns(bool){
        return interfaceId==0x5b5e139f || interfaceId ==0x80ac58cd;
    }

}