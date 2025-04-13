import {Timestamp} from 'firebase-admin/firestore';

export interface Feed {
    id: string;
    url: string;
    message: string;
    cnt_like: number;
    cnt_comment: number;
    created_at: Timestamp;
    updated_at: Timestamp;
}