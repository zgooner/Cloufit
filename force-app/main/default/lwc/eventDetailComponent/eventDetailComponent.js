import { LightningElement, api } from 'lwc';

export default class EventDetailComponent extends LightningElement {
    objectApiName = 'Event__c';
    @api recordId;

}