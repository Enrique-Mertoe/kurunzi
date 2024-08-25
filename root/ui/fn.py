from .comp import ComponentBuilder


def component_loader(**items) -> ComponentBuilder:
    return ComponentBuilder.get_instance(items)
