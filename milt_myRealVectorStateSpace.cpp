#include <ompl/base/StateSpace.h>
#include <ompl/geometric/SimpleSetup.h>
#include <ompl/base/SpaceInformation.h>
#include "ompl/base/State.h"
#include <ompl/base/spaces/RealVectorStateSpace.h>
#include "statespace.h"
#include <vector>
#include <iostream>		
#include"milt_myRealVectorStateSpace.h"
#include"math.h"
using namespace std;
namespace ob = ompl::base;
namespace og = ompl::geometric;

extern Manipulator ur2;

milt_myRealVectorStateSpace::milt_myRealVectorStateSpace(unsigned int dim, double tol, std::vector< std::vector<double> > C,int m, std::vector< std::vector<double> >(*func)(Eigen::Matrix4d)):RealVectorStateSpace::RealVectorStateSpace(dim)
{
	tolrence = tol;
	Constraint = C;
	mode = m;
	this->Cfun = func;
}
void  milt_myRealVectorStateSpace::interpolate(const ob::State *from, const  ob::State *to, double t, ob::State *state) const
{
	double h = abs(t);
	Eigen::Matrix4d T_state;
	Eigen::Matrix<double, 6, 6> J;
	Eigen::Matrix<double, 6, 1> v_x;
	Eigen::Matrix<double, 6, 1> v;
	Eigen::Matrix<double, 6, 1> v_x_new;
	Eigen::Matrix<double, 6, 1> C;

	double* val1 = static_cast<const ob::RealVectorStateSpace::StateType*>(from)->values;
	double* val2 = static_cast<const ob::RealVectorStateSpace::StateType*>(to)->values;
	double* val3 = static_cast<const ob::RealVectorStateSpace::StateType*>(state)->values;

	double sum = 0;

	if (h > 0.000001)
	{
		
		for (int i = 0; i < 6; i++)
		{
			v[i] =(val2[i] - val1[i]);
			sum = sum + pow(v[i], 2);
		}
		sum = sqrt(sum);
		for (int i = 0; i < 6; i++)
		{
			v[i] = 0.005*v[i] / sum;
		}
	}
	else
	{
		for (int i = 0; i < 6; i++)
		{
			val3[i] = 100;
		}
		return;
	}

	T_state = ur2.kinematics(val1);

	J = ur2.Jacobi(val1);
	//std::cout << "t=" << t << std::endl;
	//std::cout << "Jacobi=" << std::endl;
	//for (int j = 0; j < 6; j++)
	//{
	//	std::cout << J(j, 0) << " " << J(j, 1) << " " << J(j, 2) << " " << J(j, 3) << " " << J(j, 4) << " " << J(j, 5) << std::endl;
	//}
	//double s=0;

	v_x = J * v;
	/*v_x << 0.01, 0, 0, 0, 0, 0;*/
	//std::cout << "v=" << v(0) << "  " << v(1) << "  " << v(2) << "  " << v(3) << "  " << v(4) << "  " << v(5) << std::endl;
	v_x_new << 0, 0, 0, 0, 0, 0;
	std::vector< std::vector<double> > C2 ;
	if (this->mode == 0) 
	{
		for (size_t i = 0; i < 6; i++)
		{
			C << Constraint[i][0], Constraint[i][1], Constraint[i][2], Constraint[i][3], Constraint[i][4], Constraint[i][5];
			v_x_new = v_x_new + v_x.dot(C)*C;
		}
	}
	else 
	{
		C2=Cfun(T_state);
		for (size_t i = 0; i < 6; i++)
		{
			C << C2[i][0], C2[i][1], C2[i][2], C2[i][3], C2[i][4], C2[i][5];
			v_x_new = v_x_new + v_x.dot(C)*C;
		}
	}


	

	/*std::cout << "v_x=" << v_x(0) << "  "<<v_x(1) << "  " << v_x(2) << "  " << v_x(3) << "  " << v_x(4) << "  " << v_x(5) << std::endl;
	std::cout << "v_x=" << v_x_new(0) << "  " << v_x_new(1) << "  " << v_x_new(2) << "  " << v_x_new(3) << "  " << v_x_new(4) << "  " << v_x_new(5) << std::endl;
*/
	Eigen::Matrix4d T_v_new1;
	Eigen::Matrix4d T_v_new2;



	T_v_new1<< 1, -v_x_new(5), v_x_new(4), 0,
		v_x_new(5), 1, -v_x_new(3), 0,
		-v_x_new(4), v_x_new(3), 1, 0,
		0, 0, 0, 1;
	T_v_new2 << 1, 0, 0, v_x_new(0),
		0, 1, 0, v_x_new(1),
		0, 0, 1, v_x_new(2),
		0, 0, 0, 1;


	//std::cout << "运算前" << std::endl;
	//std::cout << T_state << std::endl;

	T_state.block<3, 3>(0, 0) = T_v_new1.block<3, 3>(0, 0) *T_state.block<3, 3>(0, 0);
	T_state = T_v_new2 * T_state;
	//std::cout << "运算后" << std::endl;
	//for (int j = 0; j < 4; j++)
	//{
	//	std::cout << T_state(j, 0) << " " << T_state(j, 1) << " " << T_state(j, 2) << " " << T_state(j, 3) << std::endl;
	//}

	double ** slotion;
	slotion = ur2.ik(T_state);
	if (slotion[0][0] != 100)
	{
		int n = 0;
		double dis = 100000;

		for (int i = 0; i < 8; i++)
		{
			double sum1 = 0;
			for (int j = 0; j < 6; j++)
			{
				if (slotion[i][j] > pi)
				{
					slotion[i][j] = slotion[i][j] - pi * 2;
				}
				if (slotion[i][j]< -pi)
				{
					slotion[i][j] = slotion[i][j] + pi * 2;
				}
					
				double c = min(min(abs(slotion[i][j] - val1[j]), abs(slotion[i][j] - val1[j] + 2 * pi)), abs(slotion[i][j] - val1[j] - 2 * pi));
				sum1 = sum1 + pow(c, 2);
			}
			sum1 = sqrt(sum1);
			if (sum1 < dis)
			{
				n = i;
				dis = sum1;
			}
		}
		if (dis < 0.2)
		{
			for (int j = 0; j < 6; j++)
			{
				val3[j] = slotion[n][j];
			}
		}
		else
		{
			val3[0] = 100;

		}

	}
	else
	{
		val3[0] = 100;
	}
	if (val3[0] != 100)
	{
		double d1 = 0;
		for (int i = 0; i < 6; i++)
		{
			v[i] = (val2[i] - val3[i]);
			d1 = d1 + pow(v[i], 2);
		}
		if (sqrt(d1) > sum)
		{
			val3[0] = 100;
		}
	}
	//std::cout << " va1=" << val1[0] << " " << val1[1] << " " << val1[2] << " " << val1[3] << " " << val1[4] << " " << val1[5] << std::endl;
	//std::cout << " va3=" << val3[0] << " " << val3[1] << " " << val3[2] << " " << val3[3] << " " << val3[4] << " " << val3[5] << std::endl;
}

double milt_myRealVectorStateSpace::distance(const ob::State *state1, const ob::State *state2) const
{
	double dist = 0.0;
	const double *s1 = static_cast<const StateType *>(state1)->values;
	const double *s2 = static_cast<const StateType *>(state2)->values;

	for (unsigned int i = 0; i < dimension_; ++i)
	{
		double diff = ((*s1++) - (*s2++));
		dist += diff * diff;
	}
	return sqrt(dist);
}
void  milt_myRealVectorStateSpace::setCfun(std::vector< std::vector<double> >(*func)(Eigen::Matrix4d))
{
	this->Cfun = func;
}