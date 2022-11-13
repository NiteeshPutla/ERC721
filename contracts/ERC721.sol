//SPDX-License-Identifier:MIT
pragma solidity^0.8.0;


contract NFTCollection {

    mapping (address=>uint256) internal _balances; 
    mapping (uint256=>address) internal _owners;
    mapping (address=>mapping(address=>bool)) private _operatorApprovals;
    mapping(uint256=>address)private _tokenApprovals;

    event ApprovalForAll(address indexed _owner, address indexed operator,bool _approved);
    event Approval(address indexed _owner,address indexed _approved,uint256 _tokenId);
    event Transfer(address indexed _from,address indexed _to,uint256 _tokenId);


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

    function approve(address _approved, uint256 _tokenId)public payable{
        address owner = ownerOf(_tokenId);
        require(msg.sender==owner || isApprovedForAll(owner,msg.sender),"Msg.sender is not the owner or operator");
        _tokenApprovals[_tokenId]=_approved;
        emit Approval(owner,_approved,_tokenId);
    }
    function getApproved(uint256 _tokenId) public view returns(address){
        require(_owners[_tokenId]!=address(0),"Token id is invalid");
        return _tokenApprovals[_tokenId];
    }
    function transferFrom(address _from,address _to,uint256 _tokenId)public payable{
        address owner=ownerOf(_tokenId);
        require(msg.sender==owner || 
        getApproved(_tokenId)==msg.sender ||isApprovedForAll(owner,msg.sender),
        "Msg.sender is not the owner or approved address for transfer");

        require(owner==_from,"From address is not the owner");
        require(_to!=address(0),"Address is zero adress");

        approve(address(0),_tokenId);

        _balances[_from]-=1;
        _balances[_to]+=1;
        _owners[_tokenId]=_to;

        emit Transfer(_from , _to, _tokenId);

    }   
    function safeTransferFrom(address _from,address _to,uint256 _tokenId,bytes memory _data)public{
        transferFrom(_from,_to,_tokenId);
        require(_checkOnERC721Received(),"receiver not implemented");
    }
    
    //standard transferFrom 
    //checks if onERC721 received is implemented when sending to smart contracts.
    function safeTransferFrom(address _from,address _to,uint256 _tokenId)external payable{
        safeTransferFrom(_from,_to,_tokenId,"");
    }
    function _checkOnERC721Received()private pure returns(bool){
        return true;
    }

    // EIP165: check if a contract implements another interface
    function supportsInterface(bytes4 interfaceId)public pure virtual returns (bool){
        return interfaceId ==0x80ac58cd;
    }

}

