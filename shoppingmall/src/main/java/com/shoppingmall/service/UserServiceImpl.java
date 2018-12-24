package com.shoppingmall.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shoppingmall.DAO.UserDAO;
import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.LoginCommand;
import com.shoppingmall.VO.UserVO;
import com.shoppingmall.exception.IdPasswordNotMatchingException;


@Service("userService")
public class UserServiceImpl implements UserService {
	@Resource(name="userDAO")
    private UserDAO userDAO;
 
    @Override
    public AuthInfo loginAuth(LoginCommand loginCommand) throws Exception {
        UserVO user = userDAO.selectById(loginCommand.getId());
        if(user == null) {
            throw new IdPasswordNotMatchingException();
        }
        if(!user.matchPassword(loginCommand.getPw())) {
            throw new IdPasswordNotMatchingException();
        }
        return new AuthInfo(user.getId(), user.getName());
    }
}
