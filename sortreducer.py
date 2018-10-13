import sys


def print_row(count, words):
    if count:
        for word in words:
            print(word + '\t' + count)


current_count = None
words = []
for line in sys.stdin:
    try:
        count, word = line.strip().split('\t', 1)
        count = str(-int(count))
    except ValueError as e:
        continue
    if current_count != count:
        words.sort()
        print_row(current_count, words)
        words = []
        current_count = count
    words.append(word)
print_row(current_count, words)