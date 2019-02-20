pragma solidity ^0.5.0;
import "./PublishBook.sol";
import "./Address.sol";
import "./SafeMath.sol";
import "./Counters.sol";


contract Tokenize is PublishBook {

    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) internal _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) internal _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => Counters.Counter) internal _ownedTokensCount;



    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event BookPublished(address indexed publisher, uint256 indexed isbn);
    
    uint256 tokenCounter; //arbitrary counter to help generate unique tokenID


    struct Reselling{
        uint256 resalePrice;
        bool isUpForResale;
        uint256 ISBN;
    }

    //tokenID to Reselling mapping
    mapping (uint256 => Reselling) internal reSale;

    //This will be the tokendata.
    struct tokenIPFS{
        string ipfsHash; 
    }

    //tokenId to tokenIPFS mapping
    mapping(uint256 => tokenIPFS) internal tokenData;  
    

    /**
     * @dev Gets the token name
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return "DContentToken";
    }

    /**
     * @dev Gets the token symbol
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return "DCT";
    }

    //function to check if tokenId exists with a user
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    //function to check who the owner of a token is
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0));
        return owner;
    }

       
    //tokenId a value that will be less than 10,000,000 
    function generateTokenID(uint256 isbn) private returns(uint256){
        tokenCounter++;
        uint256 tokenid = uint256(keccak256(abi.encodePacked(isbn, now,tokenCounter))) % 10000000;
        return(tokenid);
    }

   //function that creates the token
    function _mint(address to, uint256 tokenId, uint256 isbn) internal {
        require(to != address(0),"Address(0) Error !");
        require(!_exists(tokenId),"Token ID already exists !");
        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        //resalePrice set to initial MRP by default
        reSale[tokenId].resalePrice = setPrice[isbn];
        //token is not up for resale by default; the owner needs to put it up for sale
        reSale[tokenId].isUpForResale = false;
        reSale[tokenId].ISBN = isbn;
        tokenData[tokenId].ipfsHash = fileinfo[isbn].ipfsHash;        
        
        emit Transfer(address(0), to, tokenId);
    }


    //function to add book details into the chain i.e. publish the book
    function addBookDetails (string memory _ipfshash, uint256 _isbn, uint256 _price, uint256 _saleCommission) public {
        require(fileinfo[_isbn].publisherAddress==address(0), "This book has already been published!");
        fileinfo[_isbn].ipfsHash = _ipfshash;
        fileinfo[_isbn].publisherAddress = msg.sender;
        fileinfo[_isbn].saleCommission = _saleCommission;
        setPrice[_isbn] = _price*1 wei;
        emit BookPublished(msg.sender, _isbn);
  
    }  

    //function to get all cash stored in contract back into the respective owners' account
    function withdrawBalance() public payable{
        require(publisherBalance[msg.sender]!=0, "You don't have any balance to withdraw");    
        (msg.sender).transfer(publisherBalance[msg.sender]);
        publisherBalance[msg.sender] = 0;
    }

    //function that executes the first purchase of token from the contract
    function primaryBuy(uint isbn) public payable returns (bool) {
        //to revert back if the buyer doesn't have the price by the author.
        require(fileinfo[isbn].publisherAddress != address(0),"ISBN does not exist !");
        require(msg.value == setPrice[isbn],"Insufficient funds ! Please pay the price as set by the author.");
        uint256 tokenId = generateTokenID(isbn);       
        _mint(msg.sender, tokenId,isbn);
        //publisher's balance gets updated    
        publisherBalance[fileinfo[isbn].publisherAddress] += msg.value;
        return true;
    }  


}
