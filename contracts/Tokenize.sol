pragma solidity ^0.5.0;
import "./IERC721.sol";
import "./PublishBook.sol";


contract Tokenize is IERC721, PublishBook {

    uint256 isbn;   //assuming we get this value from somewhere in the system
    uint256 counter = 0;


    //won't work. gotta find a more elegant solution
    uint256 tokenId = uint256(string(isbn)+string(counter));

    


}