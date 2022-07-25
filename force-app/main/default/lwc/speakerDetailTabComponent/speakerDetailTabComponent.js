import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import avatarLinkImport from '@salesforce/resourceUrl/default_picture';
import getSpeakersRelatedWithEvent from '@salesforce/apex/SpeakerController.getSpeakersRelatedWithEvent';

export default class SpeakerDetailTabComponent extends NavigationMixin(LightningElement) {
    @api eventRecordId;

    @wire(getSpeakersRelatedWithEvent, {eventId: '$eventRecordId'})
    speakers;

    avatarLink = avatarLinkImport;

    handleClick(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
            objectApiName: 'EventSpeakers__c',
            actionName: 'new'
            },
            state: {
            defaultFieldValues: encodeDefaultFieldValues({Event__c: this.eventRecordId})
            }
        });
         
    }
}