import { LightningElement, wire, api, track } from 'lwc';
import getAttendeesUpcomingEvents from '@salesforce/apex/EventController.getAttendeesUpcomingEvents';
import getAttendeesPastEvents from '@salesforce/apex/EventController.getAttendeesPastEvents';
import { flattenData } from 'c/utilityModulesHelper';

const columns = [
    {
        label: 'Name',
        fieldName: 'Name__c',
        type: 'text',
    },
    {
        label: 'Organizer',
        fieldName: 'Event_Organizer__r.Name',
        type: 'text',
        cellAttributes: {
            iconName: "standard:avatar"
        }
    },
    {
        label: 'Event Date',
        fieldName: 'Start_DateTime__c',
        type: 'date'
    },
    {
        label: 'Location',
        fieldName: 'Location__r.Name',
        type: 'text',
        cellAttributes: {
            iconName: 'utility:location'
        }
    }
]

export default class AttendeeEventsComponent extends LightningElement {
    columns = columns;
    @api recordId;
    @track upcomEvents = [];
    @track pstEvents = [];

    renderedCallback() {
        console.log(this.recordId);
    }

    @wire(getAttendeesUpcomingEvents, {attId : '$recordId'})
    upcomingEvents({error, data}) {
        if (data) {
            this.upcomEvents = flattenData(data);
            console.log(this.upcomEvents);
        } else if (error) this.error = error;
    }

    @wire(getAttendeesPastEvents, {attId : '$recordId'})
    pastEvents({error, data}) {
        if (data) {
            this.pstEvents = flattenData(data);
            console.log(this.pstEvents);
        } else if (error) this.error = error;
    }
}