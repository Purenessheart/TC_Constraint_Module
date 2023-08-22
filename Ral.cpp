#include <ompl/geometric/SimpleSetup.h>
#include <ompl/base/SpaceInformation.h>
#include <ompl/geometric/planners/rrt/RRT.h>
#include <ompl/geometric/planners/rrt/RRTStar.h>
#include <ompl/geometric/planners/rrt/RRTConnect.h>
#include <ompl/geometric/planners/rrt/LazyRRT.h>
#include <ompl/geometric/planners/est/EST.h>
#include <ompl/geometric/planners/prm/PRM.h>
#include "myConstrain1.h"

#include <iostream>
#include <ompl/geometric/SimpleSetup.h>
#include <ompl/base/SpaceInformation.h>
#include "ompl/base/State.h"
#include "ompl/util/RandomNumbers.h"
#include "ompl/util/ClassForward.h"
#include <vector>
#include <string>
#include <functional>
#include <ompl/geometric/PathGeometric.h>
#include <fstream>
#include "myGoal.h"
#include "ompl/base/State.h"
#include "myConstraint.h"
#include "statespace.h"
#include <ompl/base/ConstrainedSpaceInformation.h>

#include "myRealVectorStateSpace1.h"
#include "ompl/base/spaces/constraint/ProjectedStateSpace.h"
#include "ompl/base/spaces/constraint/AtlasStateSpace.h"
#include "myProjectedStateSpace.h"
#include "vrep.h"
#include <string>
#include<time.h>
#include <direct.h>;
#include"milt_myRealVectorStateSpace.h"
#include"Constraint_ral.h"

clock_t begain;
clock_t end;
clock_t begain1;
clock_t end1;
Manipulator ur2;
namespace ob = ompl::base;
namespace og = ompl::geometric;
VrepConnect ur5sim(6, 1);
std::vector< std::vector<double> > q_intial;
std::vector< std::vector<double> > q_goal;
std::vector< std::vector<double> > C[4];
double Range = 0.01;
double GoalBias =0.2;
double GoalDistance = 0.15;
double tol = 0.00078;
double t=100;
int n_repeated;
int n_node;

