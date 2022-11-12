//SPDX-License-Identifier:MIT
pragma solidity^0.8.0;


contract NFTCollection {

    mapping (address=>uint256) internal _balances; 
    mapping (uint256=>address) internal _owners;
    mapping (address=>mapping(address=>bool)) private _operatorApprovals;

    event ApprovalForAll(address indexed _owner, address indexed operator,bool _approved);
    function balanceOf(address _owner)external view returns(uint256){
        require(_owner!=address(0), "address is invalid");
        return _balances[_owner];


    }
    function ownerOf(uint256 _tokenId)external view returns(address){
        address owner=_owners[_tokenId];
        require(owner!=address(0), "Token id is not valid");
        return owner;
    }

    function setApprovalForAll(address _operator,bool _approved)external{
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender,_operator,_approved);
    }

    function isApprovalForAll(address _owner,address _operator)external view returns(bool){
        return _operatorApprovals[_owner][_operator];

    }
}

