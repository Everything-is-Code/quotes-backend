package org.acme.util;

import java.util.List;
import java.util.Random;

import org.acme.model.Quote.Source;

public class RandomQuoteProvider implements Source<String>
{
    private final Random randomNumberGenerator;

    private final List<String> quotes;


    public RandomQuoteProvider(List<String> quotes)
    {
        this.quotes = quotes;
        this.randomNumberGenerator = new Random();
    }

    @Override
    public String getNext()
    {
        return this.quotes.get(this.randomNumberGenerator.nextInt(this.quotes.size()));
    }
}
