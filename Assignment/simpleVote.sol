pragma solidity ^0.4.24;

contract simpleVote {
    
    struct voter {
        address voterAddress;
        uint tokenBought;
    }
    struct votes{
        uint total;
        uint votesMyself;
    }
    
    mapping (address => voter) public voters; // 
    mapping (bytes32 => votes) public votesReceived; // 
    
    bytes32[] public candidateNames; // 
    
    uint public totalToken; // 
    uint public balanceTokens; // 
    uint public tokenPrice; // 
    
    constructor(uint _totalToken, uint _tokenPrice) public // 
    {
        totalToken = _totalToken;
        balanceTokens = _totalToken;
        tokenPrice = _tokenPrice;
        
        candidateNames.push("Monday");
        candidateNames.push("Tuesday");
        candidateNames.push("Wednesday");
        candidateNames.push("Thursday");
        candidateNames.push("Friday");
        candidateNames.push("Saturday");
        candidateNames.push("Sunday");
    }
    
    function buy() payable public returns (int) 
    {
        uint tokensToBuy = msg.value / tokenPrice;
        require(tokensToBuy <= balanceTokens);
        voters[msg.sender].voterAddress = msg.sender;
        voters[msg.sender].tokenBought += tokensToBuy;
        balanceTokens -= tokensToBuy;
    }
    
    function getVotesReceivedFor() view public returns (uint, uint, uint, uint, uint, uint, uint)
    {
        return (votesReceived["Monday"].total,
        votesReceived["Tuesday"].total,
        votesReceived["Wednesday"].total,
        votesReceived["Thursday"].total,
        votesReceived["Friday"].total,
        votesReceived["Saturday"].total,
        votesReceived["Sunday"].total);
    }
    
    function getVotesMyself() view public returns (uint, uint, uint, uint, uint, uint, uint)
    {
        return (votesReceived["Monday"].votesMyself,
        votesReceived["Tuesday"].votesMyself,
        votesReceived["Wednesday"].votesMyself,
        votesReceived["Thursday"].votesMyself,
        votesReceived["Friday"].votesMyself,
        votesReceived["Saturday"].votesMyself,
        votesReceived["Sunday"].votesMyself);
    }
    
    function vote(bytes32 candidateName, uint tokenCountForVote) public
    {
        uint index = getCandidateIndex(candidateName);
        require(index != uint(-1));
        
        require(tokenCountForVote <= voters[msg.sender].tokenBought);
        
        votesReceived[candidateName].total += tokenCountForVote;
        votesReceived[candidateName].votesMyself += tokenCountForVote;
        voters[msg.sender].tokenBought -= tokenCountForVote;
    }
    
    function getCandidateIndex(bytes32 candidate) view public returns (uint) // 
    {
        for(uint i=0; i < candidateNames.length; i++)
        {
            if(candidateNames[i] == candidate)
            {
                return i;
            }
        }
        
        return uint(-1); // 
    }
    
    function getCandidatesInfo() view public returns (bytes32[]) // 
    {
        return candidateNames;
    }
    
    function getTotalToken() view public returns(uint)
    {
        return totalToken;
    }
    
    function getBalanceTokens() view public returns(uint)
    {
        return balanceTokens;
    }
    
    function getTokenPrice() view public returns(uint)
    {
        return tokenPrice;
    }
    
    function getTokenBought() view public returns(uint)
    {
        return voters[msg.sender].tokenBought;
    }
}