// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";


contract StakingReward is Ownable {

    IERC20 public rewardsToken;
    IERC20 public stakingToken;

    uint public rewardRate = 100; // amount of tokens that will e minted per second
    uint public lastUpdateTime; // state var keep tracking when the last time this contract was called 
    uint public rewardPerTokenStored; // the summation of reward rate divided by the total supply of token at each given time 

    mapping (address => uint) public userRewardPerTokensPaid;// rewards fot token stored when the user interact with the smart contract 
    mapping(address => uint) public rewards; //when a user stakes more token or withdrawls some token, compute the reward of that user 

    uint private _totalSupply; // total numbet of tokens staked on this contract 
    mapping(address => uint) private _balances; // total number of tokens staked per user.

    event Staked(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 rewardAmount);
    event RewardRateChanged(uint256 newRate);



    constructor(address _stakingToken, address _rewardsToken) {
        stakingToken = IERC20(_stakingToken); 
        rewardsToken = IERC20(_rewardsToken);
    }

    function rewardPerToken() public view returns (uint) { // computes the sum of r over total supply of token stake 
        if (_totalSupply == 0) {
            return 0;
        }
        return rewardPerTokenStored + (
            rewardRate * (block.timestamp - lastUpdateTime) *1e18 / _totalSupply
        );
    
    }
    function earned(address account) public view returns (uint) {  // how much reward token has earned so far
        return (
            _balances[account] * (rewardPerToken() - userRewardPerTokensPaid[account]) / 1e18
            ) + rewards[account];
    }
    modifier updateReward(address account) { 
        rewardPerTokenStored = rewardPerToken(); //update the reward per token stored
       lastUpdateTime = block.timestamp;

       rewards[account] = earned(account); // the amount of token that the user can claim so far  and storing the output 
       userRewardPerTokensPaid[account] = rewardPerTokenStored;
       _;
    }
    function stake(uint256 _amount) external updateReward(msg.sender) {
    _totalSupply += _amount;
    _balances[msg.sender] += _amount;
    stakingToken.transferFrom(msg.sender, address(this), _amount);

    emit Staked(msg.sender, _amount);

    }
    function withdraw (uint _amount ) external updateReward(msg.sender) {
        _totalSupply -= _amount;
        _balances[msg.sender] -= _amount;
        stakingToken.transfer(msg.sender, _amount);

        emit Withdrawn(msg.sender, _amount);

    }
    function getReward() external updateReward(msg.sender) {
        uint reward = rewards[msg.sender];
        rewards[msg.sender] = 0;
        rewardsToken.transfer(msg.sender, reward);

        emit RewardPaid(msg.sender, reward);

    }
    function setRewardRate(uint _rewardRate) external onlyOwner {
        rewardRate = _rewardRate;

        emit RewardRateChanged(_rewardRate);

    }
}

interface IERC20 {
    function totalSupply () external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns(bool);
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns(bool);
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}