import DS from 'ember-data';

export default DS.RESTSerializer.extend(DS.EmbeddedRecordsMixin, {
  primaryKey: 'neo_id',
   attrs : {
    stats: { embedded: 'always' }
  },

});
