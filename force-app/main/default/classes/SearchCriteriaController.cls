public inherited sharing class SearchCriteriaController 
{
    @AuraEnabled(cacheable=true)
    public static List<Author__c> GetAuthors()
    {
        return [select id, Name from Author__c];
    }
}
