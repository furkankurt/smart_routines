/// Represents a condition that can be applied to a property
enum Condition {
  /// The property value is above the input value
  above,

  /// The property value is below the input value
  below,

  /// The property value is equals to the input value
  equals,

  /// The property value is not equals to the input value
  notEquals,

  /// The property value contains the input value
  contains,

  /// The property value does not contain the input value
  notContains,
}
