import { LightningElement, wire } from 'lwc';
import getCurrentEvents from '@salesforce/apex/EventController.getCurrentEvents'

const columns = [
    {
        label: 'View',
        fieldName: "Name",
        type: 'text'
    },
    {
        label: 'Name',
        fieldName: 'Name__c',
        type: 'text',
        cellAttributes: {
            iconName: "standard:event"
        }
    },
    {
        label: 'Organizer',
        fieldName: 'Event_Organizer__c',
        type: 'text',
        cellAttributes: {
            iconName: "standard:avatar"
        }
    },
    {
        label: 'Location',
        fieldName: 'Location__c',
        type: 'text',
        cellAttributes: {
            iconName: 'utility:location'
        }
    },
    {
        label: 'Details',
        fieldName: 'Event_Details__c',
        type: 'text',
    }
];

export default class EventListComponent extends LightningElement {
    columns = columns;

    @wire(getCurrentEvents)
    events;
}