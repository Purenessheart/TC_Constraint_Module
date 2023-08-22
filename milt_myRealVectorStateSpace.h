#include <ompl/base/spaces/RealVectorStateSpace.h>
#include "‘À∂Ø—ß.h"

namespace ob = ompl::base;
//namespace og = ompl::geometric;


class milt_myRealVectorStateSpace :public ob::RealVectorStateSpace
{
public:
	milt_myRealVectorStateSpace(unsigned int dim, double tol, std::vector< std::vector<double> > C,int mode=0, std::vector< std::vector<double> >(*func)(Eigen::Matrix4d)=nullptr);
	~milt_myRealVectorStateSpace() {};
	virtual void interpolate(const ob::State *from, const  ob::State *to, double t, ob::State *state) const override;
	virtual double distance(const ob::State *state1, const ob::State *state2) const override;
	void setCfun(std::vector< std::vector<double> >(*func)(Eigen::Matrix4d));
private:
	std::size_t stateBytes_;
	double tolrence;
	std::vector< std::vector<double> > Constraint;
	std::vector< std::vector<double> > (*Cfun)(Eigen::Matrix4d S);
	int mode;
};
