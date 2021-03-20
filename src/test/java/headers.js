function fn(){

    var token = karate.get('token');

    if(token){
        var uuid = java.util.UUID.randomUUID();
        return {
            'X-Redmine-API-Key': token,
            request_id: uuid
        };
    }else{
        return {};
    }
}