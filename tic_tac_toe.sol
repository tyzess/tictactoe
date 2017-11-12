pragma solidity ^0.4.0;


contract TicTacToe {

    uint public constant BOARD_SIZE = 3;
    uint public constant MAX_PLAYERS = 2;
    uint public constant BUY_IN = 100;
    uint public constant PRIZE = BUY_IN * 2;

    uint public playerCount = 0;
    uint public gameNumber = 0;

    mapping (address => uint) deposits;

    enum Token {NONE, X, O}
    
    Token public currentToken = Token.NONE;

    mapping (uint => mapping (uint => Token)) board;

    mapping (uint => address) tokenToPlayer;

    function getPlayer1() public view returns (address){
        return tokenToPlayer[uint(Token.X)];
    }

    function getPlayer2() public view returns (address){
        return tokenToPlayer[uint(Token.O)];
    }


    function TicTacToe() public {
        resetGame();
    }

    function resetGame() private {
        currentToken = Token.NONE;

		board[0][0] = Token.NONE;
		board[0][1] = Token.NONE;
		board[0][2] = Token.NONE;
		board[1][0] = Token.NONE;
		board[1][1] = Token.NONE;
		board[1][2] = Token.NONE;
		board[2][0] = Token.NONE;
		board[2][1] = Token.NONE;
		board[2][2] = Token.NONE;

        playerCount = 0;
        tokenToPlayer[1] = 0x0;
        tokenToPlayer[2] = 0x0;
    }

    function join() public payable returns (bool) {
        if (msg.value != BUY_IN) { // Exit if price isn't payed exactly
        	return false;
        }
        
        if (playerCount == MAX_PLAYERS) { // Exit if all players already joined
            return false;
        }

        playerCount++;
        tokenToPlayer[playerCount] = msg.sender;

        if (playerCount == MAX_PLAYERS) { // Init currentToken if all players joined
            currentToken = Token.X;
        }
        return true;
    }

    function setToken(uint x, uint y) public returns (bool) {
        if (x >= BOARD_SIZE || y >= BOARD_SIZE) { // Exit if out of bounds
        	return false;
        }

        if (board[x][y] != Token.NONE) { // Exit if already set
            return false;
        }
        
        if (msg.sender != tokenToPlayer[uint(currentToken)]) { // Exit if not your turn
			return false;
		}

        board[x][y] = currentToken;

        if (playerWon()) {
            payOutWinner(getCurrentPlayer());
            resetGame();
        } else {
            nextTurn();
        }
        return true;
    }

    function getCurrentPlayer() public view returns (address) {
        return tokenToPlayer[uint(currentToken)];
    }

    function nextTurn() private {
        uint token = uint(currentToken);
        token++;
        if (token > MAX_PLAYERS) {
            token = uint(Token.X);
        }
        currentToken = Token(token);
    }

    function getToken(uint x, uint y) public view returns (uint){
        require(x < BOARD_SIZE && y < BOARD_SIZE);
        return uint(board[x][y]);
    }

    function hasWonInAnyRow(uint token) private view returns (bool){
        return (uint(board[0][0]) == token &&
                uint(board[0][1]) == token &&
                uint(board[0][2]) == token) ||
               (uint(board[1][0]) == token &&
                uint(board[1][1]) == token &&
                uint(board[1][2]) == token) ||
               (uint(board[2][0]) == token &&
                uint(board[2][1]) == token &&
                uint(board[2][2]) == token);
    }

    function hasWonInAnyColumn(uint token) private view returns (bool){
        return (uint(board[0][0]) == token &&
                uint(board[1][0]) == token &&
                uint(board[2][0]) == token) ||
               (uint(board[0][1]) == token &&
                uint(board[1][1]) == token &&
                uint(board[2][1]) == token) ||
               (uint(board[0][2]) == token &&
                uint(board[1][2]) == token &&
                uint(board[2][2]) == token);

	
    }

    function checkRowsAndColumns(uint token) private view returns (bool) {
	uint countRow = 0;
	uint countColumn = 0;
	for (uint x = 0; x < BOARD_SIZE; x++) {
	    for (uint y = 0; y < BOARD_SIZE; y++) {
        	if (uint(board[x][y]) == token) {
                    countRow++;
                }
		if (uint(board[y][x]) == token) {
                    countColumn++;
                }
	    }
	    if (countRow == BOARD_SIZE || countColumn == BOARD_SIZE) {
		return true;
	    }
	    countRow = 0;
 	    countColumn = 0;
        }
	return false;
    }



    function checkDiagonal(uint token) private view returns (bool){
        return (uint(board[0][0]) == token && 
                uint(board[1][1]) == token && 
                uint(board[2][2]) == token) ||
	       (uint(board[2][0]) == token && 
                uint(board[1][1]) == token && 
                uint(board[0][2]) == token);
    }

    function playerWon() private view returns (bool){
        uint token = uint(currentToken);
        return checkRowsAndColumns(token) || checkDiagonal(token);
    }

    function payOutWinner(address winner) private {
        gameNumber++;
        deposits[winner] += PRIZE;
    }

}
