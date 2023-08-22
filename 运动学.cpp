#include <iostream>
#include <vector>
#include <cmath>
#include "运动学.h"

using namespace std;

Eigen::Matrix<double, 6, 6> Jac;
Eigen::Vector3d z[7];
Eigen::Vector3d p[7];
Eigen::Matrix<double, 3, 3> R0_[6];
Eigen::Matrix<double, 6, 1> j[6];
Eigen::Matrix4d T0_[6];
Eigen::Matrix4d T0_tool;
Eigen::Matrix4d T_6[6];
Eigen::Vector3d h;

Manipulator::Manipulator()
{
	
	T_tool << 1, 0, 0,-0.3,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1;
	
	
}

Manipulator::~Manipulator()
{
}

void Manipulator::sloveT(double *theta)
{
	int n_joint = 0;
	for (int i = 0; i < 6; i++)
	{
		if (theta[i] != joint[i])
		{
			break;
		}
		n_joint++;
	}
	if(n_joint!=6)
	{
		//Eigen::Matrix4d T0;
		for (int i = 0; i < 6; i++)
		{
		   T[i]<< cos(theta[i]), -sin(theta[i])*cos(alpha[i]), sin(theta[i])*sin(alpha[i]), a[i] * cos(theta[i]),
				sin(theta[i]), cos(theta[i])*cos(alpha[i]), -cos(theta[i])*sin(alpha[i]), a[i] * sin(theta[i]),
				0, sin(alpha[i]), cos(alpha[i]), d[i],
				0, 0, 0, 1;
			joint[i] = theta[i];
		}
		T[5] = T[5] ;
	}
	
}

Eigen::Matrix<double, 6, 6> Manipulator::Jacobi(double *theta)
{
	sloveT(theta);
	Eigen::Matrix4d TB;
	for (int i = 0; i < 6; i++)
	{

		if (i == 0)
		{
			T0_[i] = T[i];
		}
		else  
		{
			T0_[i] = (T0_[i - 1])*T[i];
			if (i == 5)
			{
				T0_[5] =T0_[5] * T_tool;
			}
		}	
		z[i+1] = T0_[i].block(0, 2, 3, 1);	
		p[i+1]= T0_[i].block(0, 3, 3, 1);
	}
	z[0] = { 0,0,1 };
	p[0] = { 0,0,0 };
	/*T0_tool = T0_[5] * T_tool;*/
	Eigen::Vector3d p6= T0_tool.block(0, 3, 3, 1);
	for (int i=0; i < 6; i++)
	{
		h =p[6]-p[i];
		j[i] << z[i].cross(h),
			    z[i];
		//std::cout << h(0,0) << " " << h(1,0) << " " << h(2,0) << std::endl;
		//std::cout << j[i](0,0) << " " << j[i](1,0) << " " << j[i](2, 0) << j[i](3, 0) << " " << j[i](4, 0) << " " << j[i](5, 0) << std::endl;
	}
	Jac << j[0], j[1], j[2], j[3], j[4], j[5];
	return Jac;
}

Eigen::Matrix4d Manipulator::kinematics(double *theta)
{
	sloveT(theta);
	Eigen::Matrix4d T0;
	T0 = T[0] * T[1] * T[2] * T[3] * T[4] * T[5]* T_tool;
	for (int i = 0; i < 4; i++)
	{
		//cout << T0(i, 0) << "  " << T0(i, 1) << "  " << T0(i, 2) << "  " << T0(i, 3) << "  " << endl;
	}
	return T0;
}
	

double* Manipulator::Tjuzhen(Eigen::Matrix4d T)
{
	double d[6];
	/*cout << T << endl;*/
	
	for (int i = 0; i < 3; i++)
	{	
		d[i] = T(i, 3);
	}
	double theta = acos((T(0, 0) + T(1, 1) + T(2, 2)-1) / 2);
	double r[3] = { 1 / (2 * sin(theta))*(T(2, 1) - T(1, 2)), 1 / (2 * sin(theta))*(T(0, 2) - T(2, 0)), 1 / (2 * sin(theta))*(T(1, 0) - T(0, 1)) };

	for (int i = 0; i < 3; i++)
	{
		d[i+3] = r[i];
	}

	//cout << d[0] << " " << d[1] << " " << d[2] << " " << d[3] << " " << d[4] << " " << d[5] << std::endl;
	return d;
}

