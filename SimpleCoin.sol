pragma solidity >= 0.7.0 < 0.9.0;

contract coin {
    address public minter;
    mapping (address => uint) public balance;
    event sent (address from, address to, uint amount);
    
    constructor(){
        minter = msg.sender;
    }
    
    function mint(address receiver, uint amount)public{
        require(msg.sender == minter,"Only admin can perform this function");
        require(amount <= 1e60,"Amount can't be more than ...");
        balance[receiver] += amount;
    }
    
    function send(address receiver,uint amount) public{
        require(balance[msg.sender] >= amount,"Insufficent fund");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit sent(msg.sender,receiver,amount);
    }
}
