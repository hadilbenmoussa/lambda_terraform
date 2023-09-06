const AWS = require("aws-sdk");
const crypto = require("crypto");

// Generate unique id with no external dependencies
const generateUUID = () => Date.now();

// Initialising the DynamoDB SDK
const documentClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async event => {
  const parsedBody = JSON.parse(event.body);
  const requestBody = parsedBody.body;

  const params = {
    TableName: "notes",
    Item: {
      id: generateUUID(),
      title: requestBody.title,
      text: requestBody.text,
      username: requestBody.username,
      creation: Date.now()
    }
  };
  try {
    await documentClient.put(params).promise();

    // Form a response containing the created note data
    const createdNote = {
      id: params.Item.id,
      title: params.Item.title,
      text: params.Item.text,
      username: params.Item.username,
      creation: params.Item.creation
    };

    const response = {
      statusCode: 200,
      body: JSON.stringify(createdNote) // Include the created note data in the response body
    };
    return response;
  } catch (e) {
    return {
      statusCode: 500,
      body: JSON.stringify(e)
    };
  }
};
