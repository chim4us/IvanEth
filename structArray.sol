pragma solidity 0.5.12;

contract StructSamples{
    
    struct Person{
      uint id;
      string Name;
      uint age;
      uint hight;
      address walletAddr;
    }
    
    Person[] public people;
    
    function AddPerson(string memory name, uint age,uint hight)public{
        people.push(Person(people.length,name,age,hight,msg.sender));
    } 
    
    function AddPerson2(string memory name, uint age,uint hight)public{
        Person memory newPerson;
        newPerson.id = people.length;
        newPerson.Name = name;
        newPerson.age = age;
        newPerson.hight = hight;
        newPerson.walletAddr = msg.sender;
        people.push(newPerson);
    } 
}
