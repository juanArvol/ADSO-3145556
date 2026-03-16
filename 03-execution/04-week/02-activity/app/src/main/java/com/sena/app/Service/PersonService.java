/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sena.app.Service;

import com.sena.app.IRepository.IPersonRepository;
import org.springframework.stereotype.Service;

/**
 *
 * @author rikyf
 */
@Service
public class PersonService {

    public PersonService() {
        this.repository = repository;
    }
    private final IPersonRepository repository;
}
