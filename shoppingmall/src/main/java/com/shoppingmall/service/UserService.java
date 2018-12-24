package com.shoppingmall.service;

import org.springframework.stereotype.Service;

import com.shoppingmall.VO.AuthInfo;
import com.shoppingmall.VO.LoginCommand;


public interface UserService {
	 AuthInfo loginAuth(LoginCommand loginCommand) throws Exception;

}
