import { LightningElement, wire, track } from 'lwc';
import getCurrentEvents from '@salesforce/apex/EventController.getCurrentEvents';
import { NavigationMixin } from 'lightning/navigation';

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
        fieldName: 'Event_Details__c',
        type: 'text',
    }
];

export default class EventListComponent extends NavigationMixin(LightningElement) {
    columns = columns;
    @track allEvents = [];
    error;

    @wire(getCurrentEvents)
    wiredEvents({error, data}) {
        if (data) {
            let eventsArray = [];

            for (let row of data) {
                const flattenedRow = {};
                let rowKeys = Object.keys(row);
                rowKeys.forEach((rowKey) => {
                    const singleNodeValue = row[rowKey];

                    if (singleNodeValue.constructor === Object) {
                        this._flatten(singleNodeValue, flattenedRow, rowKey)
                    } else flattenedRow[rowKey] = singleNodeValue;
                });

                eventsArray.push(flattenedRow);
            }
            this.allEvents = eventsArray;
        } else if (error) this.error = error;
    }

    _flatten = (nodeValue, flattenedRow, nodeName) => {
        let rowKeys = Object.keys(nodeValue);
        rowKeys.forEach((key) => {
            let finalKey = nodeName + '.' + key;
            flattenedRow[finalKey] = nodeValue[key];
        })
    }

    handleRowAction(event) {
        let eventId = JSON.stringify(event.detail.row.Id).replaceAll('\"', '');
        console.log('data: ' + JSON.stringify(event.detail.row.Id));
        this[NavigationMixin.Navigate]({
            type: "standard__component",
            attributes: {
                componentName: "c__navigateToEventDetails"
            },
            state: {
                c__recordId: eventId
            }
        });
    }
}