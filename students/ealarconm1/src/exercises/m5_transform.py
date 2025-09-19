
import pandas as pd

def clean_orders(orders: 'pd.DataFrame') -> 'pd.DataFrame':
    # TODO: convertir quantity a int y filtrar >0
    raise NotImplementedError("Implementa clean_orders")

def sort_products_by_price(products: 'pd.DataFrame', descending: bool = True) -> 'pd.DataFrame':
    # TODO: products.sort_values('price', ascending=not descending)
    raise NotImplementedError("Implementa sort_products_by_price")    

def units_by_product(orders: 'pd.DataFrame', products: 'pd.DataFrame') -> 'pd.DataFrame':
    # TODO: merge by product_id, groupby name, sum quantity, sort desc
    raise NotImplementedError("Implementa units_by_product")
