
import pandas as pd

def load_orders(path: str) -> 'pd.DataFrame':
    """Lee un CSV de órdenes desde `path` y devuelve un DataFrame."""
    # TODO: usa pandas.read_csv(path, parse_dates=['order_date'])
    raise NotImplementedError("Implementa load_orders")

def preview(df: 'pd.DataFrame', n: int = 3) -> 'pd.DataFrame':
    # TODO: return df.head(n)
    raise NotImplementedError("Implementa preview")
