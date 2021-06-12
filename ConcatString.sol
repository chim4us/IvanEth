pragma solidity 0.8.4;

contract Concat {
    
    string public newString;
    
    function concatStrings(string memory str1, string memory str2) external pure returns(string memory) {
        return string(abi.encodePacked(str1, str2));
    }
    
    function setConcatStrings(string memory str1, string memory str2) external {
        newString = string(abi.encodePacked(str1, str2));
    }
    
}
