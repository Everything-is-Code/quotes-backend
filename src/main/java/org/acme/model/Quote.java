package org.acme.model;

import java.util.ArrayList;
import java.util.List;

import javax.xml.transform.Source;

import org.acme.util.RandomQuoteProvider;

public class Quote {
    
    public interface Source<T>
    {
        public T getNext();
    }

    public interface Sink<T>
    {
        void put(T elem);
    }

    private final Source<String> dataSource;
    
    public Quote()
    {
        List<String> data = new ArrayList<String>(23);
        data.add("Be yourself; everyone else is already taken.― Oscar Wilde");
        data.add("A room without books is like a body without a soul. ― Marcus Tullius Cicero");
        data.add("Be the change that you wish to see in the world. ― Mahatma Gandhi");
        data.add("If you tell the truth, you don't have to remember anything. ― Mark Twain");
        data.add("If you want to know what a man's like, take a good look at how he treats his inferiors, not his equals.― J.K. Rowling");
        data.add("To live is the rarest thing in the world. Most people exist, that is all.― Oscar Wilde");
        data.add("Without music, life would be a mistake. ― Friedrich Nietzsche");
        data.add("Always forgive your enemies, nothing annoys them so much. ― Oscar Wilde");
        data.add("Life isn't about getting and having, it's about giving and being. – Kevin Kruse");
        data.add("Whatever the mind of man can conceive and believe, it can achieve. – Napoleon Hill");
        data.add("Strive not to be a success, but rather to be of value. – Albert Einstein");
        data.add("It's a basic truth of the human condition, that everybody lies. - Gregory House");
        data.add("How you doin'? - Joey Tribbiani");
        data.add("D'oh! - Homer Simpson");
        data.add("The truth is out there, but so are lies. - Dana Scully");
        data.add("I've made a huge mistake. - George Oscar Bluth II");
        data.add("The greatest glory in living lies not in never falling, but in rising every time we fall. - Nelson Mandela");
        data.add("The way to get started is to quit talking and begin doing. - Walt Disney");
        data.add("Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking. - Steve Jobs");
        data.add("The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt");
        data.add("If you look at what you have in life, you'll always have more. If you look at what you don't have in life, you'll never have enough. - Oprah Winfrey");
        data.add("If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success. - James Cameron");
        data.add("You may say I'm a dreamer, but I'm not the only one. I hope someday you'll join us. And the world will live as one. - John Lennon");

        this.dataSource = new RandomQuoteProvider(data);
    }

    @Override
    public String toString() {
        return dataSource.getNext();
    }

}
