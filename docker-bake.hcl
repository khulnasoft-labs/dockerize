group "default" {
  targets = ["validate"]
}

group "validate" {
  targets = ["license-validate"]
}

target "license-validate" {
  target = "license-validate"
  output = ["type=cacheonly"]
}

target "license-update" {
  target = "license-update"
  output = ["."]
}
