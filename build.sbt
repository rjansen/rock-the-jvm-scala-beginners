name := "rock-the-jvm-scala-beginners"
scalaVersion := "2.13.1"
fork := true
scalaSource in Compile := baseDirectory.value / "src"
scalaSource in Test := baseDirectory.value / "test"
javaSource in Compile := baseDirectory.value / "src"
javaSource in Test := baseDirectory.value / "test"
resourceDirectory in Compile := baseDirectory.value / "src/resources"
resourceDirectory in Test := baseDirectory.value / "test/resources"
