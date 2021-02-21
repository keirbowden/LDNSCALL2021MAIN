public inherited sharing class BookService 
{
    public List<Book__c> searchBooks(Id authorId, String genre)
    {
        String queryStr='select Id, Name, Pages__c, Published_Year__c, Author__r.Name, Genre__c from Book__c ';

        String whereClause='';

        if (null!=authorId)
        {
            if (''!=whereClause)
            {
                whereClause+=' AND ';
            }
            whereClause+=' Author__c=:authorId ';
        }

        if (!String.isBlank(genre))
        {
            if (''!=whereClause)
            {
                whereClause+=' AND ';
            }
            whereClause+=' Genre__c=:genre ';
        }

        if (''!=whereClause)
        {
            queryStr+=' WHERE ' + whereClause;
        }

        List<Book__c> books=Database.query(queryStr);
        return books;
    }
}
