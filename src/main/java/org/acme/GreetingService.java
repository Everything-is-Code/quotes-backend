package org.acme;

import java.util.ArrayList;
import java.util.List;

import javax.xml.transform.Source;

import org.acme.model.Quote;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GreetingService {
    
    public String greeting(String name) {
        return "hello " + name;
    }

    public Quote quoteService() {
        Quote quoteOfTheDay = new Quote();
        return quoteOfTheDay;
    }

}