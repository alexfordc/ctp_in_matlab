#include "GVAR.h"

//ǰ�û���ַ
QString FRONT_ADDRESS("");

//�����״̬
const QString OFFLINE(QStringLiteral("����"));
const QString CONNECTING(QStringLiteral("��������..."));
const QString ONLINE(QStringLiteral("����"));
const QString SUBSCRIBING(QStringLiteral("���ڽ�������..."));
const QString DISCONNECTING(QStringLiteral("���ڶϿ�����..."));

//�������������ļ�*.dat��ǰ׺��ַ
const QString DAT_PREDIR("data/");

//ȫ����Լ���б�(��Լ����)
std::map<QString, wdTick> instruList;

//���ڶ��ĵĺ�Լ����(��Լ����)
std::set<QString> instruSet;

//������
QString tradeDate;

//���ݿ�����
QString DB_DRIVER_NAME;
QString DB_HOST_NAME;
QString DATABASE_NAME;
QString USER_NAME;
QString PASSWORD;

//һ�����ĵĺ�Լ��
std::vector<QString> onekeyInstru;