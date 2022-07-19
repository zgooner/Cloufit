import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class EventCreationComponent  extends NavigationMixin(LightningElement) {
    @api objectApiName = 'Event__c';
    @api eventOrganizer;
    @api eventId;
    @api eventDesc = '';

    handleSumbit(event) {
        event.preventDefault(); // stop the form from submitting
        
        const fields = event.detail.fields;
        fields.Event_Organizer__c = this.eventOrganizer;
        fields.Event_Detail__c = this.eventDesc;

        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    handleSuccess(event) {
        const payload = event.detail;
        console.log(JSON.stringify(payload.id));
        
        this.navigateToDetailPage(event);
    }

    handleTextChange(event) {
        this.eventDesc = event.target.value;
    }

    handleLookup(event) {
        this.eventOrganizer = event.detail.selectedRecordId;
    }

    navigateToDetailPage(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.detail.id,
                objectApiName: this.objectApiName,
                actionName: 'view'
            }
        });
    }

}