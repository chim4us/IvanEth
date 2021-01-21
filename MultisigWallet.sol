pragma solidity 0.7.5;

contract Multiwallet{
    address private owner1;
    address private owner2;
    address private owner3;
    uint private ContrctBalance;
    
    event depositDone(uint amount, address indexed DepositedTo);
    event SubmitWit(uint amount, address indexed Adr,uint txid,address reqstr);
    event SignedTran(uint amount, address indexed Adr,uint txid,address reqstr);
    
    //Transaction pools struct
    struct TransactionPool{
        address payable To;
        uint Amount;
        bool Sing1;
        address SingAdr1;
        bool Sing2;
        address SingAdr2;
        uint txid;
        bool status;
    }
    
    TransactionPool[] transactionlog;
    
    constructor(address _owner2,address _owner3){
        owner1 = msg.sender;
        owner2 = _owner2;
        owner3 = _owner3;
    }
    
    function Deposit() public payable{
        require(msg.value > 0);
        
        _transfer(msg.value);
        
        emit depositDone(msg.value,msg.sender);
    }
    
    function _transfer( uint _amt) private{
        ContrctBalance  += _amt;
    }
    
    function SubmitTrn(uint _SAmt,address payable _adrs)public returns(uint){
        require(ContrctBalance >= _SAmt ,"Insufficient Balance");
        TransactionPool memory newTransaction;
        newTransaction.To = _adrs;
        newTransaction.Amount = _SAmt;
        newTransaction.Sing1 = false;
        newTransaction.SingAdr1 = address(0);
        newTransaction.Sing2 = false;
        newTransaction.SingAdr2 = address(0);
        newTransaction.status = false;
        newTransaction.txid = transactionlog.length;
        
        transactionlog.push(newTransaction);
        
        emit SubmitWit(_SAmt,_adrs,transactionlog.length,msg.sender);
        
        return(transactionlog.length);
    }
    
    function signMsg(uint idex) public Owers{
        require(transactionlog[idex].status != true ,"Transaction already signed");
        if(transactionlog[idex].Sing1 == false){
            transactionlog[idex].Sing1 = true;
            transactionlog[idex].SingAdr1 = msg.sender;
        }else{
            transactionlog[idex].Sing2 = true;
            transactionlog[idex].SingAdr2 = msg.sender;
            SendTrn(idex);
            transactionlog[idex].status = true;
        }
        
    }
    
    function SendTrn(uint _idex)private{
        
        transactionlog[_idex].To.transfer(transactionlog[_idex].Amount);
        ContrctBalance -= transactionlog[_idex].Amount
    
        ;
        
    }
    
    function GetContractBal() public view returns(uint){
        return(ContrctBalance);
    }
    
    modifier onlyOwner{
        require(owner1 == msg.sender,"Your not the owner");
        _;
    }
    
    modifier Owers{
        require(owner1 == msg.sender || owner2 == msg.sender || owner3 == msg.sender,"You can't sign this transaction ");
        _;
    }
    
}
