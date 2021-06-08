pragma solidity 0.5.12;

contract StructSamples{
    struct Person{
      string Name;
      uint Age;
      uint Hight;
      bool senior;
    }
    
    // mapping (_KeyType => _ValueType) mapping Name
    mapping(address => Person) private Ballances;
    
    
    function AddPerson(string memory name, uint age,uint hight)public{
        Person memory newPerson;
        newPerson.Name = name;
        newPerson.Age = age;
        newPerson.Hight = hight;
        
        if(age > 65){
            newPerson.senior =true;
        }else{
            newPerson.senior = false;
        }
        
        Ballances[msg.sender] = newPerson;
    }
    
    function getPerson ()public view returns (string memory name, uint age,uint hight,bool senior){
        address Creator = msg.sender;
        return(Ballances[Creator].Name, Ballances[Creator].Age, Ballances[Creator].Hight,Ballances[Creator].senior );
    }
}
