pragma solidity 0.5.12;

contract StructSamples{
    struct Person{
      string Name;
      uint Age;
      uint Hight;
      bool senior;
    }
    
    address owner;
    
    constructor() public{
        owner = msg.sender;
    }
    
    // mapping (_KeyType => _ValueType) mapping Name
    mapping(address => Person) private People;
    address[] private creators;
    
    
    function AddPerson(string memory name, uint age,uint hight)public{
        require(age <= 150,"Age cant be more than 150");
        Person memory newPerson;
        newPerson.Name = name;
        newPerson.Age = age;
        newPerson.Hight = hight;
        
        if(age > 65){
            newPerson.senior =true;
        }else{
            newPerson.senior = false;
        }
        InsertPerson(newPerson);
        creators.push(msg.sender);
        
        //This Assert will revert transaction if the condition on it did not implement
        //We use it to check if our code did what we want it to do
        assert(
            keccak256(abi.encodePacked(
                People[msg.sender].Name,
                People[msg.sender].Age,
                People[msg.sender].Hight,
                People[msg.sender].senior)) == 
                keccak256(abi.encodePacked(
                    newPerson.Name,
                    newPerson.Age,
                    newPerson.Hight,
                    newPerson.senior)));
    }
    
    function InsertPerson(Person memory newPerson) private{
        address Creator = msg.sender;
        People[Creator] = newPerson;
        assert(People[Creator].Age == 0);
    }
    
    function getPerson ()public view returns (string memory name, uint age,uint hight,bool senior){
        address Creator = msg.sender;
        return(People[Creator].Name, People[Creator].Age, People[Creator].Hight,People[Creator].senior );
    }
    
    function deletePerson(address Cretor) public {
        require(msg.sender == owner,"Only owner can delete");
        delete People[Cretor];
    }
    
    function getCreators(uint index) public view returns (address){
        require(msg.sender == owner,"Only owner can get creators");
        return(creators[index]);
    }
}
