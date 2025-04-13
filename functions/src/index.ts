import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import {getFirestore} from "firebase-admin/firestore";
import {initializeApp} from "firebase-admin/app";
import {setGlobalOptions} from "firebase-functions/v2";
import {Timestamp} from 'firebase-admin/firestore';
import {v4 as uuidv4} from 'uuid';
import {Feed} from "./models/feed";

initializeApp();
setGlobalOptions({region: 'asia-northeast3'});

exports.getFeedList = onRequest({cors: true}, async (request, response) => {
    logger.info("getFeedList");
    try {

        const result: Feed[] = [];

        const snapshot = await getFirestore()
            .collection("feed")
            .get();

        if (snapshot.empty) {
            console.log('No matching documents.');
            return;
        }

        snapshot.forEach(doc => {
            const data = doc.data();

            const feed: Feed = {
                id: data.id,
                url: data.url,
                message: data.message,
                cnt_like: Number(data.cnt_like),
                cnt_comment: Number(data.cnt_comment),
                created_at: data.createdAt,
                updated_at: data.updated_at,
            };

            result.push(feed);
        });

        response.status(200).json({result: result});
    } catch (e) {
        if (e instanceof Error) {
            console.error(e.message);
            response.status(500).json({result: e.message});
        }
        response.status(500).json({result: e});
    }
});

exports.writeFeed = onRequest({cors: true}, async (request, response) => {
    logger.info("writeFeed");
    logger.log(request.body);
    try {
        const writeResult = await getFirestore()
            .collection("feed")
            .add({
                ...request.body,
                id: uuidv4(),
                created_at: Timestamp.now(),
                updated_at: Timestamp.now(),
            });
        response.status(200).json({result: `feed ${writeResult.id} created`});
    } catch (e) {
        if (e instanceof Error) {
            console.error(e.message);
            response.status(500).json({result: e.message});
        }
        response.status(500).json({result: e});
    }
});