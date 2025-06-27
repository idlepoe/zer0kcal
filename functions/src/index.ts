import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import {getFirestore} from "firebase-admin/firestore";
import {initializeApp} from "firebase-admin/app";
import {setGlobalOptions} from "firebase-functions/v2";
import {Timestamp} from 'firebase-admin/firestore';
import {Feed} from "./models/feed";
import {Comments} from "./models/comments";
import {firestore} from "firebase-admin";
import FieldValue = firestore.FieldValue;
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

initializeApp();
setGlobalOptions({region: 'asia-northeast3'});

export async function verifyAuth(req: any): Promise<admin.auth.DecodedIdToken> {
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    throw new functions.https.HttpsError("unauthenticated",
      "Authorization header missing");
  }

  const idToken = authHeader.split("Bearer ")[1];

  try {
    const decoded = await admin.auth().verifyIdToken(idToken);
    return decoded;
  } catch (error) {
    throw new functions.https.HttpsError("unauthenticated",
      "Invalid Firebase ID token");
  }
}

exports.getFeedList = onRequest({
    cors: true, memory: "1GiB",
    region: "asia-northeast3",
}, async (request, response) => {
    logger.info("getFeedList");
    try {
        // 토큰 검증
        const decodedToken = await verifyAuth(request);
        
        // 검증된 사용자 ID 사용
        const userId = decodedToken.uid;

        const result: Feed[] = [];

        const snapshot = await getFirestore()
            .collection("feed")
            .orderBy("created_at", "desc")
            .get();

        snapshot.forEach(doc => {
            const data = doc.data();

            const feed: Feed = {
                id: doc.id,
                url: data.url,
                message: data.message,
                cnt_like: Number(data.cnt_like),
                cnt_comment: Number(data.cnt_comment),
                comments: [],
                created_at: data.createdAt,
                updated_at: data.updated_at,
            };

            result.push(feed);
        });

        response.status(200).json({result: result});
        return;
    } catch (e) {
        if (e instanceof functions.https.HttpsError) {
            response.status(401).json({ error: e.message });
        } else {
            response.status(500).json({result: e});
        }
    }
});

exports.getFeedDetail = onRequest({
    cors: true, memory: "1GiB",
    region: "asia-northeast3",
}, async (request, response) => {
    logger.info("getFeedDetail");
    logger.log(request.body);
    try {
        // 토큰 검증
        const decodedToken = await verifyAuth(request);
        
        // 검증된 사용자 ID 사용
        const userId = decodedToken.uid;

        const feedID = request.body.feed_id;
        logger.log(feedID);

        const result: Feed[] = [];

        const snapshot = await getFirestore()
            .collection("feed").doc(feedID)
            .get();

        const data = snapshot.data();
        if (data != undefined) {
            const feed: Feed = {
                id: feedID,
                url: data.url,
                message: data!.message,
                cnt_like: Number(data.cnt_like),
                cnt_comment: Number(data.cnt_comment),
                comments: [],
                created_at: data.createdAt,
                updated_at: data.updated_at,
            };
            result.push(feed);
        }

        const targetFeed = result.length > 0 ? result[0] : null;

        if (targetFeed != null) {
            const commentList: Comments[] = [];
            // 코멘트 리스트
            const commentSnapshot = await getFirestore()
                .collection("comment")
                .where("feed_id", "==", feedID)
                .get();

            commentSnapshot.forEach(doc => {
                const data = doc.data();
                const comment: Comments = {
                    id: doc.id,
                    feed_id: data.feed_id,
                    message: data.message,
                    created_at: data.createdAt,
                    updated_at: data.updated_at,
                };
                commentList.push(comment);
            });
            targetFeed.comments = commentList;
        }
        response.status(200).json({result: targetFeed});
        return;
    } catch (e) {
        if (e instanceof functions.https.HttpsError) {
            response.status(401).json({ error: e.message });
        } else {
            response.status(500).json({result: e});
        }
    }
});

exports.writeFeed = onRequest({
    cors: true, memory: "1GiB",
    region: "asia-northeast3",
}, async (request, response) => {
    logger.info("writeFeed");
    logger.log(request.body);
    try {
        // 토큰 검증
        const decodedToken = await verifyAuth(request);
        
        // 검증된 사용자 ID 사용
        const userId = decodedToken.uid;

        const writeResult = await getFirestore()
            .collection("feed")
            .add({
                ...request.body,
                created_at: Timestamp.now(),
                updated_at: Timestamp.now(),
            });
        response.status(200).json({result: `feed ${writeResult.id} created`});
        return;
    } catch (e) {
        if (e instanceof functions.https.HttpsError) {
            response.status(401).json({ error: e.message });
        } else {
            response.status(500).json({result: e});
        }
    }
});

exports.writeComment = onRequest({
    cors: true, memory: "1GiB",
    region: "asia-northeast3",
}, async (request, response) => {
    logger.info("writeComment");
    logger.log(request.body);
    try {
        // 토큰 검증
        const decodedToken = await verifyAuth(request);
        
        // 검증된 사용자 ID 사용
        const userId = decodedToken.uid;

        const targetFeedID = request.body.feed_id;

        const writeResult = await getFirestore()
            .collection("comment")
            .add({
                ...request.body,
                feed_id: targetFeedID,
                created_at: Timestamp.now(),
                updated_at: Timestamp.now(),
            });

        const commentUpTarget = getFirestore()
            .collection("feed").doc(targetFeedID);

        await commentUpTarget.update({
            cnt_comment: FieldValue.increment(1)
        });

        response.status(200).json({result: `feed ${writeResult.id} created`});
        return;
    } catch (e) {
        if (e instanceof functions.https.HttpsError) {
            response.status(401).json({ error: e.message });
        } else {
            response.status(500).json({result: e});
        }
    }
});

exports.countUpLike = onRequest({
    cors: true, memory: "1GiB",
    region: "asia-northeast3",
}, async (request, response) => {
    logger.info("countUpLike");
    logger.log(request.body);
    try {
        // 토큰 검증
        const decodedToken = await verifyAuth(request);
        
        // 검증된 사용자 ID 사용
        const userId = decodedToken.uid;

        const targetFeedID = request.body.feed_id;

        const commentUpTarget = getFirestore()
            .collection("feed").doc(targetFeedID);

        await commentUpTarget.update({
            cnt_like: FieldValue.increment(1)
        });

        response.status(200).json({result: `countUpLike success`});
        return;
    } catch (e) {
        if (e instanceof functions.https.HttpsError) {
            response.status(401).json({ error: e.message });
        } else {
            response.status(500).json({result: e});
        }
    }
});
