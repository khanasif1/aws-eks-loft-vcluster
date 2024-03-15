# Run/Test APP

```
cd aws-eks-loft-vcluster/app/product 

python3 -m venv vclusterenv 

source ./vclusterenv/bin/activate 

pip install --no-cache-dir --upgrade -r requirements.txt 

uvicorn productApi:app --reload  


http://127.0.0.1:8000/docs

```

# Docker Build & Publish
 
```

docker build -t product_api:rc0 .  

docker run -d -p 8080:80 -e current_env='localDev'  --name productapi product_api:rc

docker login

docker tag product_api:rc0 khanasif1/product_api:rc0

docker push khanasif1/product_api:rc0         

```

- Browser locally : http://localhost:8080/docs
- check logs