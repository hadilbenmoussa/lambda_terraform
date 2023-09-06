const AWS = require("aws-sdk");
const crypto = require("crypto");

// Generate unique id with no external dependencies
const generateUUID = () => crypto.randomBytes(16).toString("hex");

// defa password
const password = new Buffer("password").toString('base64');

// Initialising the DynamoDB SDK
const documentClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async event => {
  const {
    body : { username, admin }
  } = event;

  const params = {
    TableName: "users", 
    Item: { // Creating an Item with a unique id and with the passed username
      id: generateUUID(),
      username: username,
      admin: admin,
      password: password, // Password base64 encoded
      creation: Date.now()
    }
  };
  try {
    const data = await documentClient.put(params).promise();
    const response = {
      statusCode: 200
    };
    return response; // Returning a 200 if the item has been inserted 
  } catch (e) {
    return {
      statusCode: 500,
      body: JSON.stringify(e)
    };
  }
};