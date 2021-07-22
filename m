Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C329B3D2B3D
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhGVQyO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 12:54:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3452 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhGVQyJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 12:54:09 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GVzj54Txfz6D8XB;
        Fri, 23 Jul 2021 01:19:53 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 22 Jul 2021 19:34:42 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <pvorel@suse.cz>, <vt@altlinux.org>,
        <linux-integrity@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH ima-evm-utils 1/7] Download UML kernel and signing key
Date:   Thu, 22 Jul 2021 19:34:08 +0200
Message-ID: <20210722173414.1738041-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722173414.1738041-1-roberto.sassu@huawei.com>
References: <20210722173414.1738041-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Testing kernel functionality is more difficult than testing user space
software, as it requires support from the testing platform to create a
more specific environment (e.g. a virtual machine). User space software
instead could be simply run in a container.

Fortunately, a kernel architecture named UML (User Mode Linux) allows the
kernel to be executed as a user space process, which would be suitable also
for testing platforms such as Github Actions and Travis.

This patch simply downloads (errors are ignored) the UML kernel binary and
its signing key as artifacts from a URL in the format:

$LINUX_URL/<ima-evm-utils branch>-test/<asset>

The LINUX_URL environment variable must be set in the configuration of the
testing platform (for Github Actions, the variable must be created in an
environment named 'test').

LINUX_URL could be for example:

https://github.com/robertosassu/linux/releases/download/

If Github Releases is used, a workflow should build the kernel, tagged as
'<ima-evm-utils>-test', and publish the artifacts.

The UML kernel binary should be named 'linux-<container name>[.<arch>]' and
the signing key 'signing_key.pem-<container name>', where the '.<arch>'
suffix appears only if the current arch is not x86_64 and separator
characters in the container name are replaced with '.'.

Finally, the patch also adds curl and ca-certificates as software
dependencies when necesssary.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .github/workflows/ci.yml | 16 ++++++++++++++++
 .travis.yml              | 12 ++++++++++++
 ci/alpine.sh             |  3 ++-
 ci/alt.sh                |  1 +
 ci/debian.sh             |  2 ++
 ci/fedora.sh             |  3 ++-
 ci/tumbleweed.sh         |  3 ++-
 7 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 088c04188682..51f7dbe0aaa6 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -101,6 +101,9 @@ jobs:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
 
+    environment:
+      name: test
+
     steps:
     - name: Show OS
       run: cat /etc/os-release
@@ -125,6 +128,19 @@ jobs:
             fi
         fi
 
+    - name: Download UML kernel and signing key
+      run: |
+        asset_name_suffix=${{ matrix.container }}
+        asset_name_suffix="$(echo $asset_name_suffix | sed 's/[:\/]/./')"
+        if [ -n "$ARCH" ]; then
+          asset_name_suffix="$asset_name_suffix.$ARCH"
+        fi
+        curl -L ${{ secrets.LINUX_URL }}/${GITHUB_REF##*/}-test/linux-$asset_name_suffix -s -f --output linux || echo
+        curl -L ${{ secrets.LINUX_URL }}/${GITHUB_REF##*/}-test/signing_key.pem-$asset_name_suffix -s -f --output signing_key.pem || echo
+        if [ -f linux ]; then
+                chmod +x linux
+        fi
+
     - name: Compiler version
       run: $CC --version
 
diff --git a/.travis.yml b/.travis.yml
index 7a7627323724..23c220e857b6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -87,11 +87,23 @@ before_install:
             sudo curl -L https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64 -o /usr/bin/runc
             sudo chmod +x /usr/bin/runc
         fi
+    - asset_name_suffix=$DISTRO
+    - asset_name_suffix="$(echo $asset_name_suffix | sed 's/[:\/]/./')"
+    - >
+        if [ -n "$ARCH" ]; then
+          asset_name_suffix="$asset_name_suffix.$ARCH"
+        fi
     - $CONTAINER info
 
     - DIR="/usr/src/ima-evm-utils"
     - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n" > Dockerfile
     - cat Dockerfile
+    - curl -L $LINUX_URL/$TRAVIS_BRANCH-test/linux-$asset_name_suffix -s -f --output linux || echo
+    - curl -L $LINUX_URL/$TRAVIS_BRANCH-test/signing_key.pem-$asset_name_suffix -s -f --output signing_key.pem || echo
+    - >
+        if [ -f "linux" ]; then
+                chmod +x linux
+        fi
     - $CONTAINER build $CONTAINER_ARGS -t ima-evm-utils .
 
 script:
diff --git a/ci/alpine.sh b/ci/alpine.sh
index 63d79546c0dd..588f450bdb5f 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -42,7 +42,8 @@ apk add \
 	sudo \
 	wget \
 	which \
-	xxd
+	xxd \
+	curl
 
 if [ ! "$TSS" ]; then
 	apk add git
diff --git a/ci/alt.sh b/ci/alt.sh
index 884c9951ca98..6b2aa08bd228 100755
--- a/ci/alt.sh
+++ b/ci/alt.sh
@@ -21,4 +21,5 @@ apt-get install -y \
 		wget \
 		xsltproc \
 		xxd \
+		curl \
 	&& control openssl-gost enabled
diff --git a/ci/debian.sh b/ci/debian.sh
index ad7d2c026735..07ef28c3a2f0 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -49,6 +49,8 @@ $apt \
 	sudo \
 	wget \
 	xsltproc \
+	curl \
+	ca-certificates
 
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl1.1$ARCH || true
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 2d80915ecd77..f07c678130ae 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -38,7 +38,8 @@ yum -y install \
 	sudo \
 	vim-common \
 	wget \
-	which
+	which \
+	curl
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index dfc478bed5dd..b6a42df7bfca 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -40,7 +40,8 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	vim \
 	wget \
 	which \
-	xsltproc
+	xsltproc \
+	curl
 
 if [ -f /usr/lib/ibmtss/tpm_server -a ! -e /usr/local/bin/tpm_server ]; then
 	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
-- 
2.25.1

