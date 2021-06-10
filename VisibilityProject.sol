import "./Ownable.sol";
import "./Destroyable.sol";
pragma solidity 0.5.12;

contract StructSamples is ownable,Destroyable{
    
    //storage : use to store data that is pernament.
    //memory : save during a function execution. after the function executes the variable wont be avaliable 
    //stack : use to holds local variables of value types. Value types are Int, boolen or variables that are less than 256 bytes.
    struct Person{
      string Name;
      uint Age;
      uint Hight;
      bool senior;
    }
    
    uint public balance;
    
    modifier cost (uint _cost){
        require(msg.value >= _cost);
        _;
    }
    
    // mapping (_KeyType => _ValueType) mapping Name
    mapping(address => Person) private People;
    address[] private creators;
    event createdPerson(string Name, bool senior);
    event deletedPerson(string Name, bool senior,address deletedBy );
    
    function AddPerson(string memory name, uint age,uint hight) public payable cost(100 wei){
        require(age < 150,"Age cant be more than 150");
        require(msg.value >= 100 wei,"Value must be 1 ether");
        
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
                    newPerson.senior
                )
            )
        );
        balance += msg.value;
        emit createdPerson(newPerson.Name,newPerson.senior);
    }
    
    function InsertPerson(Person memory newPerson) private{
        address Creator = msg.sender;
        
        //to convert none payable adderess to payable address
        address payable test = address(uint160(Creator));
        
        People[Creator] = newPerson;
    }
    
    function getPerson ()public view returns (string memory name, uint age,uint hight,bool senior){
        address Creator = msg.sender;
        return(People[Creator].Name, People[Creator].Age, People[Creator].Hight,People[Creator].senior );
    }
    
    function deletePerson(address Cretor) public onlyOwner {
        string memory name = People[Cretor].Name;
        bool senior = People[Cretor].senior;
        delete People[Cretor];
        assert(People[Cretor].Age == 0);
        emit deletedPerson(name,senior,owner);
    }
    
    function withdraw() public payable onlyOwner returns(uint amt){
        uint toPayAddr = balance;
        balance = 0;
        msg.sender.transfer(toPayAddr);
        return toPayAddr;
    }
    
    function withdraw2() public payable onlyOwner returns(uint amt){
        uint toPayAddr = balance;
        balance = 0;
        if(msg.sender.send(toPayAddr)){
            return toPayAddr;
        }else{
            balance = toPayAddr;
            return 0;
        }
        
    }
    
    function getCreators(uint index) public view onlyOwner returns (address){
        //require(msg.sender == owner,"Only owner can get creators");
        return(creators[index]);
    }
}
