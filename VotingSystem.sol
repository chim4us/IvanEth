pragma solidity >= 0.7.0 < 0.9.0;

contract Ballot{
    //variables
    struct vote{
        address voterAddress;
        bool choice;
    }
    
    struct voter{
        string voterName;
        bool voted;
    }
    
    uint private countResult = 0;  //used to count votes as they are coming in
    uint public finalResult = 0; //Used to output what ever on countResult
    uint public totalVoter = 0; //used to keep count of all voters
    uint public totalVote = 0; //used to keep count of all vote
    
    address public ballotOfficailAddress; //The officail address of this contract
    string public ballotOfficialName;
    string public proposal;
    
    mapping(uint => vote) private votes;
    mapping(address => voter) public voterRegistered;
    
    enum State{Created, Voting, Ended}
    State public state;
    
    //modifiers
    
    //events
    
    //functions
    constructor(){
        
    }
    
    function addVoter()public{
        
    }
    
    function startVote()public{
        
    }
    function doVote()public{
        
    }
    function endVote()public{
        
    }
}
