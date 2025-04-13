import {Timestamp} from 'firebase-admin/firestore';

export interface Comments {
    id: string;
    feed_id: string;
    message: string;
    created_at: Timestamp;
    updated_at: Timestamp;
}