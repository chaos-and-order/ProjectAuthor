pragma solidity ^0.5.0;
import "./Tokenize.sol";

contract Resale is Tokenize{

    //event to be emitted when a seller puts out a token for sale
    event ResalePriceSet(uint256 indexed resalePrice, uint256 indexed tokenId);

    //function to show the balance of tokens in a user's account
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Invalid address given!");
        return _ownedTokensCount[owner].current();
    }

    //function to set resale price on a token that is being put up for sale        
    function setResalePrice(uint256 newPrice, uint256 tokenId) public{
        require(ownerOf(tokenId)==msg.sender, "You are not the owner of this token!");
        reSale[tokenId].resalePrice = newPrice*1 wei;
        reSale[tokenId].isUpForResale = true;
        emit ResalePriceSet(newPrice, tokenId);
    }


    //this is a one-on-one transaction. Needs to be an auction in future
    function buyFromIndividual(uint256 tokenId) public payable{
        //works only if the given token is up for sale
        require(reSale[tokenId].isUpForResale == true, "This token hasn't been put for sale by the owner");
        
        //set to a static value. This becomes an auction in future versions
        require(msg.value == reSale[tokenId].resalePrice, "Your price doesn't match the price given by the tokenOwner");

        //Finding the commissionPercent from fileinfo, and then finding the concrete value of it 
        //from msg.value and then storing in publisherBalance 
        publisherBalance[fileinfo[reSale[tokenId].ISBN].publisherAddress] += msg.value*((fileinfo[reSale[tokenId].ISBN].saleCommission)/100);

        //finding the seller's cut, and instantly transferring it to the seller 
        address payable sendTo;
        sendTo = address(uint160(_tokenOwner[tokenId]));       
        sendTo.transfer(msg.value - (msg.value*((fileinfo[reSale[tokenId].ISBN].saleCommission)/100)));
        //updating token balances for both seller and buyer
        _ownedTokensCount[_tokenOwner[tokenId]].decrement();
        _ownedTokensCount[msg.sender].increment();

        emit Transfer(_tokenOwner[tokenId], msg.sender, tokenId);
        _tokenOwner[tokenId] = msg.sender;
        reSale[tokenId].isUpForResale = false;
    }

    //To transfer a token freely to an address. Only owner of the said token can do it.
    function transfer(address _to, uint256 _tokenId) public{
        require(ownerOf(_tokenId)==msg.sender, "You are not the owner of this token!");
        _tokenOwner[_tokenId] = _to;
        _ownedTokensCount[msg.sender].decrement();
        _ownedTokensCount[_to].increment();
        reSale[_tokenId].isUpForResale = false;
        emit Transfer(msg.sender, _to, _tokenId);
    }


    //Function to view the ipfshash of the token, the tokendata
    /*
    The real implementation wouldn't let the user view the tokendata
    A digital handshake is what we need, between the token and the contract
    where both agrees that the token holds the ipfshash. 
    Tokendata must never be out in the open like this. 
    */
    function viewTokenData(uint256 tokenId) public view returns(string memory){
        require(_exists(tokenId), "Token doesn't exist!");
        require(ownerOf(tokenId)==msg.sender, "You are not the owner of this token!");
        return tokenData[tokenId].ipfsHash;
    }
/*
    TO DO [Future versions]: 
    1.
    scrap the above viewTokenData.
    user gets access to file solely depending on 
    require(_tokenOwner[tokenId] == msg.sender);
    because the whole gimmick is on this mapping. 
    So we don't need to provide ipfsHash inside the token. Solves that issue.

    2.
    add tokenmetadata(), where stuff (trinkets) that makes the token unique are added.
*/
}