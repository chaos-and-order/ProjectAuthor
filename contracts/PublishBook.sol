pragma solidity ^0.5.0;

contract PublishBook {

    

    struct BookInfo{
        string bookTitle;
        string authorName;
        string ipfsHash;
        address publisherAddress;  //Payable address ??
        uint256 saleCommission; //in percent (0-100 integers)
    }

    mapping(uint256 => BookInfo) private fileinfo; //ISBN is the keyvalue, taken as int 

    mapping (uint256 => uint256) private setPrice; //ISBN is the keyvalue, taken as int

    //to retrieve commission for a givenbook for secondary sales
    //mapping(uint256 => uint256) private saleCommission; //in percent (0-100 integers)

    //BookInfo private fileinfo;

    function addBookDetails (string memory _title, string memory _author, 
    string memory _ipfshash, uint256 _isbn, 
    uint256 _saleCommission) private{       
        fileinfo[_isbn].bookTitle = _title;
        fileinfo[_isbn].authorName = _author;
        fileinfo[_isbn].ipfsHash = _ipfshash;
        fileinfo[_isbn].publisherAddress = msg.sender;
        fileinfo[_isbn].saleCommission = _saleCommission;
    }  




    


}