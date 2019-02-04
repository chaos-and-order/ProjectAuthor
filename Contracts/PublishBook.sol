pragma solidity 0.5.0;

contract PublishBook {
    struct BookInfo{
        string bookTittle;
        string authorName;
        string ipfsHash;
        address publisherAddress;
    }

    mapping(bytes32 => BookInfo) private fileinfo;

    function addBookDetails (string memory _tittle, string memory _author, string memory _ipfshash, bytes32 _hash) private{       
        fileinfo[_hash].bookTittle = _tittle;
        fileinfo[_hash].authorName = _author;
        fileinfo[_hash].ipfsHash = _ipfshash;
        fileinfo[_hash].publisherAddress = msg.sender;
    }  

    


}