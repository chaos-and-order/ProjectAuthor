pragma solidity ^0.5.0;

contract PublishBook {

    

    struct BookInfo{
        string bookTitle;
        string authorName;
        string ipfsHash;
        address publisherAddress;  //Payable address ??
        uint256 saleCommission; //in percent (0-100 integers)
    }

    mapping(uint256 => BookInfo) private fileinfo;


    mapping (uint256 => uint256) private setPrice; //comes from frontend



    //BookInfo private fileinfo;

    function addBookDetails (string memory _title, string memory _author, string memory _ipfshash, uint256 _isbn, uint256 _saleCommission) private{       
        fileinfo[_isbn].bookTitle = _title;
        fileinfo[_isbn].authorName = _author;
        fileinfo[_isbn].ipfsHash = _ipfshash;
        fileinfo[_isbn].publisherAddress = msg.sender;
        fileinfo[_isbn].saleCommission = _saleCommission;
    }  




    


}