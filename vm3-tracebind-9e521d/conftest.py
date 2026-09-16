import os
import pytest

@pytest.hookimpl(trylast=True)
def pytest_sessionstart(session):
    target = os.environ.get("VM3_PAYLOAD_REPOSITORY")
    plugin = session.config.pluginmanager.get_plugin("PytestMergify")
    assert plugin is not None, "PytestMergify plugin missing"
    ci = plugin.mergify_ci
    assert ci.resource_attributes is not None, "resource attributes missing"
    print("VM3_PATH_REPO=" + str(ci.repo_name))
    print("VM3_RESOURCE_REPO_BEFORE=" + str(ci.resource_attributes.get("vcs.repository.name")))
    print("VM3_RESOURCE_REPO_ID=" + str(ci.resource_attributes.get("vcs.repository.id")))
    if target:
        ci.resource_attributes["vcs.repository.name"] = target
    print("VM3_RESOURCE_REPO_AFTER=" + str(ci.resource_attributes.get("vcs.repository.name")))
