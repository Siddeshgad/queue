functionName = process.env.AWS_LAMBDA_FUNCTION_NAME

if functionName && functionName.indexOf("-prod") > 0
  process.env.NODE_ENV = "production"

if !process.env.NODE_ENV
  process.env.NODE_ENV = "default"

console.log("ENV: ", process.env.NODE_ENV)