void Manipulator::setT_tool(Eigen::Matrix4d T)
{
	T_tool = T;
}
double ** Manipulator::ik(Eigen::Matrix4d T)
{
	//std::cout << T << std::endl;
	//std::cout << T_tool.inverse() << std::endl;
	Eigen::Matrix4d T0;
	T0 = T;
	T0 = T0 * T_tool.inverse();

	double nx, ox, ax, px;
	double ny, oy, ay, py;
	double nz, oz, az, pz;
	nx = T0(0, 0);
	ox = T0(0, 1);
	ax = T0(0, 2);
	px = T0(0, 3);
	ny = T0(1, 0);
	oy = T0(1, 1);
	ay = T0(1, 2);
	py = T0(1, 3);
	nz = T0(2, 0);
	oz = T0(2, 1);
	az = T0(2, 2);
	pz = T0(2, 3);

	double m = d[5] * ay - py;

	double n = d[5] * ax - px;

	//int iii;
	//int jjj;
	double theta1[2];

	theta1[0]= atan2(m, n) - atan2(d[3], sqrt(pow(m , 2) + pow(n,2) - (pow(d[3],2)) )); 
	theta1[1] = atan2(m, n) - atan2(d[3], -sqrt(pow(m, 2) + pow(n, 2) - (pow(d[3], 2))));
	
	 double theta5[2][2];
	 for (int i = 0; i < 2; i++)
	 {
		 theta5[0][i]= acos(ax*sin(theta1[i]) - ay * cos(theta1[i]));
		 theta5[1][i] = -theta5[0][i];
	 }


	 double theta6[2][2];
	 double mm[2], nn[2];
	 for (int i = 0; i < 2; i++)
	 {

		 mm[i] = nx * sin(theta1[i]) - ny * cos(theta1[i]);
		 nn[i] = ox * sin(theta1[i]) - oy * cos(theta1[i]);

		 for (int j = 0; j < 2; j++)
		 {
			 theta6[j][i] = atan2(mm[i], nn[i]) - atan2(sin(theta5[j][i]), 0);
		 }
	 }
	 double mmm[2][2], nnn[2][2];
	double  theta3[4][2];
	double  theta2[4][2];
	double  theta4[4][2];
	for (int i = 0; i < 2; i++)
	{ 
		for (int j = 0; j < 2; j++)
		{
			mmm[j][i]= d[4]*(sin(theta6[j][i])*(nx*cos(theta1[i]) + ny * sin(theta1[i])) + cos(theta6[j][i])*(ox*cos(theta1[i]) + oy * sin(theta1[i]))) - d[5]*(ax*cos(theta1[i]) + ay * sin(theta1[i])) + px * cos(theta1[i]) + py * sin(theta1[i]);
			nnn[j][i]=pz-d[0]-az*d[5]+d[4]*(oz*cos(theta6[j][i])+nz*sin(theta6[j][i]));

			double s = (pow(mmm[j][i], 2) + pow(nnn[j][i], 2) - pow(a[1], 2) - pow(a[2], 2)) / (2 * a[1] * a[2]);
			//cout << "s="<<s << endl;
			if (s>1)//判断是否有解
			{
				theta2[j][i] = 100;
				theta3[j][i] = 100;
				theta4[j][i] = 100;
				theta2[j+2][i] = 100;
				theta3[j+2][i] = 100;
				theta4[j+2][i] = 100;
				break;
			}
			theta3[j][i] = acos(s);

			double s2 = ((a[2] * cos(theta3[j][i]) + a[1])*nnn[j][i] - a[2] * sin(theta3[j][i])*mmm[j][i]) / (pow(a[1], 2) + pow(a[2], 2) + 2 * a[1] * a[2] * cos(theta3[j][i]));
			double c2 = (mmm[j][i] + a[2] * sin(theta3[j][i])*s2) / (a[2] * cos(theta3[j][i]) + a[1]);
			//cout << "c2=" << c2 << endl;
			if (s2 >1.0e-5)
			{
				theta2[j ][i] = acos(c2);
				//cout << theta2[j][i] << endl;
			}
			else if (s2<-1.0e-5)
			{
						theta2[j ][i] =- acos(c2);
			}
			else
			{
				theta2[j][i] = 0;
			}

			

			theta3[j + 2][i] = -theta3[j][i];
			s2 = ((a[2] * cos(theta3[j+2][i]) + a[1])*nnn[j][i] - a[2] * sin(theta3[j+2][i])*mmm[j][i]) / (pow(a[1], 2) + pow(a[2], 2) + 2 * a[1] * a[2] * cos(theta3[j+2][i]));
		    c2 = (mmm[j][i] + a[2] * sin(theta3[j+2][i])*s2) / (a[2] * cos(theta3[j+2][i]) + a[1]);
			//cout << "c2=" << c2 << endl;
			if (s2>0)
			{
				theta2[j + 2][i]=acos(c2);
				//cout << theta2[j + 2][i] << endl;
			}
			else if (s2 < 0)
			{
				theta2[j+2][i] = -acos(c2);
			}
			else
			{
				theta2[j+2][i] = 0;
			}
		
			
			double s234 = -sin(theta6[j][i])*(nx*cos(theta1[i]) + ny * sin(theta1[i])) - cos(theta6[j][i])*(ox*cos(theta1[i]) + oy * sin(theta1[i]));
			double c234 = oz * cos(theta6[j][i]) + nz * sin(theta6[j][i]);
			double theta234 = atan2(s234, c234);
			theta4[j][i] = theta234 - theta3[j][i] - theta2[j][i];
			theta4[j+2][i] = theta234 - theta3[j+2][i] - theta2[j+2][i];	
		}
	}

	double **theta;
	theta= (double**)new double[8];
	for (int j = 0; j < 8; j++)
	{
		theta[j] = (double*)new double[6];
			int ii = j % 2;//判断奇偶
			int jj = j / 4;//是否大于4
			int hh = j % 4;//4的余数
			theta[j][0] = theta1[ii];
			theta[j][4] = theta5[jj][ii];
			theta[j][5] = theta6[jj][ii];
			if (hh<2)
			{
				theta[j][3] = theta4[jj][ii];
				theta[j][2] = theta3[jj][ii];
				theta[j][1] = theta2[jj][ii];				
			}
			else
			{
				theta[j][3] = theta4[jj+2][ii];
				theta[j][2] = theta3[jj+2][ii];
				theta[j][1] = theta2[jj+2][ii];
			}

			//delete[] theta[j];
	}
	//for (int i = 0; i < 8; i++)
	//{
	//	cout << theta[i][0] << "  " << theta[i][1] << "  " << theta[i][2] << "  " << theta[i][3] << "  " << theta[i][4] << "  " << theta[i][5] << "  " << endl;
	//}
	//
	return theta;
}

