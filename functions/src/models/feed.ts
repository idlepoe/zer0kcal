import {Timestamp} from 'firebase-admin/firestore';
import {Comments} from "./comments";

export interface Feed {
    id: string;
    url: string;
    message: string;
    cnt_like: number;
    cnt_comment: number;
    comments: Comments[];
    created_at: Timestamp;
    updated_at: Timestamp;
}