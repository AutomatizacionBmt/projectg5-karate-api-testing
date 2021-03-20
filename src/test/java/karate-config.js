function fn() {

  karate.configure('logPrettyResponse', true);
  karate.configure('logPrettyRequest', true);

  //var env = karate.env; // get system property 'karate.env'
  var env = java.lang.System.getenv('karateEnv');
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'local';
  }
  var config = {
    env: env,
	myVarName: 'someValue'
  }
  if (env == 'local') {
    karate.log('Ambiente local:', env);
    config.urlApp = 'http://198.211.98.120:8081'
  }else if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
    karate.log('Ambiente de  desarrollo:', env);
    config.urlApp = 'http://198.211.98.120:8081'
  } else if (env == 'qa') {
    // customize
    karate.log('Ambiente de  qa:', env);
    config.urlApp = 'http://198.211.98.120:8081'
  }

  config.authToken = 'ccb0c7377946014cdf7efe0346ed26a93cc7e1b7'
  return config;
}