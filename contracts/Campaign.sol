
contract Campaign {
    address public owner;
    string public description;
    Reward[] public rewards;
    uint public endDate;
    uint public goal;
    uint public current;
    bool public success;
    
    struct Reward {
        string description;
        uint price;
        mapping (address => uint) orders;
    }
    
    modifier onlyOwner() {
        if(msg.sender != owner) throw;
        _
    }
    
    modifier open() {
        if(now > endDate) throw;
        _
    }
    
    modifier closed() {
        if(now <= endDate) throw;
        _
    }
    
    // Executé une seule fois à la création du contrat
    function Campaign(string desc, uint end, uint g) {
        owner = msg.sender;
        description = desc;
        endDate = end;
        goal = g;
    }
    
    // Changer la description
    function setDescription(string desc) onlyOwner() {
        description = desc;
    }
    
    function addReward(string desc, uint price) onlyOwner() {
        rewards.push(Reward(desc, price));
    }
    
    function buyReward(uint rId, uint quantity) open() {
        if(msg.value < rewards[rId].price * quantity) throw;
        rewards[rId].orders[msg.sender] += quantity;
        current += rewards[rId].price * quantity;
        msg.sender.send(msg.value - rewards[rId].price * quantity);
    }
    
    function getResult() {
        if(now < endDate) throw;
        if(current >= goal) {
            success = true;
        }
    }
    
    function withdrawFunds() onlyOwner() {
        if(success) {
            msg.sender.send(this.balance);
        }
    }
    
    function claimFunds() closed() {
        if(!success) {
            uint funds = 0;
            for(uint i = 0; i < rewards.length; i++) {
                funds += rewards[i].orders[msg.sender] * rewards[i].price;
            }
            msg.sender.send(funds);
        }
    }
    
    function getRewardDescription(uint index) constant returns(string) {
        return rewards[index].description;
    }
    
    function getRewardPrice(uint index) constant returns(uint) {
        return rewards[index].price;
    }
    
    function getRewardCount() constant returns(uint) {
        return rewards.length;
    }
}