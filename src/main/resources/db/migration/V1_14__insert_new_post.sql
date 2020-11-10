insert into POST (ID, TITLE, URL, LAST_MODIFIED, SUMMARY, DESCRIPTION, DESCRIPTION_HTML)
values (
           13,
           'Instalando Kubernetes com Vagrant e VirtualBox no Ubuntu',
           'instalando-kKubernetes-com-vagrant-e-virtual-box-no-ubuntu',
           current_date,
           'Kubernetes é um sistema de orquestração de contêineres open-source que automatiza a implantação, o dimensionamento e a gestão de aplicações em contêineres. Ele foi originalmente projetado pelo Google e agora é mantido pela Cloud Native Computing Foundation.',
           'Antes de iniciarmos as configurações dessas ferramentas vamos a uma breve introdução sobre elas.

=== Kubernetes
====
Kubernetes é um sistema de orquestração de contêineres open-source que automatiza a implantação, o dimensionamento e a gestão de aplicações em contêineres. Ele foi originalmente projetado pelo Google e agora é mantido pela Cloud Native Computing Foundation
====

=== Vagrant
====
Vagrant é um software de código aberto para criar e manter ambientes de desenvolvimento virtuais portáteis, utilizando VirtualBox, KVM, Hyper-V, Docker containers, VMware, e AWS. Ele tenta simplificar a gerência de configuração de software das virtualizações para aumentar a produtividade do desenvolvimento.
====

=== VirtualBox
====
VirtualBox é um software de virtualização desenvolvido pela empresa Innotek depois comprado pela Sun Microsystems que posteriormente foi comprada pela Oracle que, como o VMware Workstation, visa criar ambientes para instalação de sistemas distintos. Ele permite a instalação e utilização de um sistema operacional dentro de outro, assim como seus respectivos softwares, como dois ou mais computadores independentes, mas compartilhando fisicamente o mesmo hardware
====

---

Depois do uma breve introdução, agora vamos colocar a mão na massa.

=== Primeira etapa - Instalação do VirtualBox.

O primeiro passo é atualizarmos a lista das versões de pacotes disponíveis.
```shell
sudo apt update
```

Segue o comando de instalação do VirtualBox.
```shell
sudo apt install virtualbox
```

=== Segunda etapa - Instalação do Vagrant.
```shell
sudo apt install vagrant
```

=== Terceira etapa - Configuração do Vagrantfile

Com tudo instalado, agora vamos criar uma nova pasta no diretório raiz do usuário.
```shell
cd ~
mkdir vagrant_kubernetes
cd vagrant_kubernetes
```

Agora podemos criar um arquivo chamado Vagrantfile, é nesse arquivo que vamos adicionar nosso script Vagrant.
```shell
touch Vagrantfile
```

Vamos acessar o arquivo em modo de edição.
```shell
vim Vagrantfile
```

Copie todo conteúdo abaixo e grave no arquivo acessado no passo anterior. O script contem varias comentários, nesses comentários eu explico a responsabilidade de cada parte do script.
```shell
# array das máquinas a serem provisionadas, a primeira maquina sendo a master do Kubernetes e as demais sendo os nodes.
servers = [
    {
        :name => "k8s-head",
        :type => "master",
        :box => "ubuntu/xenial64",
        :box_version => "20180831.0.0",
        :eth1 => "192.168.2.111",
        :mem => "2048",
        :cpu => "1"
    },
    {
        :name => "k8s-node-1",
        :type => "node",
        :box => "ubuntu/xenial64",
        :box_version => "20180831.0.0",
        :eth1 => "192.168.2.112",
        :mem => "6144",
        :cpu => "2"
    },
    {
        :name => "k8s-node-2",
        :type => "node",
        :box => "ubuntu/xenial64",
        :box_version => "20180831.0.0",
        :eth1 => "192.168.2.113",
        :mem => "6144",
        :cpu => "2"
    }
]

# script que será em executado em todas as maquinas, tanto na maquina master como nas nodes, esse script é responsável por instalar o docker e kubernetes
$configureBox = <<-SCRIPT
    # instala o docker v17.03
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
    apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk ''{print $3}'')
    usermod -aG docker vagrant
    # instala o kubernetes v1.13.3
    apt-get install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
    deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
    apt-get update
    apt-get install -y kubelet=1.13.3-00 kubeadm=1.13.3-00 kubectl=1.13.3-00 kubernetes-cni=0.6.0-00
    apt-mark hold kubelet kubeadm kubectl kubernetes-cni
    # configurações iniciais do kubernetes
    swapoff -a
    sudo sed -i ''/ swap / s/^\(.*\)$/#\1/g'' /etc/fstab
    IP_ADDR=`ifconfig enp0s8 | grep Mask | awk ''{print $2}''| cut -f2 -d:`
    sudo sed -i "/^[^#]*KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" /etc/default/kubelet
    sudo systemctl restart kubelet
SCRIPT

# script responsável por configurar a máquina master do kubernetes
$configureMaster = <<-SCRIPT
    IP_ADDR=`ifconfig enp0s8 | grep Mask | awk ''{print $2}''| cut -f2 -d:`
    HOST_NAME=$(hostname -s)
    kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=192.168.0.0/16
    sudo --user=vagrant mkdir -p /home/vagrant/.kube
    cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
    chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config
    export KUBECONFIG=/etc/kubernetes/admin.conf
    kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
    kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml
    kubeadm token create --print-join-command >> /etc/kubeadm_join_cmd.sh
    chmod +x /etc/kubeadm_join_cmd.sh
    sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
    sudo service sshd restart
SCRIPT

# script responsável por configurar as máquinas nodes do Kubernetes
$configureNode = <<-SCRIPT
    apt-get install -y sshpass
    sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.2.111:/etc/kubeadm_join_cmd.sh .
    sh ./kubeadm_join_cmd.sh
    # https://github.com/projectcalico/calicoctl/issues/426
    sudo iptables -t nat -N EXTERNAL
    sudo iptables -t nat -A POSTROUTING -j EXTERNAL
    sudo iptables -t nat -A EXTERNAL -s 172.17.0.1/16 -d 172.17.0.1/16 -j RETURN
    sudo iptables -t nat -A EXTERNAL -s 172.17.0.1/16 -d 192.168.1.1/24 -j RETURN
    sudo iptables -t nat -A EXTERNAL -j MASQUERADE
SCRIPT

# script responsável por provisionar as máquinas virtuais
Vagrant.configure("2") do |config|
    # percorre o array das máquinas virtuais
    servers.each do |opts|
        # configura cada máquina com o SO ubuntu, também configura toda a rede, os recursos a serem alocados e por fim executa os scripts criados acima.
        config.vm.define opts[:name] do |config|

            config.vm.box = opts[:box]
            config.vm.box_version = opts[:box_version]
            config.vm.hostname = opts[:name]
            config.vm.network "public_network", ip: opts[:eth1], netmask: "255.255.254.0"

            config.vm.provider "virtualbox" do |v|

                v.name = opts[:name]
            	v.customize ["modifyvm", :id, "--groups", "/Development"]
                v.customize ["modifyvm", :id, "--memory", opts[:mem]]
                v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]

            end

            config.vm.provision "shell", inline: $configureBox

            if opts[:type] == "master"
                config.vm.provision "shell", inline: $configureMaster
            else
                config.vm.provision "shell", inline: $configureNode
            end

        end

    end

end
```

=== Quarta etapa - Provisionando as máquinas e instalando o Kubernetes

Com todo o script configurado, agora podemos executar o comando Vagrant responsável por provisionar as maquinas e realizar todas as configurações.
```shell
vagrant up
```

Caso você tenha mais de uma placa de rede configurada no seu computador, será exibida uma lista com todas as redes para vincular as maquinas virtuais, você deve escolher a rede _eth0_.

Depois de alguns minutos, tudo será configurado pelo Vagrant, agora podemos acessar a maquina master por ssh.
```shell
vagrant ssh k8s-head
```

Por fim, vamos executar dois comandos do Kubernetes apenas para verificar que a instalação foi efetuada com sucesso.

O seguinte comando exibe as maquinas do nosso cluster.
```shell
kubectl get nodes
```

O retorno deve ser algo similar ao log abaixo.
```log
NAME        STATUS     ROLES      AGE    VERSION
k8s-head    Ready      master     1d     v1.13.3
k8s-node-1  Ready      <none>     1d     v1.13.3
k8s-node-1  Ready      <none>     1d     v1.13.3
```

O comando a seguir exibe todos os pods que estão rodando em nosso cluster.
```shell
kubectl get pods --all-namespace
```

', '<div class="paragraph">
<p>Antes de iniciarmos as configurações dessas ferramentas vamos a uma breve introdução sobre elas.</p>
</div>
<div class="sect2">
<h3 id="_kubernetes">Kubernetes</h3>
<div class="exampleblock">
<div class="content">
<div class="paragraph">
<p>Kubernetes é um sistema de orquestração de contêineres open-source que automatiza a implantação, o dimensionamento e a gestão de aplicações em contêineres. Ele foi originalmente projetado pelo Google e agora é mantido pela Cloud Native Computing Foundation</p>
</div>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_vagrant">Vagrant</h3>
<div class="exampleblock">
<div class="content">
<div class="paragraph">
<p>Vagrant é um software de código aberto para criar e manter ambientes de desenvolvimento virtuais portáteis, utilizando VirtualBox, KVM, Hyper-V, Docker containers, VMware, e AWS. Ele tenta simplificar a gerência de configuração de software das virtualizações para aumentar a produtividade do desenvolvimento.</p>
</div>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_virtualbox">VirtualBox</h3>
<div class="exampleblock">
<div class="content">
<div class="paragraph">
<p>VirtualBox é um software de virtualização desenvolvido pela empresa Innotek depois comprado pela Sun Microsystems que posteriormente foi comprada pela Oracle que, como o VMware Workstation, visa criar ambientes para instalação de sistemas distintos. Ele permite a instalação e utilização de um sistema operacional dentro de outro, assim como seus respectivos softwares, como dois ou mais computadores independentes, mas compartilhando fisicamente o mesmo hardware</p>
</div>
</div>
</div>
<hr>
<div class="paragraph">
<p>Depois do uma breve introdução, agora vamos colocar a mão na massa.</p>
</div>
</div>
<div class="sect2">
<h3 id="_primeira_etapa_instalação_do_virtualbox">Primeira etapa - Instalação do VirtualBox.</h3>
<div class="paragraph">
<p>O primeiro passo é atualizarmos a lista das versões de pacotes disponíveis.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt update</code></pre>
</div>
</div>
<div class="paragraph">
<p>Segue o comando de instalação do VirtualBox.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt install virtualbox</code></pre>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_segunda_etapa_instalação_do_vagrant">Segunda etapa - Instalação do Vagrant.</h3>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">sudo apt install vagrant</code></pre>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_terceira_etapa_configuração_do_vagrantfile">Terceira etapa - Configuração do Vagrantfile</h3>
<div class="paragraph">
<p>Com tudo instalado, agora vamos criar uma nova pasta no diretório raiz do usuário.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">cd ~
mkdir vagrant_kubernetes
cd vagrant_kubernetes</code></pre>
</div>
</div>
<div class="paragraph">
<p>Agora podemos criar um arquivo chamado Vagrantfile, é nesse arquivo que vamos adicionar nosso script Vagrant.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">touch Vagrantfile</code></pre>
</div>
</div>
<div class="paragraph">
<p>Vamos acessar o arquivo em modo de edição.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">vim Vagrantfile</code></pre>
</div>
</div>
<div class="paragraph">
<p>Copie todo conteúdo abaixo e grave no arquivo acessado no passo anterior. O script contem varias comentários, nesses comentários eu explico a responsabilidade de cada parte do script.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell"># array das máquinas a serem provisionadas, a primeira maquina sendo a master do Kubernetes e as demais sendo os nodes.
servers = [
    {
        :name =&gt; "k8s-head",
        :type =&gt; "master",
        :box =&gt; "ubuntu/xenial64",
        :box_version =&gt; "20180831.0.0",
        :eth1 =&gt; "192.168.2.111",
        :mem =&gt; "2048",
        :cpu =&gt; "1"
    },
    {
        :name =&gt; "k8s-node-1",
        :type =&gt; "node",
        :box =&gt; "ubuntu/xenial64",
        :box_version =&gt; "20180831.0.0",
        :eth1 =&gt; "192.168.2.112",
        :mem =&gt; "6144",
        :cpu =&gt; "2"
    },
    {
        :name =&gt; "k8s-node-2",
        :type =&gt; "node",
        :box =&gt; "ubuntu/xenial64",
        :box_version =&gt; "20180831.0.0",
        :eth1 =&gt; "192.168.2.113",
        :mem =&gt; "6144",
        :cpu =&gt; "2"
    }
]

# script que será em executado em todas as maquinas, tanto na maquina master como nas nodes, esse script é responsável por instalar o docker e kubernetes
$configureBox = &lt;&lt;-SCRIPT
    # instala o docker v17.03
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
    apt-get update &amp;&amp; apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk ''{print $3}'')
    usermod -aG docker vagrant
    # instala o kubernetes v1.13.3
    apt-get install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    cat &lt;&lt;EOF &gt;/etc/apt/sources.list.d/kubernetes.list
    deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
    apt-get update
    apt-get install -y kubelet=1.13.3-00 kubeadm=1.13.3-00 kubectl=1.13.3-00 kubernetes-cni=0.6.0-00
    apt-mark hold kubelet kubeadm kubectl kubernetes-cni
    # configurações iniciais do kubernetes
    swapoff -a
    sudo sed -i ''/ swap / s/^\(.*\)$/#\1/g'' /etc/fstab
    IP_ADDR=`ifconfig enp0s8 | grep Mask | awk ''{print $2}''| cut -f2 -d:`
    sudo sed -i "/^[^#]*KUBELET_EXTRA_ARGS=/c\KUBELET_EXTRA_ARGS=--node-ip=$IP_ADDR" /etc/default/kubelet
    sudo systemctl restart kubelet
