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

    // function _exists(uint256 tokenId) internal view returns (bool);


    // function ownerOf(uint256 tokenId) public view returns (address) ;

    // function approve(address to, uint256 tokenId);

    // function getApproved(uint256 tokenId) public view returns (address);

    // function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool);

    // function transferFrom(address from, address to, uint256 tokenId);

    // function _transferFrom(address from, address to, uint256 tokenId);

    // function _clearApproval(uint256 tokenId);


    //RESALE CODE BEGINS
/*
    uint256 tokenId;
    address to;
    address from;
*/

    address payable private sendTo;
    
    
    function setResalePrice(uint256 newPrice, uint256 tokenId) public{
        require(_isApprovedOrOwner(msg.sender, tokenId));
        reSale[tokenId].resalePrice = newPrice;
        reSale[tokenId].isUpForResale = true;
    }


    //this is a one-on-one transaction. Needs to be an auction in future
    function buyFromIndividual(uint256 tokenId) public payable{
        //works only if the given token is up for sale
        require(reSale[tokenId].isUpForResale == true);
        
        //set to a static value. This becomes an auction in future versions
        require(msg.value == reSale[tokenId].resalePrice);
        //commission value retrieved from fileinfo via resale
        uint256 commissionPercent = fileinfo[reSale[tokenId].ISBN].saleCommission;

        //The full version: (Just for Laughs)
        //publisherBalance[fileinfo[reSale[tokenId].ISBN].publisherAddress] += msg.value*((fileinfo[reSale[tokenId].ISBN].saleCommission)/100);

        //sendTo(fileinfo[reSale[tokenId].ISBN].publisherAddress, msg.value*(commissionPercent/100));
        //newer version of the above line of code.
        publisherBalance[fileinfo[reSale[tokenId].ISBN].publisherAddress] += msg.value*(commissionPercent/100);

        //sendTo(_tokenOwner[tokenId],msg.value - (msg.value*(commissionPercent/100)));

        //typecasting address to address payable before sending
        sendTo = address(uint160(_tokenOwner[tokenId]));
        sendTo.transfer(msg.value - (msg.value*(commissionPercent/100)));
        //updating token balances
        _ownedTokensCount[_tokenOwner[tokenId]].decrement();
        _ownedTokensCount[msg.sender].increment();
        //transfer of baton
        _tokenOwner[tokenId] = msg.sender;
        reSale[tokenId].isUpForResale = false;
    }


    //Function to view the ipfshash of the token, the tokendata
    /*
    The real implementation wouldn't let the user view the tokendata
    A digital handshake is what we need, between the token and the contract
    where both agrees that the token holds the ipfshash. 
    Tokendata must never be out in the open like this. 
    But, alas.  
    */
    function viewTokenData(uint256 tokenId) public view returns(string memory){
        require(_exists(tokenId));
        require(_tokenOwner[tokenId] == msg.sender);
        return tokenData[tokenId].ipfsHash;
    }
}