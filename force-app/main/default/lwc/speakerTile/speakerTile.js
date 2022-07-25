import { LightningElement, api } from 'lwc';

export default class SpeakerTile extends LightningElement {
    @api name;
    @api email
    @api imageLink
    @api aboutMe
}