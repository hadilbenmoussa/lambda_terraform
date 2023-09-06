const AWS = require("aws-sdk");
const documentClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async event => {
  const params = {
    TableName: "users"
  };
  try {
    // Utilising the scan method to get all items in the table
    const data = await documentClient.scan(params).promise();
    const response = {
      statusCode: 200,
      body: data.Items
    };
    return response;
  } catch (e) {
    return {
      statusCode: 500
    };
  }
};
