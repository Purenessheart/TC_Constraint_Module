#pragma once
#include "ompl/base/Constraint.h"
#include "ompl/base/State.h"
#include "‘À∂Ø—ß.h"

namespace ob = ompl::base;

class Constraint_ral : public ob::Constraint
{
public:
	Constraint_ral(int n, int c, double tol);
	void function(const Eigen::Ref<const Eigen::VectorXd> &x, Eigen::Ref<Eigen::VectorXd> out) const override;
	//void jacobian(const Eigen::Ref< const Eigen::VectorXd> &x, Eigen::Ref< Eigen::MatrixXd > out) const override;
private:
	double CON[6] = { 1.5037, -1.4883,    0.7097 ,-0.7922  ,  1.5708 ,-1.5037 };

};

