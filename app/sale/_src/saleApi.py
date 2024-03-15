from typing import Optional

from fastapi import FastAPI
from pydantic import BaseModel
import os

currentEnvironment = os.environ.get('current_env')
if currentEnvironment is None:
   currentEnvironment = "!!Environment missing!!"  
class Item(BaseModel):
    sale: str
    description: Optional[str] = None
    product: str
    count: float
app = FastAPI()

@app.get("/ping")
def ping():
  print(f'Env:{currentEnvironment}-ping sale api called !!')
  return {"Hi from sale API!"}

@app.get("/list")
def listProducts():
   print(f'Env:{currentEnvironment}-list sale api called !!')
   return [
        Item(sale="Coles",product="Coke", count=2000),
        Item(sale="Woolies",product="Coke", count=125),
        Item(sale="IGA",product="Pepsi", count=3500),
        Item(sale="Bondi", product="Fanta", count=890),
        Item(sale="SydCBD", product="7up", count=10000)
    ]