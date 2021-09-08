Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC3403FCB
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350387AbhIHTY7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230049AbhIHTY4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J46uw167783
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GcA+zQDxlX7avqYIqsTP5eJUexj4p/wbnv3/eWdW0wY=;
 b=DUH5T2CWg1DZnfG2saLw+o1FIJsoCCIWaqjfH4H3kM4xLrmmpbxGFpP7a/0cHotF17TP
 JzkwXECX26WHLYeC/VQjq8/KxzBrk7r3aB64MegzxhB0Jyb8mWZXowtr12l5AUr/Iw01
 rJEDoP1n8Noz9hUWpJFgMyDqgwvNozWXhdF2uwfvck6582telkv/ciHHlx8YJI1n1gqJ
 cyvOHEz9uTkF51RcrSqu3VKmtW79oueMXNQ5cMAQZomlVxTJk+cQwWrJhexs5whuNtic
 pNGxVDt1FHgtLjWHaXH97kydEhMCi3pr6nTkEocSY4gZiWL+34p1dTYCkrbJBpHIdVaI WA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axy0af95b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JI53n003527
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:47 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3axcnja3st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:47 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNkSN52625678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 084E511206B;
        Wed,  8 Sep 2021 19:23:46 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E56C3112070;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 9/9] tests: Get the packages for pkcs11 testing on the CI/CD system
Date:   Wed,  8 Sep 2021 15:23:43 -0400
Message-Id: <20210908192343.4147739-10-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eMGwHdyj2_BPKp1ipqntmFk8XaMcymp9
X-Proofpoint-ORIG-GUID: eMGwHdyj2_BPKp1ipqntmFk8XaMcymp9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Get the packages for pkcs11 testing on the CI/CD system.

This is the status on various distros:

- Alpine: could not find package with pkcs11 engine
- Alt Linux: works
- Debian: works
- CentOS7: softhsm 2.1.0 is too old for tests to work; tests also fail
           when trying to sign with pkcs11 URI using openssl command line tool
- CentOS: works
- Fedora: works
- OpenSuSE Leap: package not available in main repo
- OpenSuSE Tumbleweed: works

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 ci/alt.sh        | 3 +++
 ci/debian.sh     | 3 ++-
 ci/fedora.sh     | 8 ++++++++
 ci/tumbleweed.sh | 3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/ci/alt.sh b/ci/alt.sh
index 884c995..65389be 100755
--- a/ci/alt.sh
+++ b/ci/alt.sh
@@ -12,12 +12,15 @@ apt-get install -y \
 		asciidoc \
 		attr \
 		docbook-style-xsl \
+		gnutls-utils \
 		libattr-devel \
 		libkeyutils-devel \
+		libp11 \
 		libssl-devel \
 		openssl \
 		openssl-gost-engine \
 		rpm-build \
+		softhsm \
 		wget \
 		xsltproc \
 		xxd \
diff --git a/ci/debian.sh b/ci/debian.sh
index ad7d2c0..ae5c9c1 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -48,7 +48,8 @@ $apt \
 	procps \
 	sudo \
 	wget \
-	xsltproc \
+	xsltproc
 
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl1.1$ARCH || true
+$apt softhsm gnutls-bin libengine-pkcs11-openssl1.1$ARCH || true
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 2d80915..0993607 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -25,6 +25,7 @@ yum -y install \
 	automake \
 	diffutils \
 	docbook-xsl \
+	gnutls-utils \
 	gzip \
 	keyutils-libs-devel \
 	libattr-devel \
@@ -33,6 +34,7 @@ yum -y install \
 	make \
 	openssl \
 	openssl-devel \
+	openssl-pkcs11 \
 	pkg-config \
 	procps \
 	sudo \
@@ -42,3 +44,9 @@ yum -y install \
 
 yum -y install docbook5-style-xsl || true
 yum -y install swtpm || true
+
+# SoftHSM is available via EPEL on CentOS
+if [ -f /etc/centos-release ]; then
+	yum -y install epel-release
+fi
+yum -y install softhsm || true
\ No newline at end of file
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index dfc478b..4e3da0c 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -42,6 +42,9 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	which \
 	xsltproc
 
+zypper --non-interactive install --force-resolution --no-recommends \
+	gnutls openssl-engine-libp11 softhsm || true
+
 if [ -f /usr/lib/ibmtss/tpm_server -a ! -e /usr/local/bin/tpm_server ]; then
 	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
 fi
-- 
2.31.1

