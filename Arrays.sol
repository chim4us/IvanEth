pragma solidity 0.7.5;

contract HelloWorld{
    int[] Number;
    
    function addNumber(int _Number) public {
        Number.push(_Number);
    }
    
    function getNumber(uint _index) public view returns (int){
        return Number[_index];
    }
    
    function getNumbers() public view returns (int[] memory){
        return Number;
    }
}
