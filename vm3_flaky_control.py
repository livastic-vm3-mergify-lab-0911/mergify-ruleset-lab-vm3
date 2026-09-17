execution_count = 0


def test_vm3_unique_new_flaky_control():
    global execution_count
    execution_count += 1
    print(f"VM3_CONTROL_EXECUTION={execution_count}")
    # Initial execution passes. Any Flaky Detection rerun must fail.
    assert execution_count == 1
