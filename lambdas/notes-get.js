const AWS = require("aws-sdk");
const documentClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async event => {
  

  const {
    queryParameters: { username }
  } = event; // Extracting username from the request path

  // Get All notes
  if (!username) {
    const params = {
      TableName: "notes"
    };
    const data = await documentClient.scan(params).promise();
    const response = {
      statusCode: 200,
      body: data.Items
    };
    return response;
  }

  // Get notes by username
  const params = {
    TableName: "notes",
    IndexName: "username-index",
    KeyConditionExpression: "username = :username",
    ExpressionAttributeValues: {
      ":username": username
    }
  };

  try {
    // Utilising the query method to retrieve all notes for username 
    const data = await documentClient.query(params).promise();
    console.log(data);
    const response = {
      statusCode: 200,
      body: data.Items

    };
    return response;
  } catch (e) {

    console.log(e)
    return {
      statusCode: 500

    };
  }
};