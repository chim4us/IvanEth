pragma solidity 0.5.12;

contract ownable{
    address internal owner; //internal make variables possible to be assess on external contract but its private on remix or public
    
    modifier onlyOwner (){
        require(msg.sender == owner,"Only owner can delete");
        _;
    }
    
    constructor() public{
        owner = msg.sender;
    }
}
