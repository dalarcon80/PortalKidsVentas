import pandas as pd

df = pd.read_csv(r'C:\Users\sarac\Ventas\PortalKidsVentas\students\ealarconm1\data\bronze\customers.csv', sep= ',')

print("shape:",df.shape)
print(df.head(8))
print(df.dtypes)
print(df.columns.tolist())
print(len(df))
