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

    //for knowing the balance for each publisher
    mapping (address => uint256) private publisherBalance;
    
    function addBookDetails (string memory _title, string memory _author, 
    string memory _ipfshash, uint256 _isbn, 
    uint256 _saleCommission) private{       
        fileinfo[_isbn].bookTitle = _title;
        fileinfo[_isbn].authorName = _author;
        fileinfo[_isbn].ipfsHash = _ipfshash;
        fileinfo[_isbn].publisherAddress = msg.sender;
        fileinfo[_isbn].saleCommission = _saleCommission;
    }  

    //View Balance for a given publisher
    function viewBalance() public view returns(uint256){
        return publisherBalance[msg.sender];
    }

    //For a publisher to withdraw his earnings through sales and resales from the contract
    function withdrawBalance() public payable{
        (msg.sender).transfer(publisherBalance[msg.sender]);
        publisherBalance[msg.sender] = 0;
    }

}