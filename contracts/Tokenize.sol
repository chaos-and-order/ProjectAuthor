pragma solidity ^0.5.0;
import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721MetadataMintable.sol";
import "./PublishBook.sol";


contract Tokenize is ERC721,ERC721MetadataMintable, PublishBook {

    uint256 isbn;   //Value to come in from the front end.
    uint256 tokenId;
    uint256 tokenCounter; //arbitrary counter to help generate unique tokenID
    address tokenBuyer; //address of token purchaser via front-end.
    address buyerAddress;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;

    //tokenID to resalePrice mapping
    mapping (uint256 => uint256) private resalePrice;  
    
    //tokenID to bool value mapping, whether or not the given token is up for resale
    mapping(uint256 => bool) private isUpForResale;
    
    //tokenId a value that will be less than 10,000,000 
    function generateTokenID() private onlyMinter returns(uint256){
        tokenCounter++;
        uint256 tokenid = uint256(keccak256(abi.encodePacked(isbn, now,tokenCounter))) % 10000000;
        return(tokenid);
    }

    
    function _mint(address to, uint256 tokenId) internal onlyMinter {
        require(to != address(0),"Address(0) Error !");
        require(!_exists(tokenId),"Token ID does not exist !");
        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();
        emit Transfer(address(0), to, tokenId);
    }


    /**
     * @dev Internal function to set the token URI for a given token
     * Reverts if the token ID does not exist
     * @param tokenId uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId),"Token ID does not exist !");
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Function to mint tokens
     * @param to The address that will receive the minted tokens.
     * @param tokenId The token id to mint. NOT IN USE HERE
     * @param tokenURI The token URI of the minted token.
     * @return A boolean that indicates if the operation was successful.
     */

     //TO-DO: send struct as token metadata !!!
    function mintWithTokenURI(address to, string memory tokenURI) public payable onlyMinter returns (bool) {
        //to revert back if the buyer doesn't have the price by the author.
        require(to.value == setPrice[isbn],"Insufficient funds ! Please pay the price as set by the author.");
        tokenId = generateTokenID();
        _tokenOwner[tokenId] = to;       
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);

        //resalePrice set to initial MRP by default
        resalePrice[tokenId] = setPrice[isbn];
        
        //token is not up for resale by default; the owner needs to put it up for sale
        isUpForResale[tokenId] = false;
        return true;
    }

    //function to retreive funds from contract into publisher's account.
    function sendTo(address _payee, uint256 _amount) public onlyOwner {

        require(_payee != address(0) && _payee != address(this),"Address(0) Erorr !");
        require(_amount > 0 && _amount <= address(this).balance,"No funds in contract !");
        _payee.transfer(_amount);
        emit Sent(_payee, _amount, address(this).balance);


        //TO DO: Make it usable for multiple Publishers!!  
        //A mapping would suffice I guess.
    }





}



