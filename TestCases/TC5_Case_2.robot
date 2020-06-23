*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}    http://localhost:8080
${api_url}  CloudService/api/servers

*** Test Cases ***
Get_base_url
    create session  baseSession  ${base_url}
    ${response}=    get request  baseSession    /${api_url}
#    log to console  ${response.content}
    ${json_body}=  to json  ${response.content}
#    log to console  ${json_body}
    ${list}=  convert to list  ${json_body}
    ${countBefore}=  get length   ${list}
#    log to console  ${countBefore}
    get request  baseSession    /${api_url}/allocate?size=50
    get request  baseSession    /${api_url}/allocate?size=50
    ${response}=    get request  baseSession    /${api_url}
    ${json_body}=  to json  ${response.content}
    ${list}=  convert to list  ${json_body}
    ${countAfter}=  get length   ${list}
    ${countAfter}=  convert to integer  ${countAfter}
    ${countBefore}=  convert to integer  ${countBefore}
    ${countOfCreatedServers}=  EVALUATE  ${countAfter} - ${countBefore}
#    log to console  ${countOfCreatedServers}
    ${countOfCreatedServers}=    convert to string  ${countOfCreatedServers}
    SHOULD BE EQUAL  ${countOfCreatedServers}   1








#    ${body}=  set variable  ${response.content}
#    ${body}=  convert to string  ${body}
#    log to console  ${body}
#    ${Invalid_Response}=    set variable   Minimum server size is 1 Giga
#    should contain  ${body}  ${Invalid_Response}




