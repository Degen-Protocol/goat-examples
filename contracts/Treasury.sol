// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/*
                                          ,ooooooooooo,
                                       ,;OOOOOOOOOOOOOOo,
                                    ,ooOOOOOOOOOOOOOOOOOo;,,,,
                                ,ooooOOOOOOOOOOOOOOOOOOOOooo(@`,
                     _  __   __;oooooo OOOOOOOOOOO; ;@@@@@@@o;@@`,
            _______/@@@@@@@@@)ooOOOOOO) oOOOOOOOOOo; ;o@@@@@o;@@@:
           /######)@@@@@@@@@@( _______ ( oOOOOOOOOOOo o@@@@@@`@@@`;
          <######)@@@@@@@@@@@@(######/  `,;;;  oOOOOOo @@@@@@o,\@@;
               `\@@@@@@@@@@@@(######/ oO (@@@@\ oOOOOO;@@@@@@@, \@`,
                ))@@@@@@@@@@(       oOOOo@@@@@@: ;;oo,`o@@@@@;   (@)
                )  `@@@@@@@( (  ooOOOOOoo:@@@@@: ,' /###o@@@@;
                ( (0)     (0) ) ooooooo /@@@@@/,`  :####o@@@@;
                 )           ( `'`'`'`'/@@@@@/     /###/:@@@@;
                  `,       ,'     /###/@@@@@/     :###; :@@@@@;
                    \_`_'_/      /###/@@@@/       :###; :@@@@@;
                     ~~~~~      ;###;@@@@/        :##;  `:@@@@;
                                ;###;@@@@;       /  /    :@@@;
                               /~~~~;@@@@;      `-^-'    /   \
                               `-^--;@@@@/               `-^--'
                                    :~~~~:
                                    \/\_/

        Degen Protocol GOAT
        Single Asset Silo - v1.0.0
*/

import "./IERC20.sol";

import "./Whitelist.sol";

contract Treasury is Whitelist {

    IERC20 public token;

    string public label;

    constructor(address token_addr, string memory _label) {
        token = IERC20(token_addr);
        label = _label;
    }

    function getBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function withdraw(uint256 _amount) external onlyWhitelisted {
        require(token.transfer(_msgSender(), _amount));
    }

    function withdrawTo(address _to, uint256 _amount) external onlyWhitelisted {
        require(token.transfer(_to, _amount));
    }
}