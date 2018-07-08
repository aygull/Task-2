def getFunctions(storedFunction):
    class Inner:
        @staticmethod
        @storedFunction
        def set_model(name: str, color: str): pass

        @staticmethod
        @storedFunction
        def get_model(modelId: int): pass

    return Inner
