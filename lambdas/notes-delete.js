const AWS = require("aws-sdk");
const documentClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async event => {
  console.log(JSON.stringify(event));
  const {
    pathParameters: { id }
  } = event;
  const params = {
    TableName: "notes",
    Key: { id }
  };
  try {
    const data = await documentClient.delete(params).promise();
    const response = {
      statusCode: 200
    };
    return response;
  } catch (e) {
    return {
      statusCode: 500,
      body: JSON.stringify(e)
    };
  }
};