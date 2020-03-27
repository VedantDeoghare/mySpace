// vcoins ICO
pragma solidity ^ 0.6.1;

contract vcoin_ICO {
    // introducing the total number vcoin available for sale
    uint public max_vcoin = 1000000; 
    
    //introducing ruppees to vcoin conversion rate 
    //1rs = 100vcoins
    uint public rs_to_vcoin = 100;
    
    //introducing the total number of vcoin bought by investors
    uint public total_vcoin_bought = 0;
    
    mapping(address => uint) equity_vcoin;
    mapping(address => uint) equity_rs;
    
    //check if the investors can buy vcoin
    modifier can_buy_vcoin(uint rs_invested) {
        require(rs_invested*rs_to_vcoin + total_vcoin_bought <= max_vcoin);
        _;
    }
    
    function equity_in_vcoin(address investor) public view returns (uint) {
        return equity_vcoin[investor];
    }
    
     function equity_in_rs(address investor)  public view returns (uint) {
        return equity_rs[investor];
    }
    
    //buying vcoin
    
    function buy_vcoin(address investor,uint rs_invested) external can_buy_vcoin(rs_invested) {
       uint vcoin_bought = rs_invested*rs_to_vcoin;
        equity_vcoin[investor] += vcoin_bought;
        equity_rs[investor] = equity_vcoin[investor]/100;
        total_vcoin_bought += vcoin_bought;
    }
        
    //selling vcoins
    
     function sell_vcoin(address investor,uint vcoin_to_sell) external 
     {
        equity_vcoin[investor] -= vcoin_to_sell;
        equity_rs[investor] = equity_vcoin[investor]/100;
        total_vcoin_bought -= vcoin_to_sell;
    }
    
}