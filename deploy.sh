docker build -t marcell0major/multi-client:latest -t marcell0major/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcell0major/multi-server:latest -t marcell0major/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcell0major/multi-worker:latest -t marcell0major/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcell0major/multi-client:latest
docker push marcell0major/multi-server:latest
docker push marcell0major/multi-worker:latest

docker push marcell0major/multi-client:$SHA
docker push marcell0major/multi-server:$SHA
docker push marcell0major/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=marcell0major/multi-server:$SHA
kubectl set image deployments/client-deployment client=marcell0major/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marcell0major/multi-worker:$SHA
