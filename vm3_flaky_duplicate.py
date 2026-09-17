item_order = []
item_counts = {}


def test_vm3_duplicate_nodeid_treatment(request):
    item_key = id(request.node)
    if item_key not in item_counts:
        item_counts[item_key] = 0
        item_order.append(item_key)

    item_counts[item_key] += 1
    occurrence = item_order.index(item_key) + 1
    execution = item_counts[item_key]
    print(
        f"VM3_TREATMENT_OCCURRENCE={occurrence} "
        f"ITEM_KEY={item_key} EXECUTION={execution}"
    )

    # First collected Item is a benign budget consumer and always passes.
    if occurrence == 1:
        return

    # The second distinct Item has the exact same pytest nodeid. Its initial
    # execution passes; any independent Flaky Detection rerun must fail.
    assert execution == 1
