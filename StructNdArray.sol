pragma solidity 0.7.5;


contract HelloWorld{
    
    struct Person{
        int age;
        string name;
    }
    
    Person[] people;
    
    function addPerson(int _age, string memory _name) public {
        Person memory newPerson = Person(_age,_name);
        people.push(newPerson);
    }
    
    function getPerson(uint _index) public view returns(int, string memory ){
        Person memory PersonToreturn = people[_index];
        return (PersonToreturn.age, PersonToreturn.name);
    }
}
