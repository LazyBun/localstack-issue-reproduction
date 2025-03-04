# Localstack issue reproduction

0. **Zip** the lambda:

```bash
zip function.zip index.js
```

1. **Start** the LocalStack on docker (pro version)

```bash
docker run \
  --rm -it \
  -p 127.0.0.1:4566:4566 \
  -p 127.0.0.1:4510-4559:4510-4559 \
  -p 127.0.0.1:443:443 \
  -e LOCALSTACK_AUTH_TOKEN=${LOCALSTACK_AUTH_TOKEN:?} \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack-pro
```

2. **Deploy the Lambda function** to LocalStack:

```bash
awslocal lambda create-function --function-name ProcessJobLambda --runtime nodejs18.x --role arn:aws:iam::000000000000:role/irrelevant --handler index.handler --zip-file fileb://function.zip

awslocal lambda put-function-concurrency --function-name ProcessJobLambda --reserved-concurrent-executions 9
```

3. **Create the Step Function** using the AWS CLI:

```bash
awslocal stepfunctions create-state-machine --name MyStateMachine --definition file://state-machine-definition.json --role-arn arn:aws:iam::000000000000:role/irrelevant
```

4. **Start Execution** with the required input:

```bash
awslocal stepfunctions start-execution \
  --state-machine-arn arn:aws:states:us-east-1:000000000000:stateMachine:MyStateMachine \
  --input '{
    "outerJobs": [
      {
        "innerJobs": [0, 1, 2, 3, 4]
      },
      {
        "innerJobs": [5, 6, 7, 8, 9]
      },
      {
        "innerJobs": [5, 6, 7, 8, 9]
      },
      {
        "innerJobs": [5, 6, 7, 8, 9]
      },
      {
        "innerJobs": [5, 6, 7, 8, 9]
      }
    ]
  }'
```
