# frozen_string_literal: true.
##
# Fight is the interraction model between Fighters.
# @since v3
#
class Fight < ApplicationRecord
  belongs_to :fighter_a, class_name: :Fighter
  belongs_to :fighter_b, class_name: :Fighter

  belongs_to :winner, class_name: :Fighter, optional: true

  validate :has_two_different_opponents?

  after_create :distribute_xp!
  before_create :start!

  before_save :set_title

  # String version of the instance (using +name+ & +id+).
  # @return [String]
  #
  def to_s
    "##{id} - #{fighter_a} VS #{fighter_b}"
  end

  # Start the Fight process if the Fighters are defined, and if it has not started already
  # @return [Fight or Boolean]
  #
  def start!
    return self.errors.messages unless self.valid?
    unless hits.nil? || hits.empty?
      return false && raise(StandardError, 'Cannot restart a fight')
    end

    self.hits = []

    fighters = [fighter_a, fighter_b].shuffle
    hit_until_death(fighters.first, fighters.last)
  end

  private

  # Recursive function to determine a winner of a Fight
  # @return [Fight]
  #
  def hit_until_death(attacker, defender)
    damages = attacker.hit(defender)
    defender.current_health -= attacker.hit(defender)

    self.hits << {
      attacker_id: attacker.id,
      defender_id: defender.id,
      damages: damages
    }

    if defender.current_health == 0
      self.winner = attacker
      set_xp_gain(defender)
      return self.winner
    else
      hit_until_death(defender, attacker)
    end
  end

  # Compute xp from a fight
  # @return [Integer]
  #
  def set_xp_gain(looser)
    return unless self.winner
    self.xp_gain = (looser.xp + looser.total_base_points)/10
  end

  # Update the +winner+ xp resulting from a Fight
  # @return [Boolean]
  #
  def distribute_xp!
    return false unless self.winner
    set_xp_gain((fighters - [self.winner]).first) if xp_gain.nil?
    winner.update!(xp: winner.xp + xp_gain)
  end

  # Validate that +fighter_a+ & +fighter_b+ are two different Fighters
  # @return [Boolean]
  #
  def has_two_different_opponents?
    if fighter_a == fighter_b
      error_label = I18n.t('activerecord.errors.models.fight.fighter_a.opponents_must_be_differents')
      errors.add(:fighter_a, error_label)
      errors.add(:fighter_b, error_label)
      return false
    end
    return true
  end

  def set_title
    self.title = self.to_s
  end
end
