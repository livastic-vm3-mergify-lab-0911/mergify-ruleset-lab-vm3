import pytest


@pytest.mark.mergify(flaky_detection=False, auto_retry=False)
def test_vm3_context_probe(request):
    plugin = next(
        p
        for p in request.config.pluginmanager.get_plugins()
        if p.__class__.__name__ == "PytestMergify"
    )
    ctx = plugin.mergify_ci.run_context_dict or {}
    print(
        "VM3_CONTEXT "
        f"budget_ratio_for_test_retries={ctx.get('budget_ratio_for_test_retries')} "
        f"flaky_test_names_count={len(ctx.get('flaky_test_names') or [])} "
        f"broken_test_names_count={len(ctx.get('broken_test_names') or [])} "
        f"existing_test_names_count={len(ctx.get('existing_test_names') or [])} "
        f"max_test_execution_count={ctx.get('max_test_execution_count')} "
        f"min_test_execution_count={ctx.get('min_test_execution_count')} "
        f"test_retrier_active={plugin.mergify_ci.test_retrier is not None}"
    )
