import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import getEventAttendees from '@salesforce/apex/AttendeeController.getEventAttendees';

const columns = [
    {   
        label: 'Name', 
        fieldName: 'Name', 
        type: 'text',
        cellAttributes: {
            iconName: 'standard:avatar'
        }
    },
    {
        label: 'Email',
        fieldName: 'Email__c',
        type: 'email'
    },
    {
        label: 'Company Name',
        fieldName: 'Company_Name__c',
        type: 'text'
    },
    {
        label: 'Location',
        fieldName: 'Location__c',
        type: 'text',
        cellAttributes: {
            iconName: 'utility:location'
        }
    }

]

export default class AttendeesDetailTabComponent extends NavigationMixin(LightningElement) {
    @api eventRecordId;
    columns = columns;

    @wire(getEventAttendees, {eventId: '$eventRecordId'})
    attendees;

    handleClick(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
            objectApiName: 'Event_Attendee__c',
            actionName: 'new'
            },
            state: {
            defaultFieldValues: encodeDefaultFieldValues({Event__c: this.eventRecordId})
            }
        });
         
    }
}