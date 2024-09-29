:: ��ȡ��ǰ�ļ�����
for %%I in ("%%cd%%") do set "folder_name=FourierTransform"

:: ʹ�õ�ǰ�ļ���������һ���µ� GitHub �ֿ�
gh repo create "FourierTransform" --public

:: ��ʼ��һ���µ� Git �ֿ�
git init

:: ��Զ�ֿ̲����Ϊ origin
git remote add origin https://github.com/Republic1024/FourierTransform.git

:: ��Զ�ֿ̲�� main ��֧��ȡ���´���
git pull origin main

:: �Ƴ�δ���ٵ��ļ������� .DS_Store��Mac ϵͳ���ɵ������ļ���
del /F /Q .DS_Store

:: �����и�����ӵ��ݴ������ų� .pth �ļ�
git add .

:: �ύ�ݴ����ĸ��Ĳ�����ύ��Ϣ
git commit -m "This is new changes"

:: �����ص� main ��֧�����Զ�� main ��֧�������ύ
git branch -M main

:: ������ main ��֧�ĸ������͵�Զ�� main ��֧
git push -u origin main