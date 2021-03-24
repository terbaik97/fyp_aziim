module PaperTrail
  class PoiVersion < ::PaperTrail::Version
    define_split_table_for('Poi')
  end
end
