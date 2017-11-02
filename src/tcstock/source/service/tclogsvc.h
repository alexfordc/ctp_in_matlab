#ifndef tclogsvc_h

#define tclogsvc_h

#include <QtCore/QVariant>
#include <QtCore/QObject>
#include <QtCore/QFile>

/*! \brief tcLogService
 	\author tony (tonixinot@gmail.com)
 	\version 0.01
 	\date 2006.12.02
 	
	ϵͳLOG��¼�����ࡣĿǰֻ�Ǽ򵥵�ֱ�ӽ���Ϣ�������ǰĿ¼�µ�sys.log�ļ��ϡ�
*/
class tcLogService : public QObject
{
	Q_OBJECT

public:
	static bool Initialize(int argc, char* argv[]);

	static bool Finalize();

	static void CreateLog(QObject *pObject, const QString &pLogText);

protected:
	tcLogService(int argc, char* argv[]);

	~tcLogService();

	void _CreateLog(QObject *pObject, const QString &pLogText);

private:
	static tcLogService *mThis;

	QFile mFile;

};

#endif //tclogsvc_h
