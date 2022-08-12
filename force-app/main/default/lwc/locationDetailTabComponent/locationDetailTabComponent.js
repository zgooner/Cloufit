import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import STREET from '@salesforce/schema/Event__c.Location__r.Street__c';
import CITY from '@salesforce/schema/Event__c.Location__r.City__c';
import COUNTRY from '@salesforce/schema/Event__c.Location__r.Country__c';
import STATE from '@salesforce/schema/Event__c.Location__r.State__c';
import POSTALCODE from '@salesforce/schema/Event__c.Location__r.Postal_Code__c';
import LANDMARK from '@salesforce/schema/Event__c.Location__r.Land_Mark__c';
const fields = [STREET, CITY, COUNTRY, STATE, POSTALCODE, LANDMARK];

export default class LocationDetailTabComponent extends LightningElement {
    @api eventRecordId;
    @wire(getRecord, { recordId: '$eventRecordId', fields })
    event;
    get Street() {
        return getFieldValue(this.event.data, STREET);
    }
    get City() {
        return getFieldValue(this.event.data, CITY);
    }
    get Country() {
        return getFieldValue(this.event.data, COUNTRY);
    }
    get State() {
       return getFieldValue(this.event.data, STATE);
    }
    get PostalCode() {
        return getFieldValue(this.event.data, POSTALCODE);
    }
    get Landmark() {
        return getFieldValue(this.event.data, LANDMARK);
    }
}