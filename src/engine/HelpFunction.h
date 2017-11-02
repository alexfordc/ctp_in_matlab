#ifndef HELP_FUNCTION_H
#define HELP_FUNCTION_H

#include "engine.h"


typedef std::vector<mwSize> MATRIXDIMENSION;
// ����lua/c++��matlab�ж�ά�����ת��
typedef MATRIXDIMENSION MATRIXINDEX;//���������MATRIXINDEX��Ϊ2��3
typedef std::vector<MATRIXDIMENSION> MATRIXINDEXLIST;//��������ôMATRIXINDEXLIST��Ӧ��Ϊ00��01��02��10��11��12
typedef MATRIXINDEXLIST::const_iterator ConstIteratorOfIndexList;



void getIndexList(const MATRIXDIMENSION &dimensions, MATRIXINDEXLIST &indexList); // indexList�е�����ĵ������Կ���������˳��

double getDoubleFromMatlabNumeric(const mxArray* mx, mwIndex i);



#endif