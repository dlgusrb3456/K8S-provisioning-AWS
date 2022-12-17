# K8S-provisioning-AWS

배포 환경
  
  ubuntu 20.04
  
사전 조건
1.Terraform, Ansible 사전 설치

2.Terraform에서 AWS Provider를 사용하기 위한 AWS 자격증명 인증이 되어있어야 함

3.프로비저닝 되는 AWS Region의 보안그룹으로 terraform을 생성해줘야함

4.init 디렉토리 내부에서 wget https://raw.githubusercontent.com/projectcalico/calico/v3.24.1/manifests/calico.yaml 명령을 통해 calico.yaml 다운로드

5.terraform_test_rsa 이름으로 /root/.ssh 경로에 keypair 생성해줘야함

6.Ansible 설치 후 /etc/ansible/hosts 파일을 다음과 같이 설정해 줘야함 (기존의 내용 다 삭제)

[local]

local1 ansible_host=127.0.0.1

최종 배포 구성도

![image](https://user-images.githubusercontent.com/77333310/208241680-f0ab847f-6314-40da-8fe6-a44f8aeb0eac.png)
