import { LightningElement, api, wire } from 'lwc';
import getEventLocation from '@salesforce/apex/LocationController.getEventLocation';

export default class LocationDetailTabComponent extends LightningElement {
    @api eventRecordId;

    @wire(getEventLocation, {eventId: "$eventRecordId"})
    locationDetails;
}