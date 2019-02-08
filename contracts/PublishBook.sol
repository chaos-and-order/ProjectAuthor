pragma solidity ^0.5.0;

contract PublishBook {

    

    struct BookInfo{
        string bookTitle;
        string authorName;
        string ipfsHash;
        address publisherAddress;  //Payable address ??
        uint256 saleCommission; //in percent (0-100 integers)
    }

    mapping(string => BookInfo) private fileinfo;  //keyvalue is ISBN, a string; comes from frontend


    mapping (string => uint256) private setPrice; //keyvalue is ISBN, a string; comes from frontend



    //BookInfo private fileinfo;

    function addBookDetails (string memory _title, string memory _author, string memory _ipfshash, string memory _isbn, uint256 _saleCommission) private{       
        fileinfo[_isbn].bookTitle = _title;
        fileinfo[_isbn].authorName = _author;
        fileinfo[_isbn].ipfsHash = _ipfshash;
        fileinfo[_isbn].publisherAddress = msg.sender;
        fileinfo[_isbn].saleCommission = _saleCommission;
    }  




    


}