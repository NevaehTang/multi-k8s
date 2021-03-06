docker build -t nevaehtang/multi-client:latest -t nevaehtang/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nevaehtang/multi-server:latest -t nevaehtang/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nevaehtang/multi-worker:latest -t nevaehtang/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nevaehtang/multi-client:latest
docker push nevaehtang/multi-server:latest
docker push nevaehtang/multi-worker:latest

docker push nevaehtang/multi-client:$SHA
docker push nevaehtang/multi-server:$SHA
docker push nevaehtang/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nevaehtang/multi-server:$SHA
kubectl set image deployments/client-deployment client=nevaehtang/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nevaehtang/multi-worker:$SHA
