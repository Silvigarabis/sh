#!/usr/bin/env python
weight = input("your weight is? ")
height = input("your height is? ")
bmi = float(weight) / ( float(height) ** 2 )
print(f"your bmi: {bmi:.2f}")
if bmi <= 18.5:
    print("you are so thin!")
elif bmi <= 25 and bmi > 18.5:
    print("well, you are fit.")
elif bmi <= 28 and bmi > 25:
    print("it looks you are a little heavy.")
elif bmi <= 32 and bmi > 28:
    print("you are fat, what about doing exercise?")
else:
    print("i dont want to tell the truth, but could you active? otherwise you may die of you fat")
