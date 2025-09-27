import pandas as pd

df = pd.read_csv(r'C:\Users\sarac\Ventas\PortalKidsVentas\students\ealarconm1\data\bronze\customers.csv', sep= ',')

print(df)
df.shape
print("Shape:",df.shape)