double * Manipulator::pingyi(double *theta, double *dx)
{
	Eigen::Matrix4d *T;
	*T = kinematics(theta);
	(*T)(0, 3) = (*T)(0, 3) + dx[0];
	(*T)(1, 3) = (*T)(1, 3) + dx[1];
	(*T)(2, 3) = (*T)(2, 3) + dx[2];
	double** jie;
	jie = ik(*T);
	int ii = -1;
	double distance = 1000;
	double bian[6];
	for (int i = 0; i < 8; i++)
	{

		if (jie[i][2]==100)
		{
			break;
		}
		double distance0 = 0;
		for (int j = 0; j < 6; j++)
		{

			double d0 = jie[i][j] - theta[j];

			if (d0>=0)
			{
				double d1 = d0- 2 * pi;
				while (abs(d0) >abs(d1))
				{
					d0 = d1;
					jie[i][j] = jie[i][j] - 2 * pi;
					d1 = d1 - 2 * pi;
				}
			}
			else
			{
				
				double d1 =d0 + 2*pi;
				while (abs(d0) >abs(d1))
				{
					d0 = d1;
					jie[i][j] = jie[i][j] +2 * pi;
					d1 = d1 + 2 * pi;
				}
			}

			
			double dis =pow(d0, 2);
				distance0 = dis + distance0;
		}
		distance0 = sqrt(distance0);
		if (distance0 < distance)
		{
			ii= i;
			distance = distance0;
		}
	}
	if (ii>=0)
	{
		
		return jie[ii];
	}
	else
	{
		double erro[6] = { 100,100,100,100,100,100 };
		return erro;
	}
}