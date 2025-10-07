// Copyright (c) 2025 WSO2 LLC. (https://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerina/http;
import ballerina/log;

public configurable string fromEmailAddress = ?;
public configurable string contactUsEmail = ?;
public configurable string receptionEmail = ?;

# Send an email alert via the email service.
#
# + payload - Payload for the email service
# + return - Response from the email service
public isolated function sendEmail(EmailPayload payload) returns error? {
    http:Response|http:ClientError response = emailClient->/send\-email.post(payload);
    if response is http:ClientError {
        string customError = string `Client Error occurred while sending the email !`;
        log:printError(customError, response);
        return error(customError);
    }
    if response.statusCode != http:STATUS_OK {

        string customError = string `Error occurred while sending the email !`;
        log:printError(string `${customError} : ${(check response.getJsonPayload()).toJsonString()}!`);
        return error(customError);
    }
}
