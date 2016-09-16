#### 処理内容
1. firewalld無効化
2. ホスト名設定
3. /etc/hosts設定
4. /etc/resolv.conf設定

#### 使い方
1. host_varsにてターゲットノードのホスト名を設定する。  
  `vi Ansible/host_vars/[ターゲットノード].yml`

2. group_varsにて/etc/hostsのエントリと、/etc/resolv.confのエントリを設定する。  
  `vi Ansible/group_vars/openstack_network.yml`
  
3. インベントリに対象ホストを記載する。  
  `vi Ansible/hosts`

4. ansible-playbookを実行する。  
  `ansible-playbook -i hosts playbooks/openstack_network.yml`

#### 変数

|変数名|説明|初期値|
|------|----|------|
| hosts_entries | /etc/hostsに記載するホスト名のエントリ | [[public-dns, 8.8.8.8]] |
| dns_servers  | /etc/resolv.confに記載するDNSサーバのエントリ | [8.8.8.8, 8.8.4.4] |
| hostname | サーバのホスト名 | localhost |

#### 検証済みOS
- CentOS
  * 7

#### 依存ロール/YAML
なし
