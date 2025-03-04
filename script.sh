awslocal lambda create-function --function-name ProcessJobLambda --runtime nodejs18.x --role arn:aws:iam::000000000000:role/irrelevant --handler index.handler --zip-file fileb://function.zip

awslocal lambda put-function-concurrency --function-name ProcessJobLambda --reserved-concurrent-executions 9

awslocal stepfunctions create-state-machine --name MyStateMachine --definition file://state-machine-definition.json --role-arn arn:aws:iam::000000000000:role/irrelevant

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
