function fn() {

    var config = {
        userApiUrl: 'https://testapi.popcornvan.cloud/user',
        consoleAuthorization:'eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJidXNyYUBwb3Bjb3JudmFuLmNvbSIsIm5hbWUiOiJiw7zFn3JhIGLDvMWfcmEiLCJVc2VyVHlwZSI6IkVtcGxveWVlIiwiTmFtZSI6ImLDvMWfcmEgYsO8xZ9yYSIsIkVtYWlsIjoiYnVzcmFAcG9wY29ybnZhbi5jb20iLCJVc2VySWQiOiIzYzA1ZjhjMS1iMmMzLTQ0NjUtYjRlNS03NmE1ZThlNzkzYTgiLCJuYmYiOjE2NDE5ODQ5NzMsImV4cCI6MTY3MzUyMDk3MywiaWF0IjoxNjQxOTg0OTczLCJpc3MiOiJodHRwczovL3BvcGNvcm52YW4uY29tLyIsImF1ZCI6Imh0dHBzOi8vcG9wY29ybnZhbi5jb20vIn0.EyScMqZm4RzwZoX9g83z3gBnWvonI49M5kcw3LIo6Wd2swfYK2fJuEK9B2sJ_0f7DOvUpETfdHaZF4_kyuyuEQ'
    }
    var env = karate.env
    karate.log('Environment variable is :', env)

    if (env=='test'){

        config.userApiUrl = 'https://testapi.popcornvan.cloud/user';

    }else if(env=='prod'){

        config.userApiUrl = 'https://qaapi.popcornvan.cloud/user';

    }else{

    }
    var result = karate.callSingle('classpath:features/userApi/customer/customer_login_authentication.feature')
    config.authInfo = result;
    config.auth = {access_token:result.response.accessToken}

    return config;
}