module PaperTrail
  class UserVersion < ::PaperTrail::Version
    define_split_table_for('User')
  end
end
