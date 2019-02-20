pragma solidity ^0.5.0;
//Tested in Remix
import "remix_tests.sol";
import "./Resale.sol";

contract authorTest{
    Resale projTest;
    
    function beforeAll() public{
        projTest = new Resale();
        
    }
    
    function checkName() public{
        Assert.equal(projTest.name(),"DContentToken","DCToken should be the correct name");
    }
    
    function checkSymbol() public{
        Assert.equal(projTest.symbol(),"DCT","DCT should be the correct symbol");
    }
    
    
    
    
}
