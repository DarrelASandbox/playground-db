# while True:
#     txt = input("Enter a string: ")
#     if len(txt) < 1:
#         break

#     hv = 0
#     pos = 0
#     for let in txt:
#         pos = (pos % 3) + 1
#         hv = (hv + (pos * ord(let))) % 1000000
#         print(let, pos, ord(let), hv)

#     print(hv, txt)


def hash_string(txt):
    hv = 0
    pos = 0
    for let in txt:
        pos = (pos % 3) + 1
        hv = (hv + (pos * ord(let))) % 1000000
    return hv


def find_collisions(num_tests=100000):
    hash_map = {}
    collisions = []

    import random, string

    for _ in range(num_tests):
        test_string = "".join(
            random.choices(string.ascii_letters, k=random.randint(3, 10))
        )
        hv = hash_string(test_string)

        if hv in hash_map and hash_map[hv] != test_string:
            collisions.append((hash_map[hv], test_string, hv))
        else:
            hash_map[hv] = test_string

    return collisions


# Run collision detection
collisions = find_collisions()
if collisions:
    print(f"Found {len(collisions)} collisions:")
    for c1, c2, hv in collisions:
        print(f"Collision: '{c1}' and '{c2}' -> Hash: {hv}")
else:
    print("No collisions found.")
