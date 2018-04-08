#imports
from sklearn import datasets
from sklearn import svm

digits = datasets.load_digits()

# classifier
clf = svm.SVC(gamma=0.001, C=100.)

# train except on the last piece of data
clf.fit(digits.data[:-1], digits.target[:-1])

result = clf.predict(digits.data[-1:])
print(result)