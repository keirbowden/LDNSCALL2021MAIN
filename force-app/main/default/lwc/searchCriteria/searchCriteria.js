import { LightningElement, wire } from 'lwc';
import GetAuthors from '@salesforce/apex/SearchCriteriaController.GetAuthors';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import GENRE_FIELD from '@salesforce/schema/Book__c.Genre__c';
import { MessageContext, publish} from 'lightning/messageService';
import SEARCHCRITERIAMC from '@salesforce/messageChannel/SearchCriteriaMessageChannel__c';


export default class SearchCriteria extends LightningElement {
    authorValues;
    author='';
    genreValues;
    genre='';
    isLoading=true;

    // wired message context
    @wire(MessageContext)
    messageContext;

    @wire(getPicklistValues, {
        recordTypeId: '012000000000000AAA',
        fieldApiName: GENRE_FIELD
    })
    gotGenres(result) { 
        console.log('Got genre values ' + JSON.stringify(result.data, null, 4));
        if (result.data) {
            this.genreValues=[];
            this.genreValues.push({label: 'Choose', value: ''});
            result.data.values.forEach(entry => {
                this.genreValues.push({label: entry.label, value: entry.value});
            });
            console.log('This.genreValues = ' + JSON.stringify(this.genreValues));
            this.isLoading=false;
        }
    }

    @wire(GetAuthors, {})
    gotAuthors(result) { 
        console.log('Got author values ' + JSON.stringify(result.data, null, 4));
        if (result.data) {
            this.authorValues=[];
            this.authorValues.push({label: 'Choose', value: ''});
            result.data.forEach(entry => {
                this.authorValues.push({label: entry.Name, value: entry.Id});
            });
            console.log('This.authorValues = ' + JSON.stringify(this.authorValues));
            this.isLoading=false;
        }
    }

    authorChanged(event) {
        this.author=event.target.value;
    }
    
    genreChanged(event) {
        this.genre=event.target.value;
    }
    
    clearSearch(event) {
        this.author='';
        this.genre='';
    }

    search(event) {
        const message = {
            author: this.author,
            genre: this.genre
        };

        publish(this.messageContext, SEARCHCRITERIAMC, message);
    }


}