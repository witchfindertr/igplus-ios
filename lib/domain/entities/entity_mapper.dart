abstract class EntityMapper<Entity, Model> {
  Entity mapToEntity(Model model);
  Model mapToModel(Entity entity);
}
