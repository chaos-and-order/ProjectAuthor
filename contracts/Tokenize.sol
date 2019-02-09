pragma solidity ^0.5.0;
import "./IERC721.sol";
import "./PublishBook.sol";


contract Tokenize is IERC721, PublishBook {

    uint256 isbn;   //Value to come in from the front end.
    uint256 tokenId;
    address tokenBuyer; //address of token purchaser via front-end.

    // Mapping from token ID to owner
    mapping (uint256 => address) private _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) private _ownedTokensCount;
    
    //tokenId a value that will be less than 10,000,000 
    function generateTokenID() private onlyMinter returns(uint256){
        uint256 tokenid = uint256(keccak256(abi.encodePacked(isbn, now))) % 10000000;
        return(tokenid);
    }

    
    function _mint(address to) internal onlyMinter {
         require(to != address(0));
         require(!_exists(tokenId));
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
        require(_exists(tokenId));
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Function to mint tokens
     * @param to The address that will receive the minted tokens.
     * @param tokenId The token id to mint. NOT IN USE HERE
     * @param tokenURI The token URI of the minted token.
     * @return A boolean that indicates if the operation was successful.
     */

     //TO-DO: Check if buyer has enough ether before minting
    function mintWithTokenURI(address to, string memory tokenURI) public onlyMinter returns (bool) {
         tokenId = generateTokenID();        
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        return true;
    }





}



}