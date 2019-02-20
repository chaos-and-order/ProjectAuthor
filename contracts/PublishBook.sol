pragma solidity ^0.5.0;

contract PublishBook {

    
//struct to store book details
    struct BookInfo{
        string ipfsHash;
        address publisherAddress; 
        uint256 saleCommission;
    }
    
    //ISBN is the keyvalue, to store the book details
    mapping(uint256 => BookInfo) internal fileinfo;  
    //ISBN is the keyvalue, to store the price of the token for initial buy
    mapping (uint256 => uint256) internal setPrice; 

    //for knowing the balance for each publisher
    mapping (address => uint256) internal publisherBalance;
    
}