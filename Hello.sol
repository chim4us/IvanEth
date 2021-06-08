pragma solidity 0.5.12;

contract HelloWorld{
    //How to set variables
    string private message = "Hello World";
    uint private number = 123;
    bool private isHappy = true;
    address private contractAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    
    struct Person{
      uint id;
      string Name;
      uint age;
      uint hight;
      address walletAddr;
    }
    
    //How to set arrays
    uint[] public numbers = [1,2,3,4,5,5,6];
    string[] public messages = ["Hello","Hi","Ada"];
    
    function getMessage() private view returns(string memory){
        return message;
    }
    
    function setMessage(string memory newMessage) private{
        message = newMessage;
    }
    
    function getNumber(uint index) public view returns(uint){
        return numbers[index];
    }
    
    function setNumber(uint newNumber,uint index) public{
        numbers[index] = newNumber;
    }
    
    function addNumber(uint newNumber)public{
        numbers.push(newNumber);
    }
}
