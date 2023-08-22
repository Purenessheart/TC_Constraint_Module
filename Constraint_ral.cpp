#include"Constraint_ral.h"
extern Manipulator ur2;

//Eigen::Matrix4d T;
Constraint_ral::Constraint_ral(int n1, int n2, double tol) :Constraint(n1, n2, tol)
{
}
void Constraint_ral::function(const Eigen::Ref<const Eigen::VectorXd> &x, Eigen::Ref<Eigen::VectorXd> out) const
{
	//std::cout << "x1=" << x[0] << " " << x[1] << " " << x[2] << " " << x[3] << " " << x[4] << " " << x[5] << std::endl;
	//std::cout << n_ << " " << k_ << std::endl;
	double theta[6];
	double C[6];
	for (int i = 0; i < 6; ++i)
	{
		theta[i] = x[i];
		C[i] = CON[i];
	}

	Eigen::Matrix4d T;
	Eigen::Matrix4d T1;
	T = ur2.kinematics(theta);
	//std::cout << "T=" << T << std::endl;
	double *J;
	J = ur2.Tjuzhen(T);

	T1 = ur2.kinematics(C);
	//std::cout << "T=" << T << std::endl;
	double *J1;
	J1 = ur2.Tjuzhen(T1);

	double distance[6];
	for (int i = 0; i < 6; ++i)
	{
		distance[i] = J1[i] - J[i];
	}
	out[0] = -0.001*distance[3];
	out[1] = -0.001*distance[4];
	//out[2] = -0.001*distance[3];
	//out[3] = -0.001*distance[4];
	//out[4] = -0.001*distance[5];


}

