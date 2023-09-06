const AWS = require("aws-sdk");
const documentClient = new AWS.DynamoDB.DocumentClient();

exports.handler = async event => {
  const {
    pathParameters: { id },
    body : { password, admin }
  } = event;
  
  let params;
  if (!password) {
    console.log("only admin update");
    params = {
      TableName: "users",
      Key: {
          "id": id
      },
      UpdateExpression: "set admin = :admin, lastupdate = :date",
      ExpressionAttributeValues: {
          ":admin": admin,
          ":date" : Date.now()
      }
    };
  } else {
    console.log("only password update");
    let encryptedPassword = new Buffer(password).toString('base64');
    params = {
      TableName: "users",
      Key: {
          "id": id
      },
      UpdateExpression: "set password = :password, lastupdate = :date",
      ExpressionAttributeValues: {
          ":password": encryptedPassword,
          ":date" : Date.now()
      }
    };
  } 
  
  try {
    const data = await documentClient.update(params).promise();
    const response = {
      statusCode: 200
    };
    return response;
  } catch (e) {
    return {
      statusCode: 500
    };
  }
};