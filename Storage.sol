pragma solidity 0.5.1;

contract Storage{
    uint number;

    function getNumber() internal view returns(uint256){
        return number;
    }

    function setNumber(uint _number) internal{
        number = _number;
    }
}
