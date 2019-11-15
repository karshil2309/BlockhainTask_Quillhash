pragma solidity ^0.4.24;

contract TicTacToe1{
    
    address p1;
    address p2;
    
    uint8 cur_mv=0;
    
    enum SqSt{Empty,X,O}
    SqSt[3][3] board;
    
    constructor(address _p2) public
    {
        p1=msg.sender;
        p2=_p2;
        
        require(_p2 != 0x0);
    }   
    function pfMv(uint8 xpos, uint8 ypos) public{
       
       require(msg.sender == p1 || msg.sender == p2);
       require(!isGamefinish());
       require(msg.sender == cur_pladdress());
        
        require(psnInB(xpos, ypos));
        
        require(board[xpos][ypos]==SqSt.Empty);
        board[xpos][ypos]=cur_pl_shap();
        cur_mv=cur_mv+1;
        
    }
    function stToString() public view returns(string)
    {
        return string(abi.encodePacked("\n", rowString(0),"\n",rowString(1),"\n",rowString(2),"\n" ));
    }
    function rowString(uint8 ypos) public view returns(string){
        return string(abi.encodePacked(squareString(0,ypos), "|",squareString(1,ypos), "|",squareString(2,ypos), "|"));
    }
    function squareString(uint8 xpos, uint8 ypos) public view returns(string)
    {
        require (psnInB(xpos, ypos));
        if(board[xpos][ypos] == SqSt.Empty)
        {
            return " ";
        }
        if(board[xpos][ypos] == SqSt.X)
        {
            return "X";
        }
        if(board[xpos][ypos] == SqSt.O)
        {
            return "O";
        }
    }
    function cur_pladdress() public view returns(address)
    {
        if(cur_mv % 2 == 0)
        {
            return p2;
            
        }
        else
        {
            return p1;
        }
    }
    function win() public view returns(address)
    {
        SqSt winsh=winpl();
        if(winsh == SqSt.X)
        {
            return p2;
        }
        else if(winsh == SqSt.O)
        {
            return p1;
            
        }
        return 0x0;
    }
    function isGamefinish() public view returns(bool)
    {
        return (winpl() != SqSt.Empty || cur_mv > 8);
    }
    function psnInB(uint8 xpos, uint8 ypos) public pure returns(bool)
    {
        return(xpos>=0 && xpos<3 && ypos >=0 && ypos<3);
    }
    function winpl() public view returns(SqSt)
    {
        
        if( board[0][0] != SqSt.Empty && board[0][0] == board[0][1] && board[0][0] == board[0][2])
        {
            return board[0][0];
        }
        
        if( board[1][0] != SqSt.Empty && board[1][0] == board[1][1] && board[1][0] == board[1][2])
        {
            return board[1][0];
        }
        
        if( board[2][0] != SqSt.Empty && board[2][0] == board[2][1] && board[2][0] == board[2][2])
        {
            return board[2][0];
        }
        
        //row
        if( board[0][0] != SqSt.Empty && board[0][0] == board[1][0] && board[0][0] == board[2][0])
        {
            return board[0][0];
        }
        
        if( board[0][1] != SqSt.Empty && board[0][1] == board[1][1] && board[0][1] == board[2][1])
        {
            return board[0][1];
        }
        
        if( board[0][2] != SqSt.Empty && board[0][0] == board[1][2] && board[0][2] == board[2][2])
        {
            return board[0][0];
        }
        
        //diag
        if( board[0][0] != SqSt.Empty && board[0][0] == board[1][1] && board[0][0] == board[2][2])
        {
            return board[0][0];
        }
        
        if( board[0][2] != SqSt.Empty && board[0][2] == board[1][1] && board[0][2] == board[2][0])
        {
            return board[0][2];
        }
        
        return SqSt.Empty;
        
    }
    function cur_pl_shap() public view returns(SqSt)
    {
        if(cur_mv%2==0)
        {
            return SqSt.X;
        }
        else
        {
                return SqSt.O;
        }
    }
}
