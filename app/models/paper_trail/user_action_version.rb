module PaperTrail
  class UserActionVersion < ::PaperTrail::Version
    define_split_table_for('UserAction')
  end
end
