pragma solidity 0.5.1;

import "./Storage.sol";

contract Number is Storage{

    function getNumberofNum() public view returns(uint){
        return Storage.getNumber();
    }

    function setNumberofNum(uint _number) public{
        Storage.setNumber(_number);
    }
}
