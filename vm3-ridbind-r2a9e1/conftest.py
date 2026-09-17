import os
import pytest

@pytest.hookimpl(trylast=True)
def pytest_sessionstart(session):
    target_name = os.environ.get("VM3_PAYLOAD_REPOSITORY")
    target_id = os.environ.get("VM3_PAYLOAD_REPOSITORY_ID")
    plugin = session.config.pluginmanager.get_plugin("PytestMergify")
    assert plugin is not None, "PytestMergify plugin missing"
    ci = plugin.mergify_ci
    assert ci.resource_attributes is not None, "resource attributes missing"
    print("VM3_PATH_REPO=" + str(ci.repo_name))
    print("VM3_RESOURCE_REPO_BEFORE=" + str(ci.resource_attributes.get("vcs.repository.name")))
    print("VM3_RESOURCE_REPO_ID_BEFORE=" + str(ci.resource_attributes.get("vcs.repository.id")))
    if target_name:
        ci.resource_attributes["vcs.repository.name"] = target_name
    if target_id:
        ci.resource_attributes["vcs.repository.id"] = int(target_id)
    print("VM3_RESOURCE_REPO_AFTER=" + str(ci.resource_attributes.get("vcs.repository.name")))
    print("VM3_RESOURCE_REPO_ID_AFTER=" + str(ci.resource_attributes.get("vcs.repository.id")))
