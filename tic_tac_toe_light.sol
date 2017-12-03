pragma solidity ^0.4.0;


contract TicTacToeLight {
    
    struct Move {
        uint x;
        uint y;
    }
    
    address player1;
    address player2;    
    uint GAME_FEE = 10000;
    Move lastMove;
    bytes9 board = 0x000000000;
    
    event DidMove(uint x, uint y);
    event BoardState(bytes9 board, uint shift);
    event Player(address player);

    modifier payedFee { if(msg.value == GAME_FEE) _; }
    modifier gameReady { if(player1 != 0 && player2 != 0) _; }

    function TicTacToeLight() public {
    }
    
    function newGame() public {
        player1 = msg.sender;
        Player(player1);
    }
    
    function joinGame() public {
        player2 = msg.sender;
        Player(player2);
    }
    
    function performMove(uint x, uint y) public gameReady {
       // board = acceptAndApplyLastMove(); // By performing a new Move, the player accepts the last Move
       // lastMove = Move(x,y); // Current move is now the latest Move
       DidMove(x,y);
       bytes9 a = getTurn(msg.sender);
       uint shift = 4 * ((x * 3) + (y * 1)); // Calculate position
       a = a << shift; // Calculate current move in bytes structure
       board = board ^ a; // Apply to board
       BoardState(board, shift);
    }
    
    function getTurn(address currentPlayer) private view returns (bytes9) {
        if (currentPlayer == player1) {
            return 0x000000001;
        }
        if (currentPlayer == player2) {
            return 0x000000002;
        }
    }
    
    // function revokeMove() public {
    //
    //}
    
    // function winMove() public {
    //
    // }

}
