import sys


def print_row(word, files_set):
    if word:
        print(word + '\t' + str(sum(files_set.values())))


current_word = None
files = dict()
files_banned = set()

for line in sys.stdin:
    word, text_id, flag = line.strip().split('\t', 1)
    if current_word != word:
        print_row(current_word, files)
        files.clear()
        files_banned.clear()
        current_word = word
    if flag == '0' or text_id in files_banned:
        files_banned.add(text_id)
        files[text_id] = 0
        continue
    if text_id in files.keys():
        files[text_id] += 1
    else:
        files[text_id] = 1
print_row(current_word, files)

