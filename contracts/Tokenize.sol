pragma solidity ^0.5.0;
import "./IERC721.sol";
import "./PublishBook.sol";


contract Tokenize is IERC721, PublishBook {

    uint256 isbn;   //assuming we get this value from somewhere in the system
    //uint256 counter = 0; //will be used later. Not used for tokenId  generation now.


    //tokenId resolved, hopefully
    uint256 tokenId;
    tokenId = uint256(keccak256(abi.encodePacked(isbn, now))%10000000);

    
    
    //assuming tokenId is resolved:

    address to = msg.sender;  //the person who clicks the 'buy' button. Not the publisher

    function _mint(address to, uint256 tokenId) internal {
        
         require(to != address(0));
         require(!_exists(tokenId));

        // _tokenOwner[tokenId] = to;
        // _ownedTokensCount[to].increment();

        // emit Transfer(address(0), to, tokenId);
    }


    /**
     * @dev Internal function to set the token URI for a given token
     * Reverts if the token ID does not exist
     * @param tokenId uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        // require(_exists(tokenId));
        // _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Function to mint tokens
     * @param to The address that will receive the minted tokens.
     * @param tokenId The token id to mint.
     * @param tokenURI The token URI of the minted token.
     * @return A boolean that indicates if the operation was successful.
     */
    function mintWithTokenURI(address to, uint256 tokenId, string memory tokenURI) public onlyMinter returns (bool) {
        // _mint(to, tokenId);
        // _setTokenURI(tokenId, tokenURI);
        // return true;
    }





}



}