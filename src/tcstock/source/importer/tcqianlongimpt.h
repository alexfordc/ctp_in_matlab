#ifndef tcqianlongimpt_h

#define tcqianlongimpt_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QtCore/QDir>

/*! \brief tcQianlongImporter
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.10

	��Ǯ�����ݵ���Ĺ����࣬�������� www.qianlong.com.cn ��
	Ŀǰ�����С�
*/
class tcQianlongImporter : public QObject
{
	Q_OBJECT

public:
	tcQianlongImporter();

	~tcQianlongImporter();

	bool ReadFile(const QDir &pPath);

};

#endif //tcqianlongimpt_h
