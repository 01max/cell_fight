# frozen_string_literal: true.
##
# Fighter is the app central model.
# @since v0
#
class Fighter < ApplicationRecord
  MAX_TOTAL_BASE_POINTS = ENV['MAX_TOTAL_BASE_POINTS'].to_i
  MAX_DEFENSE_BASE_POINTS = ENV['MAX_DEFENSE_BASE_POINTS'].to_i
  MAX_HEALTH_BASE_POINTS = ENV['MAX_HEALTH_BASE_POINTS'].to_i

  validates :name, presence: true

  validates :attack_base_points,
    presence: true,
    numericality: { only_integer: true }
  validates :defense_base_points,
    presence: true,
    numericality: {
      less_than_or_equal_to: MAX_DEFENSE_BASE_POINTS,
      only_integer: true
    }
  validates :health_base_points,
    presence: true,
    numericality: {
      less_than_or_equal_to: MAX_HEALTH_BASE_POINTS,
      only_integer: true
    }

  validate :has_valid_base_points?

  after_initialize :set_default_base_points

  # String version of the instance (using +name+ & +id+).
  # @return [String]
  #
  def to_s
    "#{name} [#{id}]"
  end

  # The total amount of base points (distributed between +attack_base_points+, +defense_base_points+ & +health_base_points+)
  # @return [Integer]
  # @see attack_base_points
  # @see defense_base_points
  # @see health_base_points
  #
  def total_base_points
    attack_base_points.to_i + defense_base_points.to_i + health_base_points.to_i
  end

  # The maximum health points (calculated with +total_base_points+, +defense_base_points+ & +health_base_points+)
  # @return [Integer]
  # @see total_base_points
  # @see defense_base_points
  # @see health_base_points
  #
  def max_health
    (total_base_points + defense_base_points.to_i + health_base_points.to_i*2)*10
  end

  private

  # Validation that +total_base_points+ is not above Fighter::MAX_TOTAL_BASE_POINTS
  # @return [Boolean]
  # @see total_base_points
  #
  def has_valid_base_points?
    if total_base_points > MAX_TOTAL_BASE_POINTS
      error_label = I18n.t('activerecord.errors.models.fighter.attack_base_points.total_base_points_must_be_below', max_value: MAX_TOTAL_BASE_POINTS)
      errors.add(:attack_base_points, error_label)
      return false
    end
    return true
  end

  # Set all undefined *_base_points attributes value to 0.
  #
  def set_default_base_points
    self.attack_base_points ||= 0
    self.defense_base_points ||= 0
    self.health_base_points ||= 0
  end
end
