const AWS = require("aws-sdk");
const documentClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async event => {
    const {
        pathParameters: { id },
        body : { text, title }
    } = event;
  
    const params = {
      TableName: "notes",
      Key: {
          "id": id
      },
      UpdateExpression: "set title = :title, #newtext = :text, lastupdate = :date",
      ExpressionAttributeNames: {
        "#newtext": "text"
      },
      ExpressionAttributeValues: {
          ":title": title,
          ":text": text,
          ":date" : Date.now()
      }
    };
  
  try {
    const data = await documentClient.update(params).promise();
    const response = {
      statusCode: 200
    };
    return response;
  } catch (e) {
      console.error(e)
    return {
      statusCode: 500
    };
  }
};