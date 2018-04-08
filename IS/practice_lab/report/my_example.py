from sklearn import datasets
from sklearn.cross_validation import cross_val_score
from sklearn.cross_validation import ShuffleSplit
from sklearn.preprocessing import StandardScaler
from sklearn import svm

wine = datasets.load_wine()
X = wine.data
y = wine.target

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

clf = svm.SVC()

Split = ShuffleSplit(n = len(y), test_size=0.2)
scores = cross_val_score(clf, X_scaled, y, scoring = 'accuracy', cv = Split)
print(np.mean(scores))
