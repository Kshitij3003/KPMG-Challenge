def get_value(object, key):
  """
  Get the value of a nested object given the key.

  Args:
    object: The nested object.
    key: The key to the value.

  Returns:
    The value of the key.
  """

  keys = key.split("/")
  current_object = object
  for key in keys:
    if key not in current_object:
      return None
    current_object = current_object[key]
  return current_object


if __name__ == "__main__":
  object = {"a": {"b": {"c": "d"}}}
  key = "a/b/c"
  value = get_value(object, key)
  print(value)


  object = {"x": {"y": {"z": "a"}}}
  key = "x/y/z"
  value = get_value(object, key)
  print(value)
