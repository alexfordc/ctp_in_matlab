#ifndef tcdataimpt_h

#define tcdataimpt_h

#include <QtCore/QVariant>
#include <QtCore/QObject>

#include "tcimptsource.h"

/*! \brief tcDataImporter
 	\author tony (tonixinot@gmail.com)
 	\version 0.02
 	\date 2007.03.18
 	
	��Ʊ���ݵ����ܹ����ࡣ
*/
class tcDataImporter : public QObject
{
	Q_OBJECT

public:
	tcDataImporter();

	~tcDataImporter();

	void ShowSetupDialog(QWidget *pParent);

	bool Import(QWidget *pParent);

	tcImportSource* CreateImportSource(int pIndex);

	int GetActiveSourceIndex();

	void SetActiveSourceIndex(const int pIndex);

protected:

};

#endif  //tcdataimpt_h
