pragma solidity ^0.5.0;
import "./Tokenize.sol";


contract Resale is Tokenize{


    //TO DO: As user logs in, he needs to see his current libraby, without sacrificing privacy.
    
    /*
    gotta see how to incorporate this fruitfully
    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_INTERFACE_ID_ERC721);
    }
    */

    /*
    NOT IMPLEMENTING THIS METHOD, BECAUSE THERE IS NO CONCEPT OF BALANCE HERE, 
    ownedTokensCount uses Counter.counters  ;  gotta figure that out.
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0));
        return _ownedTokensCount[owner].current();
    }
    */

    //FUNCTIONS TO BE USED

    function _exists(uint256 tokenId) internal view returns (bool);


    function ownerOf(uint256 tokenId) public view returns (address) ;

    function approve(address to, uint256 tokenId);

    function getApproved(uint256 tokenId) public view returns (address);

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool);

    function transferFrom(address from, address to, uint256 tokenId);

    function _transferFrom(address from, address to, uint256 tokenId);

    function _clearApproval(uint256 tokenId);


    //RESALE CODE BEGINS
/*
    uint256 tokenId;
    address to;
    address from;
*/

    
    
    
    function setResalePrice(uint256 newPrice, uint256 tokenId) public{
        require(_isApprovedOrOwner(msg.sender, tokenId));
        resalePrice[tokenId] = newPrice;
        isUpForResale[tokenId] = true;
    }

    function buyFromIndividual(uint256 tokenId) public payable{
        //set to a static value. This becomes an auction in future versions
        require(msg.value == resalePrice[tokenId]);
        
    }

}