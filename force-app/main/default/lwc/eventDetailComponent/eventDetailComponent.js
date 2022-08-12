import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';

export default class EventDetailComponent extends LightningElement {
    objectApiName = 'Event__c';
    @api recordId;

}