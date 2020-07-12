docker build -t lucas4xin/multi-client:latest -t lucas4xin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lucas4xin/multi-server:latest -t lucas4xin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lucas4xin/multi-worker:lasest -t lucas4xin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lucas4xin/multi-client:latest
docker push lucas4xin/multi-server:latest
docker push lucas4xin/multi-worker:latest

docker push lucas4xin/multi-client:$SHA
docker push lucas4xin/multi-server:$SHA
docker push lucas4xin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lucas4xin/multi-server:$SHA
kubectl set image deployments/client-deployment client=lucas4xin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lucas4xin/multi-worker:$SHA