SCRIPT

# script responsável por configurar a máquina master do kubernetes
$configureMaster = &lt;&lt;-SCRIPT
    IP_ADDR=`ifconfig enp0s8 | grep Mask | awk ''{print $2}''| cut -f2 -d:`
    HOST_NAME=$(hostname -s)
    kubeadm init --apiserver-advertise-address=$IP_ADDR --apiserver-cert-extra-sans=$IP_ADDR  --node-name $HOST_NAME --pod-network-cidr=192.168.0.0/16
    sudo --user=vagrant mkdir -p /home/vagrant/.kube
    cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
    chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config
    export KUBECONFIG=/etc/kubernetes/admin.conf
    kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
    kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml
    kubeadm token create --print-join-command &gt;&gt; /etc/kubeadm_join_cmd.sh
    chmod +x /etc/kubeadm_join_cmd.sh
    sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
    sudo service sshd restart
SCRIPT

# script responsável por configurar as máquinas nodes do Kubernetes
$configureNode = &lt;&lt;-SCRIPT
    apt-get install -y sshpass
    sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@192.168.2.111:/etc/kubeadm_join_cmd.sh .
    sh ./kubeadm_join_cmd.sh
    # https://github.com/projectcalico/calicoctl/issues/426
    sudo iptables -t nat -N EXTERNAL
    sudo iptables -t nat -A POSTROUTING -j EXTERNAL
    sudo iptables -t nat -A EXTERNAL -s 172.17.0.1/16 -d 172.17.0.1/16 -j RETURN
    sudo iptables -t nat -A EXTERNAL -s 172.17.0.1/16 -d 192.168.1.1/24 -j RETURN
    sudo iptables -t nat -A EXTERNAL -j MASQUERADE
