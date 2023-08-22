#pragma once
#include <Eigen/Dense>
static double pi = 3.1415926535898;
class Manipulator
{
public:
	Manipulator();
	~Manipulator();
	void sloveT(double *theta);
	Eigen::Matrix4d kinematics(double *theta);
	Eigen::Matrix<double, 6, 6> Jacobi(double *theta);
	double ** ik(Eigen::Matrix4d T);
	double * pingyi(double *theta, double *dx);
	double* Tjuzhen(Eigen::Matrix4d T);
	void setT_tool(Eigen::Matrix4d T);
private:
	double alpha[6] = { pi / 2, 0, 0, pi / 2, -pi / 2, 0 };
	double a[6] = { 0,-0.425,-0.39225,0,0,0 };
    double d[6] = { 0.089159,0,0,0.10915,0.09465,0.0823 };
	double joint[6]={100, 100,100,100,100,100};
	Eigen::Matrix4d T[6];
	Eigen::Matrix4d T_tool= Eigen::MatrixXd::Identity(4, 4);
	
};

