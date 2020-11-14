docker build -t mintedguy/multi-client:latest -t mintedguy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mintedguy/multi-server:latest -t mintedguy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mintedguy/multi-worker:latest -t mintedguy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mintedguy/multi-client:latest
docker push mintedguy/multi-server:latest
docker push mintedguy/multi-worker:latest

docker push mintedguy/multi-client:$SHA
docker push mintedguy/multi-server:$SHA
docker push mintedguy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mintedguy/multi-server:$SHA
kubectl set image deployments/client-deployment client=mintedguy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mintedguy/multi-worker:$SHA