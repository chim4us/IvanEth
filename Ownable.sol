pragma solidity 0.5.12;

contract ownable{
    address payable internal owner; //internal make variables possible to be assess on external contract but its private on remix or public
    //address payable public owner;
    bool private _paused;
    
    modifier onlyOwner (){
        require(msg.sender == owner,"Only owner have access to this");
        _;
    }
    
    modifier whenNotPause(){
        require(!_paused);
        _;
    }
    
    modifier whenPause(){
        require(_paused);
        _;
    }
    
    function pause()public onlyOwner whenNotPause{
        _paused = true;
    }
    
    function unpause()public onlyOwner whenPause{
        _paused = false;
    }
    
    constructor() public{
        owner = msg.sender;
        _paused = false;
    }
}
