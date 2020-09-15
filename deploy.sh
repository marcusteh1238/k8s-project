docker build -t marcusteh1238/multi-client:latest -t marcusteh1238/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcusteh1238/multi-server:latest -t marcusteh1238/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcusteh1238/multi-worker:latest -t marcusteh1238/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcusteh1238/multi-client:latest
docker push marcusteh1238/multi-server:latest
docker push marcusteh1238/multi-worker:latest

docker push marcusteh1238/multi-client:$SHA
docker push marcusteh1238/multi-server:$SHA
docker push marcusteh1238/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=marcusteh1238/multi-server:$SHA
kubectl set image deployments/client-deployment client=marcusteh1238/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marcusteh1238/multi-worker:$SHA
