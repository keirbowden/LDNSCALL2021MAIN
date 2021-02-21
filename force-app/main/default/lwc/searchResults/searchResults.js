import { LightningElement, wire } from 'lwc';
import { MessageContext, subscribe, APPLICATION_SCOPE} from 'lightning/messageService';
import SEARCHCRITERIAMC from '@salesforce/messageChannel/SearchCriteriaMessageChannel__c';
import searchBooks from '@salesforce/apex/SearchController.searchBooks';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { reduceErrors } from 'c/ldsUtils';

export default class SearchResults extends LightningElement {
    books=[];
    noMatches=false;

    // Initialize messageContext for Message Service
    @wire(MessageContext)
    messageContext;

    // Runs when component is connected, subscribes to the search criteria message channel
    connectedCallback() {
        if (this.subscription) {
            return;
        }

        // Subscribe to the message channel to retrieve the recordID and assign it to boatId.
        this.subscription = subscribe(this.messageContext, SEARCHCRITERIAMC, (message) => {
            this.executeSearch(message.author, message.genre);

        }, { scope: APPLICATION_SCOPE });  
    }

    executeSearch(author, genre) {
        this.noMatches=false;
        this.books=[];
        searchBooks({author : author, genre: genre})
        .then(result => {
            if (result){
                this.books=result;
            }
            if (0==this.books.length) {
                this.noMatches=true;
            }
        })
        .catch(err => {
            let errors=reduceErrors(err).reduce((accumulator, currentValue) => accumulator.concat(', ', currentValue), '');
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error getting results',
                    message: errors.substring(2),
                    variant: 'error'
                })
            );
        })
    }
}