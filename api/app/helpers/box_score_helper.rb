module BoxScoreHelper

  def _final_score
  	bonus = __base_bonus + __extra_bonus_points
  	bonus += n_double.pred * 10 * bonus if n_double >= 2
  	penalty = __base_penalty + __extra_penalty_points
  	(bonus - penalty).round(2)
  end

  def __base_bonus
  	return points + BallinAPI::ASSIST_BONUS * assists + BallinAPI::DEFR_BONUS * defr \
  	  + BallinAPI::OFR_BONUS * ofr + BallinAPI::STEAL_BONUS * steals \
  	  + BallinAPI::BLOCK_BONUS * blocks
  end

  def __base_penalty
  	return (fta - ftm) * BallinAPI::FT_PENALTY + (fga - lsa - fgm + lsm) * BallinAPI::FG_PENALTY \
  	  + (lsa - lsm) * BallinAPI::LS_PENALTY \
  	  + BallinAPI::TURNOVER_PENALTY * turnovers
  end

  def __extra_bonus
  	{
  		revulsive: revulsive?,
  		splash: splash?,
  		rim_protector: rim_protector?,
  		no_miss: no_miss? && fga > BallinAPI::NO_MISS_FGA,
  		unselfish: unselfish?,
  		hustler: hustler?,
  		five_by_five: five_by_five?
  	}
  end

  def __extra_penalty
  	{
  		posessions_freeaway: posessions_freeaway?,
  		hacked: hacked?,
  		nightmare: nightmare?
  	}
  end

  def __extra_bonus_points
  	__extra_reduce(__extra_bonus)
  end

  def __extra_penalty_points
  	__extra_reduce(__extra_penalty)
  end

  def __extra_reduce(hash)
  	base = 0
  	hash.select { |k,v| v }.each do |name, value|
  		base += "BallinAPI::#{name.upcase}".to_i
  	end
  	base
  end

  def bonus_stats
  	hash = self.props
  	hash.extract! :assists, :defr, :ofr, :steals, :blocks
  end

  def penalty_stats
  	hash = self.props
  	hash.extract! :fta, :ftm, :fga, :fgm, :lsa, :lsm, :turnovers
  end

  def revulsive?
    !self.is_starter && self.points > BallinAPI::POINTS_REVULSIVE && self.minutes < BallinAPI::MINUTES_REVULSIVE
  end

  def splash?
  	(lsa - lsm) == 0 && lsa > BallinAPI::SPLASH_ATTEMPTS
  end

  def rim_protector?
  	blocks > BallinAPI::RIM_PROTECTOR_BLOCKS && defr > BallinAPI::RIM_PROTECTOR_DEFR
  end

  def no_miss?
  	(fga - fgm) + (fta - ftm) == 0
  end

  def unselfish?
  	assists > BallinAPI::UNSELFISH_ASSISTS && fga < BallinAPI::UNSELFISH_FGA
  end

  def hustler?
  	steals > BallinAPI::HUSTLER_STEALS && blocks > BallinAPI::HUSTLER_BLOCKS
  end

  def n_double
  	bonus_stats.select { |k,v| v >= 10 }.count
  end

  def five_by_five?
  	bonus_stats.select { |k,v| v >= 5 }.count == 5
  end

  def posessions_freeaway?
  	turnovers > BallinAPI::POSSESIONS_FREEAWAY_TURNOVERS
  end

  def hacked?
  	return false if fta == 0
  	ftm.fdiv(fta) * 100 < BallinAPI::HACKED_FTM_RATIO && fta > BallinAPI::HACKED_FTA
  end

  def nightmare?
  	return false if fga == 0
  	fgm.fdiv(fgm) * 100 <  BallinAPI::NIGHTMARE_FGM_RATIO &&  fgm > BallinAPI::NIGHTMARE_FGA
  end


end