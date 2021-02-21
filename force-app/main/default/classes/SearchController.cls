public inherited sharing class SearchController 
{
    @AuraEnabled(cacheable=true)
    public static List<Book__c> searchBooks(String author, String genre)
    {
        List<Book__c> result=null;
        try 
        {
            Id authorId=null;

            if (!String.isBlank(author)) 
            {
                authorId=(Id) author;
            }
            result=new BookService().SearchBooks(authorId, genre);
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }

        return result;
    }
}
