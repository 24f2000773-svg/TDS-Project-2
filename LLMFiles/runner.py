
import pandas as pd

df = pd.read_csv("demo-audio-data.csv", header=None)
cutoff = 62188
answer = df[df[0] > cutoff].sum().iloc[0]
print(answer)
