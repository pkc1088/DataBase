
DROP PROCEDURE IF EXISTS ifProc; -- ������ �������� �ִٸ� ����
DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
  DECLARE var1 INT;  -- var1 ��������
  SET var1 = 100;  -- ������ �� ����

  IF var1 = 100 THEN  -- ���� @var1�� 100�̶��,
	SELECT '100�Դϴ�.';
  ELSE
    SELECT '100�� �ƴմϴ�.';
  END IF;
END $$
DELIMITER ;
CALL ifProc();

