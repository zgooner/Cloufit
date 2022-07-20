import { LightningElement, api, wire } from 'lwc';
import avatarLinkImport from '@salesforce/resourceUrl/default_picture';
import getSpeakersRelatedWithEvent from '@salesforce/apex/SpeakerController.getSpeakersRelatedWithEvent';

export default class SpeakerDetailTabComponent extends LightningElement {
    @api eventRecordId;

    @wire(getSpeakersRelatedWithEvent, {eventId: '$eventRecordId'})
    speakers;

    avatarLink = avatarLinkImport;
}