SCRIPT

# script responsável por provisionar as máquinas virtuais
Vagrant.configure("2") do |config|
    # percorre o array das máquinas virtuais
    servers.each do |opts|
        # configura cada máquina com o SO ubuntu, também configura toda a rede, os recursos a serem alocados e por fim executa os scripts criados acima.
        config.vm.define opts[:name] do |config|

            config.vm.box = opts[:box]
            config.vm.box_version = opts[:box_version]
            config.vm.hostname = opts[:name]
            config.vm.network "public_network", ip: opts[:eth1], netmask: "255.255.254.0"

            config.vm.provider "virtualbox" do |v|

                v.name = opts[:name]
            	v.customize ["modifyvm", :id, "--groups", "/Development"]
                v.customize ["modifyvm", :id, "--memory", opts[:mem]]
                v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]

            end

            config.vm.provision "shell", inline: $configureBox

            if opts[:type] == "master"
                config.vm.provision "shell", inline: $configureMaster
            else
                config.vm.provision "shell", inline: $configureNode
            end

        end

    end

end</code></pre>
</div>
</div>
</div>
<div class="sect2">
<h3 id="_quarta_etapa_provisionando_as_máquinas_e_instalando_o_kubernetes">Quarta etapa - Provisionando as máquinas e instalando o Kubernetes</h3>
<div class="paragraph">
<p>Com todo o script configurado, agora podemos executar o comando Vagrant responsável por provisionar as maquinas e realizar todas as configurações.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">vagrant up</code></pre>
</div>
</div>
<div class="paragraph">
<p>Caso você tenha mais de uma placa de rede configurada no seu computador, será exibida uma lista com todas as redes para vincular as maquinas virtuais, você deve escolher a rede <em>eth0</em>.</p>
</div>
<div class="paragraph">
<p>Depois de alguns minutos, tudo será configurado pelo Vagrant, agora podemos acessar a maquina master por ssh.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">vagrant ssh k8s-head</code></pre>
</div>
</div>
<div class="paragraph">
<p>Por fim, vamos executar dois comandos do Kubernetes apenas para verificar que a instalação foi efetuada com sucesso.</p>
</div>
<div class="paragraph">
<p>O seguinte comando exibe as maquinas do nosso cluster.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">kubectl get nodes</code></pre>
</div>
</div>
<div class="paragraph">
<p>O retorno deve ser algo similar ao log abaixo.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-log" data-lang="log">NAME        STATUS     ROLES      AGE    VERSION
k8s-head    Ready      master     1d     v1.13.3
k8s-node-1  Ready      &lt;none&gt;     1d     v1.13.3
k8s-node-1  Ready      &lt;none&gt;     1d     v1.13.3</code></pre>
</div>
</div>
<div class="paragraph">
<p>O comando a seguir exibe todos os pods que estão rodando em nosso cluster.</p>
</div>
<div class="listingblock">
<div class="content">
<pre class="highlight"><code class="language-shell" data-lang="shell">kubectl get pods --all-namespace</code></pre>
</div>
</div>
</div>');

insert into POST_AUTHOR (ID_POST, ID_AUTHOR) values ( 13, 1 );
insert into POST_TAG (ID_POST, ID_TAG) VALUES ( 13, 2);
