class OpaqueType {
  opaque type Ident = String
  trait Animal
  trait RunFaster

  opaque type FastAnimal = Animal with RunFaster
  opaque type FastAnimalBound <: Animal & RunFaster = Tiger

  class Tiger extends Animal with RunFaster
}
