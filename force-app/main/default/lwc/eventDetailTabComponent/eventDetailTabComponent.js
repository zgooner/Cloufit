import { LightningElement, api } from 'lwc';

import Event_NameId from '@salesforce/schema/Event__c.Name';
import Event_Name from '@salesforce/schema/Event__c.Name__c';
import Event_StartDate from '@salesforce/schema/Event__c.Start_DateTime__c';
import Event_Recurring from '@salesforce/schema/Event__c.Recurring__c';
import Event_Max_Seats from '@salesforce/schema/Event__c.Max_Seats__c';
import Event_Remaining_Seats from '@salesforce/schema/Event__c.Remaining_Seats__c';
import Event_Live from '@salesforce/schema/Event__c.Live__c';
import Event_Location_Verif from '@salesforce/schema/Event__c.Location_Verified__c';
import Event_CreatedBy from '@salesforce/schema/Event__c.CreatedById';
import Event_LastModif from '@salesforce/schema/Event__c.LastModifiedById';
import Event_Location_Name from '@salesforce/schema/Event__c.Location__c';
import Event_Status from '@salesforce/schema/Event__c.Status__c';
import Event_Organizer from '@salesforce/schema/Event__c.Event_Organizer__c';
import Event_EndDate from '@salesforce/schema/Event__c.End_Date_Time__c';
import Event_People_Attending from '@salesforce/schema/Event__c.PeopleAttending__c';
import Event_Type from '@salesforce/schema/Event__c.Event_Type__c';
import Event_Freq from '@salesforce/schema/Event__c.Frequency__c';
import Event_Detail from '@salesforce/schema/Event__c.Event_Detail__c';
import Event_CreatedDate from '@salesforce/schema/Event__c.CreatedDate';
import Event_LastModifDate from '@salesforce/schema/Event__c.LastModifiedDate';


export default class EventDetailTabComponent extends LightningElement {
    @api objectApiName = 'Event__c';
    @api recordId = 'a017Q00000r01r5QAA';

    eventId = Event_NameId;
    eventName = Event_Name;
    eventStartDateTime = Event_StartDate;
    eventIsRecurring = Event_Recurring;
    eventMaxSeats = Event_Max_Seats;
    eventRemainingSeats = Event_Remaining_Seats;
    eventIsLive = Event_Live;
    eventIsLocVerified = Event_Location_Verif;
    eventCreatedBy = Event_CreatedBy;
    eventLastModifId = Event_LastModif;
    eventLocationName = Event_Location_Name;
    eventStatus = Event_Status;
    eventOrganizerName = Event_Organizer;
    eventEndDateTime = Event_EndDate;
    eventPeopleAttending = Event_People_Attending;
    eventType = Event_Type;
    eventFreq = Event_Freq;
    eventDetail = Event_Detail;
    eventCreateDate = Event_CreatedDate;
    eventLastModifDate = Event_LastModifDate;

}