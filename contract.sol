pragma solidity ^0.5.2;
    contract ERC20Interface {
        string public name;
        string public symbol;
        uint8 public decimals;
        uint256 public totalSupply;
        
        function transfer(address _to, uint256 _value) public returns (bool success);
        function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
        function approve(address _spender, uint256 _value) public returns (bool success);
        function allowance(address _owner, address _spender) public view returns (uint256 remaining);
        
        event Transfer(address indexed _from, address indexed _to, uint256 _value);
        event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    }
    
    contract YFHContract is ERC20Interface {
        mapping (address => uint256) public balanceOf;
        mapping (address => mapping (address => uint256) ) internal allowed;
        using SafeMath for uint256;
        
        constructor() public {
            name = "YFHub.org";
            symbol = "YFH";
            decimals = 18;
            totalSupply = 50000 * (10 ** 18);
            balanceOf[msg.sender] = totalSupply;
        }
    
        function transfer(address _to, uint256 _value) public returns (bool success) {
            require(_to != address(0));
            require(balanceOf[msg.sender] >= _value);
            require(balanceOf[_to] + _value >= balanceOf[_to]);
            
            balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);
            balanceOf[_to] = balanceOf[_to].add(_value);
            emit Transfer(msg.sender, _to, _value);
            success = true;
        }
    
        function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
            require(_to != address(0));
            require(balanceOf[_from] >= _value);
            require(allowed[_from][msg.sender]  >= _value);
            require(balanceOf[_to] + _value >= balanceOf[_to]);
            
            balanceOf[_from] = balanceOf[_from].sub(_value); 
            balanceOf[_to] = balanceOf[_to].add(_value); 
            allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value); 
            emit Transfer(_from, _to, _value);
            success = true;
        }
    
        function approve(address _spender, uint256 _value) public returns (bool success) {
            require((_value == 0)||(allowed[msg.sender][_spender] == 0));
            allowed[msg.sender][_spender] = _value;
            emit Approval(msg.sender, _spender, _value);
            success = true;
        }
    
        function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
            return allowed[_owner][_spender];
        }
    }
    
    library SafeMath {
        function add(uint a, uint b) internal pure returns (uint) {
            uint c = a + b;
            require(c >= a, "SafeMath: addition overflow");
    
            return c;
        }
        function sub(uint a, uint b) internal pure returns (uint) {
            return sub(a, b, "SafeMath: subtraction overflow");
        }
        function sub(uint a, uint b, string memory errorMessage) internal pure returns (uint) {
            require(b <= a, errorMessage);
            uint c = a - b;
    
            return c;
        }
        function mul(uint a, uint b) internal pure returns (uint) {
            if (a == 0) {
                return 0;
            }
    
            uint c = a * b;
            require(c / a == b, "SafeMath: multiplication overflow");
    
            return c;
        }
        function div(uint a, uint b) internal pure returns (uint) {
            return div(a, b, "SafeMath: division by zero");
        }
        function div(uint a, uint b, string memory errorMessage) internal pure returns (uint) {
            // Solidity only automatically asserts when dividing by 0
            require(b > 0, errorMessage);
            uint c = a / b;
    
            return c;
        }
    }
