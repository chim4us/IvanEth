pragma solidity 0.5.12;

///First create interface 
contract StructSamples{
    function AddPerson(string memory name, uint age,uint hight) public payable;
    function getPerson () public returns (string memory name, uint age,uint hight,bool senior);
}

contract ExternalAddPerson{
    StructSamples instance = StructSamples(0x9d83e140330758a8fFD07F8Bd73e86ebcA8a5692);
    
    function ExAdd(string memory name, uint age,uint hight)public payable{
        instance.AddPerson.value(msg.value)(name,age,hight);
    }
    
    function ExGetPrs() public returns (string memory name, uint age,uint hight,bool senior){
        //string memory Name = instance.getPerson().Name;
        //return Name;
        
        //People[Creator].Name, People[Creator].Age, People[Creator].Hight,People[Creator].senior 
    }
}
