import { LightningElement, wire, track } from 'lwc';
import getCurrentEvents from '@salesforce/apex/EventController.getCurrentEvents';
import getSpecifiedEvents from '@salesforce/apex/EventController.getSpecifiedEvents';
import { NavigationMixin } from 'lightning/navigation';
import { flattenData } from 'c/utilityModulesHelper';

const columns = [
    {
        label: 'View',
        fieldName: "Name",
        type: 'button',
        typeAttributes: {
            label: { fieldName: "Name"},
            variant: "base"
        }
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
        fieldName: 'Event_Organizer__r.Name',
        type: 'text',
        cellAttributes: {
            iconName: "standard:avatar"
        }
    },
    {
        label: 'Location',
        fieldName: 'Location__r.Name',
        type: 'text',
        cellAttributes: {
            iconName: 'utility:location'
        }
    },
    {
        label: 'Details',
        fieldName: 'Event_Detail__c',
        type: 'text',
    }
];

export default class EventListComponent extends NavigationMixin(LightningElement) {
    columns = columns;
    @track allEvents = [];
    @track pickedEventId = undefined;
    @track pickedLocationId = undefined;
    @track pickedDateTime = undefined;
    error;

    @wire(getCurrentEvents)
    wiredEvents({error, data}) {
        if (data) {
            this.allEvents = flattenData(data);
            const temp = JSON.stringify(this.allEvents);
            this.allEvents = JSON.parse(temp.replaceAll(/(<([^>]+)>)/gi, ''));

        } else if (error) this.error = error;
    }

    handleRowAction(event) {
        let eventId = JSON.stringify(event.detail.row.Id).replaceAll('\"', '');

        this[NavigationMixin.Navigate]({
            type: "standard__recordPage",
            attributes: {
                objectApiName: 'Event__c',
                actionName: 'view',
                recordId: eventId
            },
        });
    }

    handleEventLookup(event) {
        this.pickedEventId = event.detail.selectedRecordId;
        this.handleTableChange();
    }

    handleLocationLookup(event) {
        this.pickedLocationId = event.detail.selectedRecordId;
        this.handleTableChange();
    }

    handleDateChange(event) {
        this.pickedDateTime = event.detail.value;
        this.handleTableChange();
    }

    handleTableChange() {
        
        getSpecifiedEvents({
            eventId: this.pickedEventId,
            locationId: this.pickedLocationId,
            selectedDateTime: this.pickedDateTime
        })
        .then( data => {
            if (data) {
                this.allEvents = flattenData(data);
            }
            const temp = JSON.stringify(this.allEvents);
            this.allEvents = JSON.parse(temp.replaceAll(/(<([^>]+)>)/gi, ''));
        })
        .catch((error) => {
            window.console.log(' error ', error);
        })
    }

}