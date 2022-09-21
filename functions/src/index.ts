import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import * as serviceAccount from "./serviceAccountKey.json";

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount as admin.ServiceAccount),
});

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript


export const createFirebaseToken = functions.https
    .onCall(async (data, context) => {
        const uid = data.uid;
        const customToken = await admin.auth().createCustomToken(uid.toString());
        return { customToken: customToken };
    });

// export const createFirebaseToken = functions.https
//     .onRequest(async (request, response) => {
//         const uid = request.query.uid;
//         if (uid !== undefined) {
//             const customToken = await admin.auth().createCustomToken(uid.toString());
//             response.send({ customToken: customToken });
//         } else {
//             response.send({ error: "uid is required" });
//         }
//     });
