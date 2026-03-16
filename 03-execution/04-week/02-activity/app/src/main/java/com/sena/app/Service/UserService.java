package com.sena.app.Service;

import com.sena.app.IRepository.IUserRepository;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author rikyf
 */
public class UserService {
    @Autowired
    private IUserRepository repository;
    
}