bool isStateValid(const ob::State * state)
{
	n_repeated++;
	double* val1 = static_cast<const ob::RealVectorStateSpace::StateType*>(state)->values;
	double joint[6] = { val1[0] ,val1[1] , val1[2] , val1[3] , val1[4] , val1[5] };
	//std::cout << "q=" << joint[0] << " " << joint[1] << " " << joint[2] << " " << joint[3] << ' ' << joint[4] << " " << joint[5] << std::endl;
	joint[1] = joint[1] + pi / 2;
	joint[3] = joint[3] + pi / 2;
	if (joint[0] == 100)
		return false;
	else if (ur5sim.readCollision(joint)) return false;
	return true;
}
bool isStateValid2(const ob::State * state)
{
	n_repeated++;
	Eigen::Ref<const Eigen::VectorXd> val1(*state->as< ob::ConstrainedStateSpace::StateType>());
	//std::cout << val1 << std::endl;
	double joint[6] = { val1[0] ,val1[1] , val1[2] , val1[3] , val1[4] , val1[5] };
	joint[1] = joint[1] + pi / 2;
	joint[3] = joint[3] + pi / 2;
	//std::cout << "q=" << joint[0] << " " << joint[1] << " " << joint[2] << " " << joint[3] << ' ' << joint[4] << " " << joint[5] << std::endl;
	if (joint[1] == 100)
		return false;
	else if (ur5sim.readCollision(joint)) return false;
	n_node++;
	return true;
}
void PRRRT(std::string folderPath, std::vector<double>  q_intial, std::vector<double>  q_goal)//n第几个节点
{



	auto rvss = std::make_shared<ob::RealVectorStateSpace>(6);
	rvss->setBounds(-pi,pi);
	//auto constraint = std::make_shared<Constrain1>(6, 5, tol);



		auto constraint = std::make_shared<Constraint_ral>(6, 2, tol);
		auto css = std::make_shared<ob::ProjectedStateSpace>(rvss, constraint);
		auto csi = std::make_shared<ob::ConstrainedSpaceInformation>(css);
		csi->setStateValidityChecker(isStateValid2);
		auto ss = std::make_shared<og::SimpleSetup>(csi);
		ob::ScopedState<>start(css);
		ob::ScopedState<> goal(css);
		std::vector<double> v1 = { q_intial[0],q_intial[1],q_intial[2],q_intial[3],q_intial[4],q_intial[5]};

		std::vector<double> v2 = { q_goal[0],q_goal[1],q_goal[2],q_goal[3],q_goal[4],q_goal[5] };
		start = v1;

		goal = v2;

		ss->setStartAndGoalStates(start, goal, GoalDistance);

		auto planner(std::make_shared<og::RRT>(csi));

		planner->setIntermediateStates(0);

		planner->setRange(Range);
		planner->setGoalBias(GoalBias);

		ss->setPlanner(planner);

		ss->setup();

		begain = clock();
		ob::PlannerStatus solved = ss->solve(t);
		end = clock();


		enum ompl::base::PlannerStatus::StatusType s(solved);
		std::cout << s << std::endl;
		double endtime = (double)(end - begain) / CLOCKS_PER_SEC;
		if (s != 16)
		{
			if (s == 6)
			{
				// and inquire about the found path
				auto path = ss->getSolutionPath();
				std::cout << "Found solution:" << std::endl;

				// print the path to screen

				std::ofstream is;
				is.open(folderPath + "\\path.txt");
				path.print(is);
				is.close();
			}

			std::ofstream is1;
			is1.open(folderPath + "\\data.txt");
			ob::PlannerData data(csi);
			planner->getPlannerData(data);
			data.printGraphML(is1);
			is1.close();

			std::ofstream is2;
			is2.open(folderPath + "\\time.txt");
			is2 << endtime;
			is2.close();

			std::ofstream is3;
			is3.open(folderPath + "\\n_repeated.txt");
			is3 << n_repeated << " " << n_node;
			is3.close();
		}
		else std::cout << "No solution found" << std::endl;
	
}
std::vector< std::vector<double> > Cfunction(Eigen::Matrix4d S)
{
	double a = -1.548762192129329-S(1, 3) ;
	double b = S(2, 3);
	
	std::vector< std::vector<double> > C{ {0,1,2*a,0,0,0} ,{1,0,0,0,0,0},{0,0,0,1,0,0},{0,0,0,0,0,1},{0,0,0,0,1,0},{0,0,0,0,0,0} };
	return C;
}
bool TCRRT(std::string folderPath, std::vector< std::vector<double> > Constraint, std::vector<double>  q_intial , std::vector<double>  q_goal, int mode = 0)//n第几个节点
{
	begain1 = clock();
	auto space(std::make_shared<milt_myRealVectorStateSpace>(6, tol, Constraint, mode, Cfunction));
	space->setBounds(-pi, pi);

	auto si(std::make_shared<ob::SpaceInformation>(space));

	si->setStateValidityChecker(isStateValid);

	auto pdef(std::make_shared<ob::ProblemDefinition>(si));

	auto ss = std::make_shared<og::SimpleSetup>(si);

	ob::ScopedState<>start(space);
	ob::ScopedState<> goal(space);


	std::vector<double> v2= { q_goal[0],q_goal[1] ,q_goal[2] ,q_goal[3] ,q_goal[4] ,q_goal[5] };
	std::vector<double> v1 = { q_intial[0], q_intial[1], q_intial[2], q_intial[3], q_intial[4], q_intial[5] };
	start = v1;
	goal = v2;
	ss->setStartAndGoalStates(start, goal, GoalDistance);
	auto planner(std::make_shared<og::RRT>(si));

	planner->setIntermediateStates(1);

	planner->setRange(Range);
	planner->setGoalBias(GoalBias);

	ss->setPlanner(planner);

	ss->setup();
	end1 = clock();
	begain = clock();
	ob::PlannerStatus solved = ss->solve(t);
	end = clock();

	enum ompl::base::PlannerStatus::StatusType s(solved);
	std::cout << s << std::endl;
	double endtime = (double)(end - begain) / CLOCKS_PER_SEC;
	double endtime1 = (double)(end1 - begain1) / CLOCKS_PER_SEC;
	if (s != 16)
	{

		std::ofstream is1;
		is1.open(folderPath + "\\data.txt");
		ob::PlannerData data(si);
		planner->getPlannerData(data);
		data.printGraphML(is1);
		is1.close();

		std::ofstream is2;
		is2.open(folderPath + "\\time.txt");
		is2 << endtime<<" "<< endtime1;
		is2.close();

		std::ofstream is3;
		is3.open(folderPath + "\\n_repeated.txt");
		is3 << n_repeated;
		is3.close();
		if (s == 6)
		{
			// and inquire about the found path
			auto path = ss->getSolutionPath();
			std::cout << "Found solution:" << std::endl;

			// print the path to screen

			std::ofstream is;
			is.open(folderPath + "\\path.txt");
			path.print(is);
			is.close();
			return 1;
		}
		return 0;
	}
	else {
		std::cout << "No solution found" << std::endl;
		return 0;
	}
}
bool TCRRTLazy(std::string folderPath, std::vector< std::vector<double> > Constraint, std::vector<double>  q_intial, std::vector<double>  q_goal,int mode=0)//n第几个节点
{
	begain1 = clock();

	auto space(std::make_shared<milt_myRealVectorStateSpace>(6, tol, Constraint,mode, Cfunction));		

	space->setBounds(-pi, pi);

	auto si(std::make_shared<ob::SpaceInformation>(space));

	si->setStateValidityChecker(isStateValid);

	auto pdef(std::make_shared<ob::ProblemDefinition>(si));

	auto ss = std::make_shared<og::SimpleSetup>(si);

	ob::ScopedState<>start(space);
	ob::ScopedState<> goal(space);


	std::vector<double> v2 = { q_goal[0],q_goal[1] ,q_goal[2] ,q_goal[3] ,q_goal[4] ,q_goal[5] };
	std::vector<double> v1 = { q_intial[0], q_intial[1], q_intial[2], q_intial[3], q_intial[4], q_intial[5] };
	start = v1;
	goal = v2;
	ss->setStartAndGoalStates(start, goal, GoalDistance);
	auto planner(std::make_shared<og::LazyRRT>(si));

	planner->setRange(Range);
	planner->setGoalBias(GoalBias);

	ss->setPlanner(planner);

	ss->setup();
	end1 = clock();
	begain = clock();
	ob::PlannerStatus solved = ss->solve(t);
	end = clock();


	enum ompl::base::PlannerStatus::StatusType s(solved);
	std::cout << s << std::endl;
	double endtime = (double)(end - begain) / CLOCKS_PER_SEC;
	double endtime1 = (double)(end1 - begain1) / CLOCKS_PER_SEC;
	if (s != 16)
	{

		std::ofstream is1;
		is1.open(folderPath + "\\data.txt");
		ob::PlannerData data(si);
		planner->getPlannerData(data);
		data.printGraphML(is1);
		is1.close();

		std::ofstream is2;
		is2.open(folderPath + "\\time.txt");
		is2 << endtime << " " << endtime1;
		is2.close();

		std::ofstream is3;
		is3.open(folderPath + "\\n_repeated.txt");
		is3 << n_repeated;
		is3.close();
		if (s == 6)
		{
			// and inquire about the found path
			auto path = ss->getSolutionPath();
			std::cout << "Found solution:" << std::endl;

			// print the path to screen

			std::ofstream is;
			is.open(folderPath + "\\path.txt");
			path.print(is);
			is.close();
			return 1;
		}
		return 0;
	}
	else {
		std::cout << "No solution found" << std::endl;
		return 0;
	}
}
bool TCRRTConnect(std::string folderPath, std::vector< std::vector<double> > Constraint, std::vector<double>  q_intial, std::vector<double>  q_goal, int mode = 0)//n第几个节点
{
	begain1 = clock();
	auto space(std::make_shared<milt_myRealVectorStateSpace>(6, tol, Constraint, mode, Cfunction));
	space->setBounds(-pi, pi);

	auto si(std::make_shared<ob::SpaceInformation>(space));

	si->setStateValidityChecker(isStateValid);

	auto pdef(std::make_shared<ob::ProblemDefinition>(si));

	auto ss = std::make_shared<og::SimpleSetup>(si);

	ob::ScopedState<>start(space);
	ob::ScopedState<> goal(space);


	std::vector<double> v2 = { q_goal[0],q_goal[1] ,q_goal[2] ,q_goal[3] ,q_goal[4] ,q_goal[5] };
	std::vector<double> v1 = { q_intial[0], q_intial[1], q_intial[2], q_intial[3], q_intial[4], q_intial[5] };
	start = v1;
	goal = v2;
	ss->setStartAndGoalStates(start, goal, GoalDistance);
	auto planner(std::make_shared<og::RRTConnect>(si));

	planner->setRange(Range);
	ss->setPlanner(planner);

	ss->setup();
	end1 = clock();
	begain = clock();
	ob::PlannerStatus solved = ss->solve(t);
	end = clock();


	enum ompl::base::PlannerStatus::StatusType s(solved);
	std::cout << s << std::endl;
	double endtime = (double)(end - begain) / CLOCKS_PER_SEC;
	double endtime1 = (double)(end1 - begain1) / CLOCKS_PER_SEC;

	if (s != 16)
	{

		std::ofstream is1;
		is1.open(folderPath + "\\data.txt");
		ob::PlannerData data(si);
		planner->getPlannerData(data);
		data.printGraphML(is1);
		is1.close();

		std::ofstream is2;
		is2.open(folderPath + "\\time.txt");
		is2 << endtime << " " << endtime1;
		is2.close();

		std::ofstream is3;
		is3.open(folderPath + "\\n_repeated.txt");
		is3 << n_repeated;
		is3.close();
		if (s == 6)
		{
			// and inquire about the found path
			auto path = ss->getSolutionPath();
			std::cout << "Found solution:" << std::endl;

			// print the path to screen

			std::ofstream is;
			is.open(folderPath + "\\path.txt");
			path.print(is);
			is.close();
			return 1;
		}
		return 0;
	}
	else {
		std::cout << "No solution found" << std::endl;
		return 0;
	}
}
bool ChoseSampler(std::string folderPath, std::vector< std::vector<double> > Constraint, std::vector<double>  q_intial, std::vector<double>  q_goal , int sampler,int mode=0)
{
	bool a;
	switch (sampler)
	{
	case 0:
		a= TCRRT(folderPath, Constraint, q_intial,q_goal,mode);
		return a;
		break;
	case 1:
		a = TCRRT(folderPath, Constraint, q_intial, q_goal,mode);
		return a;
		break;
	case 2:
		 a = TCRRT(folderPath, Constraint, q_intial, q_goal,mode);
		return a;
		break;
	default:
		std::cout << "error" << std::endl;
		return 0;
		break;
	}
}
int main(int argc, char** argv)
{
	std::vector< std::vector<double> > C[8]{ { {1,0,0,0,0,0} ,{0,1,0,0,0,0},{0,0,1,0,0,0},{0,0,0,0,0,1},{0,0,0,0,0,0},{0,0,0,0,0,0} },
	{ {0,0,0,0,1,0} ,{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0} },
	{ {1,0,0,0,0,0} ,{0,1,0,0,0,  0},{0,0,0,0,0,1},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0} },
	{ {1,0,0,0,0,0} ,{0,0,0,1,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0} },
	{ {1,0,0,0,0,0} ,{0,1,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0} },
	{ {0,0,1,0,0,1} ,{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0} },
	{ {1,0,0,0,0,0} ,{0,1,0,0,0,0},{0,0,1,0,0,0},{0,0,0,0,0,1},{0,0,0,0,0,0},{0,0,0,0,0,0} },
	{ {0,0,0,0,0,0} ,{0,1,0,0,0,0},{0,0,1,0,0,0},{0,0,0,0,0,1},{0,0,0,0,0,0},{0,0,0,0,0,0} } };
	std::vector<double> q_intial[8] = { {  -2.5215, -0.9281 - pi / 2, -1.5875  ,  2.5156 - pi / 2,    1.8234, -0.00006 },
		{-0.7873 ,-0.1593 - pi / 2 ,-1.3505  ,  1.5098 - pi / 2   , 0.7873 ,-0.0000 },
		{ -0.5905, -0.5029 - pi / 2,-1.2241 ,   1.7282 - pi / 2 ,   0.4302, -0.0016},
		{ -1.4185 ,-0.8529 - pi / 2, -1.3850 ,   2.2379 - pi / 2 ,   1.4185,-0.0003 },
		{ -1.4775 ,-1.3782 - pi / 2, -0.6820 ,   2.0602 - pi / 2 ,  1.4774 ,-0.0005},
		{-1.3122 ,-0.6590 - pi / 2, -1.6560 ,   2.3138 - pi / 2  , 1.3240 ,-0.0182  },
		{ -1.39224, -2.00857 ,-1.45304 ,0.318846 ,1.59521 ,-0.0185217 } ,
		{-1.3969 ,- 1.0676 - pi / 2 ,- 1.5086 ,   2.5761 - pi / 2  ,  1.3969, - 0.0001 }
};
	std::vector<double>  q_goal[8] = { { -0.9338, -0.3972 - pi / 2 ,-1.6505,    2.0477 - pi / 2 ,   0.9341, -0.0002},
									 {-0.6887, -0.3576 - pi / 2 ,-1.6741 ,   2.0321 - pi / 2 ,  0.6886 ,   0.7851 },
									 { -0.9031 ,- 0.4396 - pi / 2,- 1.3178  ,  1.7596 - pi / 2,   0.0442, - 0.0022},
									 {-0.9625, -1.3500 - pi / 2, -1.2816, 3.5992 - pi / 2, 1.1946, -0.4900},
									 { -0.8814 ,- 0.9169 - pi / 2 ,- 1.8283  ,  2.7450 - pi / 2 ,  0.8823, - 0.0020},
									 {-1.39224, - 2.00857 ,- 1.45304 ,0.318846 ,1.59521 ,- 0.0185217},
									 {-2.2167 ,- 0.5679 - pi / 2 ,- 1.3633 ,   1.9317 - pi / 2  ,  2.1410 ,- 0.0181 },
									 { -0.7587, - 1.3926 - pi / 2 , - 0.7505 ,   2.1425 - pi / 2  ,   0.7589  ,  0.0002 } };
	double x[8] = {0, -0.3, 0,  0    ,  0 , 0   , 0 ,0};
	double y[8] = {0, 0   , 0,  0.315,  0 , 0   , 0 ,0};
	double z[8] = {0, 0   , 0,  0.205,  0 , 0.15, 0 ,0.43};
		for (int task = 8; task < 3; task++)
		{
			//system("start C:\\Users\\Master\\source\\repos\\Project5\\Project5\\仿真场景\\duanshu_PLAN.ttt");
			//Sleep(8000);
			Eigen::Matrix4d T;
			T << 1, 0, 0, x[task],
				0, 1, 0, y[task],
				0, 0, 1, z[task],
				0, 0, 0, 1;
			ur2.setT_tool(T);
			if (ur5sim.open("UR5_joint", "Collision"))
			{
				for (int sampler = 0; sampler < 3; sampler++)
				{
					for (int n = 0; n < 20; n++)
					{
						ur5sim.start();
						n_repeated = 0;
						std::string folderPath = "C:\\Users\\Master\\OneDrive - mail.ustc.edu.cn\\桌面\\高压电气\\DATA\\Task" + std::to_string(task + 1) + "\\sampler" + std::to_string(sampler + 1) + "\\test" + std::to_string(n + 1);
						if (!mkdir(folderPath.c_str()))
						{
							
							ChoseSampler(folderPath, C[task], q_intial[task], q_goal[task], sampler);
						}
						ur5sim.stop();
						Sleep(1000);
					}
				}
			}

		}	

		for (int task = 8; task < 8; task++)
		{
			//system("start C:\\Users\\Master\\source\\repos\\Project5\\Project5\\仿真场景\\duanshu_PLAN.ttt");
			//Sleep(8000);
			Eigen::Matrix4d T;
			T << 1, 0, 0, x[task],
				0, 1, 0, y[task],
				0, 0, 1, z[task],
				0, 0, 0, 1;
			ur2.setT_tool(T);
			if (ur5sim.open("UR5_joint", "Collision"))
			{
				for (int sampler = 0; sampler < 3; sampler++)
				{
					for (int n = 0; n < 20; n++)
					{
						ur5sim.start();
						n_repeated = 0;
						std::string folderPath = "C:\\Users\\Master\\OneDrive - mail.ustc.edu.cn\\桌面\\高压电气\\DATA\\Task" + std::to_string(task + 1) + "\\sampler" + std::to_string(sampler + 1) + "\\test" + std::to_string(n + 1);
						if (!mkdir(folderPath.c_str()))
						{

							ChoseSampler(folderPath, C[task], q_intial[task], q_goal[task], sampler,1);
						}
						ur5sim.stop();
						Sleep(1000);
					}
				}
			}

		}

		
		for (int task = 8; task < 9; task++)
		{
			Eigen::Matrix4d T;
			T << 1, 0, 0, x[task],
				0, 1, 0, y[task],
				0, 0, 1, z[task],
				0, 0, 0, 1;
			ur2.setT_tool(T);
			if (ur5sim.open("UR5_joint", "Collision"))
			{

					for (int n = 0; n < 20; n++)
					{
						ur5sim.start();
						n_repeated = 0;
						n_node = 0;;
						std::string folderPath = "C:\\Users\\Master\\OneDrive - mail.ustc.edu.cn\\桌面\\高压电气\\DATA\\Task" + std::to_string(task + 1) + "\\sampler1\\test" + std::to_string(n + 1);
						if (!mkdir(folderPath.c_str()))
						{
							PRRRT(folderPath,q_intial[0], q_goal[0]);
						}
					}
				
			}

		}
}
