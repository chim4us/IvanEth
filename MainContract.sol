pragma solidity 0.5.1;

import "./Storage.sol";

contract ProxyNum is Storage{
    address public currentAddress;

    constructor (address _currentAddress) public{
        currentAddress = _currentAddress;
    }

    function upgrade(address _currentAddress) public {
        currentAddress = _currentAddress;
    }

    function getNumberToget() public returns(bool,bytes memory){
        (bool res, bytes memory data) = currentAddress.delegatecall(
        abi.encodePacked(bytes4(keccak256("getNumberofNum()")))
        );
        return(res,data);
    }

    function getNumberToset(uint _num) public returns(bool,bytes memory){
        (bool res, bytes memory data) = currentAddress.delegatecall(
        abi.encodePacked(bytes4(keccak256("setNumberofNum(uint)")),_num)
        );
        return(res,data);
    }
}
