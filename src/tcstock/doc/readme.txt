������α��� (compile)
=====================
	����ǰ����ȷ�����ϵͳ�а�װ�� Qt4.2 �����ϵİ汾��Ŀǰ�ĳ����� Qt4.2.1 �汾�Ͽ���˳���������У����ǲ���֤�����汾�ϵ���ȷ�ԡ�
Windows ƽ̨:
	ʹ�� VC6 �� build_win_vc6 Ŀ¼�µ� TCStock.dsw �ļ����ɿ�ʼ���롣
	���ʹ�õ���VS2003��VS2005���뵼�� TCStock.dsw �ļ����ٽ��б��룬��������Ҫ�ֹ�����һ�£���
	ʹ���������������뽫 source Ŀ¼�µ������ļ����빤�̺���б��룬���Ҳ�Ҫ�������� moc ��
Linux ƽ̨:
	�򿪿���̨��ִ������ָ����� Qt �Ĺ����ļ���
		cd build_linux
		qmake -project ../source tcstock.pro
	Ȼ�����ı��༭���� tcstock.pro �ļ����ڡ�TARGET = tcstock�������һ�У�����Ϊ��
		QT += xml network
	���������Ҫʹ�� Qt �� xml �� network ģ�顣
	����ִ������ָ�
		qmake
	��������� build_linux Ŀ¼������ Makefile �ļ������ı��༭���򿪸� Makefile �ļ��������ҵ� ��####### Compile���д��������ǡ�####### Compile, tools and options�����������·������µ����ݣ�
		moc_%.cpp: %.h
			moc $(DEFINES) $(INCPATH) $< -o $@
	��������� make �����м��� moc ��ص�ָ�
	ʹ�� make ���ʼ��������������ɹ��������ڸ�Ŀ¼�¿�����Ϊ tcstock �Ŀ�ִ���ļ������临�Ƶ� bin Ŀ¼�󣬼��ɿ�ʼ���С�






tony (tonixinot@gmail.com)
2007.03.20
