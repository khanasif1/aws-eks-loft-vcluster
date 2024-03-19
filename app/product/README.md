# Product - Docker Run/Test APP

```
cd aws-eks-loft-vcluster/app 

===========================================================
$$ If you have already set venv then skip next 3 step $$
===========================================================
python3 -m venv vclusterenv 

source ./vclusterenv/bin/activate 

pip install --no-cache-dir --upgrade -r requirements.txt 

uvicorn _src.productApi:app --reload  


http://127.0.0.1:8000/docs

```

# Docker Build & Publish
 
## Product 
```

docker build -t product_api:rc0.1 .  

docker run -d -p 8080:80 -e current_env='localDev'  --name productapi product_api:rc0.1

http://127.0.0.1:8080/docs

docker login

docker tag product_api:rc0.1 khanasif1/product_api:rc0.1

docker push khanasif1/product_api:rc0.1

```

- Browser locally : http://localhost:8080/docs
- check logs
