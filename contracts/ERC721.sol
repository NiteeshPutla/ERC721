//SPDX-License-Identifier:MIT
pragma solidity^0.8.0;


contract NFTCollection {

    mapping (address=>uint256) internal _balances; 
    mapping (uint256=>address) internal _owners;
    mapping (address=>mapping(address=>bool)) private _operatorApprovals;

    mapping(uint256=>address)private _tokenApprovals;

    event ApprovalForAll(address indexed _owner, address indexed operator,bool _approved);
    event Approval(address indexed _owner,address indexed _approved,uint256 _tokenId);
    function balanceOf(address _owner)public view returns(uint256){
        require(_owner!=address(0), "address is invalid");
        return _balances[_owner];


    }
    function ownerOf(uint256 _tokenId)public view returns(address){
        address owner=_owners[_tokenId];
        require(owner!=address(0), "Token id is not valid");
        return owner;
    }

    function setApprovalForAll(address _operator,bool _approved)external{
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender,_operator,_approved);
    }

    function isApprovedForAll(address _owner,address _operator)public view returns(bool){
        return _operatorApprovals[_owner][_operator];

    }

    function approve(address _approved, uint256 _tokenId)external payable{
        address owner = ownerOf(_tokenId);
        require(msg.sender==owner || isApprovedForAll(owner,msg.sender),"Msg.sender is not the owner or operator");
        _tokenApprovals[_tokenId]=_approved;
        emit Approval(owner,_approved,_tokenId);

    }
}

