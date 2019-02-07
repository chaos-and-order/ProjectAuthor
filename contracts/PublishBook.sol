pragma solidity ^0.5.0;

contract PublishBook {

    

    struct BookInfo{
        string bookTitle;
        string authorName;
        string ipfsHash;
        address publisherAddress;
    }

    mapping(uint256 => BookInfo) private fileinfo;

    //BookInfo private fileinfo;

    function addBookDetails (string memory _title, string memory _author, string memory _ipfshash, uint256 _isbn) private{       
        fileinfo[_isbn].bookTitle = _title;
        fileinfo[_isbn].authorName = _author;
        fileinfo[_isbn].ipfsHash = _ipfshash;
        fileinfo[_isbn].publisherAddress = msg.sender;
    }  

    


}