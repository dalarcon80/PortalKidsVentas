
import os
import pandas as pd

def to_bronze(role: str, df: 'pd.DataFrame', base_dir: str) -> str:
    """Escribe el DataFrame en BRONZE y devuelve la ruta."""
    # TODO: if role=='VENTAS': name='orders_ventas.csv' else: 'orders_ops.csv'
    raise NotImplementedError("Implementa to_bronze")
