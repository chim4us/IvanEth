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
    mapping(address => voter) public voterRegister;
    
    enum State{Created, Voting, Ended}
    State public state;
    
    //modifiers
    modifier condition(bool _condition){
        require(_condition);
        _;
    }
    
    modifier onlyofficial(){
        require(msg.sender ==ballotOfficailAddress);
        _;
    }
    
    modifier instate(State _state){
        require(state == _state);
        _;
    }
    
    //events
    
    //functions
    constructor(
        string memory _ballotOfficialName,
        string memory _proposal
    ){
        ballotOfficailAddress = msg.sender;
        ballotOfficialName = _ballotOfficialName;
        proposal = _proposal;
        
        state = State.Created;
        totalVoter++;
    }
    
    function addVoter(address _voteraddress,string memory _votersname)
    public
    instate(State.Created)
    onlyofficial
    {
        voter memory v;
        v.voterName = _votersname;
        v.voted = false;
        
        voterRegister[_voteraddress] = v;
        
    }
    
    function startVote()
    public
    instate(State.Created)
    onlyofficial
    {
        state = State.Voting;
    }
    
    function doVote(bool _choice)
    public
    instate(State.Voting)
    returns(bool voted)
    {
        bool found = false;
        
        if (bytes(voterRegister[msg.sender].voterName).length != 0 
        && !voterRegister[msg.sender].voted){
            voterRegister[msg.sender].voted = true;
            vote memory v;
            v.voterAddress = msg.sender;
            v.choice = _choice;
            if(_choice){
                countResult ++;
            }
            votes[totalVote] = v;
            totalVote++;
            found = true;
        }
        return found;
        
    }
    
    function endVote()
    public
    instate(State.Voting)
    onlyofficial
    {
        state = State.Ended;
        finalResult = countResult;
    }
}
