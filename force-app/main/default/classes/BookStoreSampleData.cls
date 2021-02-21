public inherited sharing class BookStoreSampleData 
{
    public static void CreateBookstoreSampleData()
    {
        List<Publisher__c> publishers=new List<Publisher__c>();

        Publisher__c publisher=new Publisher__c(Name='Packet',
                Genres__c='Thriller;Mystery;Detective',
                Website__c='https://bobbuzzard.blogspot.com');

        publishers.add(publisher);

        publisher=new Publisher__c(Name='Oh Really?',
        Genres__c='Fantasy;Science fiction;Horror',
        Website__c='https://bobbuzzard.blogspot.com');

        publishers.add(publisher);

        insert publishers;

        List<Author__c> authors=new List<Author__c>();

        Author__c author=new Author__c(Name='Bob Buzzard',
                                       Publisher__c=publishers[0].Id,
                                       Genres__c='Mystery;Detective');
        authors.add(author);

        author=new Author__c(Name='John Gryphon',
                             Publisher__c=publishers[0].Id,
                             Genres__c='Thriller');

        authors.add(author);

        author=new Author__c(Name='Dexter Colin',
                             Publisher__c=publishers[1].Id,
                             Genres__c='Romance');

        authors.add(author);

        insert authors;

        List<Book__c> books=new List<Book__c>();
        Book__c book=new Book__c(Name='The Trail of the LowCode Pine',
                                 Author__c=authors[0].Id,
                                 Genre__c='Mystery',
                                 Pages__c=145,
                                 Published_Year__c=Date.newInstance(1992, 6, 17));
        books.add(book);

        book=new Book__c(Name='The Cloud of the Baskervilles',
                                 Author__c=authors[0].Id,
                                 Genre__c='Detective',
                                 Pages__c=260,
                                 Published_Year__c=Date.newInstance(1982, 2, 10));
        books.add(book);

        book=new Book__c(Name='The Flow',
                                 Author__c=authors[1].Id,
                                 Genre__c='Thriller',
                                 Pages__c=310,
                                 Published_Year__c=Date.newInstance(1992, 4, 1));
        books.add(book);

        book=new Book__c(Name='The Workflow Rule',
                                 Author__c=authors[2].Id,
                                 Genre__c='Romance',
                                 Pages__c=93,
                                 Published_Year__c=Date.newInstance(1937, 11, 4));
        books.add(book);

        insert books;
    }

    public static void RemoveBookstoreSampleData()
    {
        List<Book__c> books=[select id from Book__c];
        delete books;
        
        List<Author__c> authors=[select id from Author__c];
        delete authors;

        List<Publisher__c> publishers=[select id from Publisher__c];
        delete publishers;
    }
}
