Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDD63E5C15
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbhHJNq0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241821AbhHJNqY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADYRs7119065
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G/U2VTUWRFdYulfF4SiTJa9/LeDOd+/xQxwVs//3lu4=;
 b=GAQ+qR4Uubr/7e4QBD5CzlkA1WAqGkMWixuKoeBJd0OeayGrhmw1ZCOGaJmS3bvLJTsq
 irXsaxxy8VieHAsDNZ4/XGgQbYowKa6at1DfgUpT9j/4yX9yJmA+NaF41jkw6HrLyDQV
 /PuV0AF6c5S/beO6Hd8sN9ueIY4UWvzPFLg9MRLBTTihEsyS9vfFGAOGDCUcIYNKoq0t
 uu1T8SXrmT52T3h3P4n8wFzRUGCbXHS4X0uGMKZb+A7DOf4bxnLFOMSpmADVwI6UDius
 M9t+Ofosj8Gp3DEXTCAy7jV/Dj3NPGWnU9v6Yssz7TD3G+sdOTGg9gM74CwxNyAnKXjh Ig== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abruxbg7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:02 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADgrjZ028380
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:01 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3a9htcucvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxNm39322038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B29F4B206A;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3F56B2064;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 8/8] tests: Get the packages for pkcs11 testing on the CI/CD system
Date:   Tue, 10 Aug 2021 09:45:57 -0400
Message-Id: <20210810134557.2444863-9-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8SCB1VF2JAZ2Ywn2QGECBEAaSWallh2B
X-Proofpoint-ORIG-GUID: 8SCB1VF2JAZ2Ywn2QGECBEAaSWallh2B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Get the packages for pkcs11 testing on the CI/CD system.

This is the status on various distros:

- Alpine: could not find package with pkcs11 engine
- Alt Linux: works
- Debian: debian:stable: evmctl is not able to find the pkcs11 module but
          preceeding openssl command line tests with the pkcs11 URI succeeded;
          cannot recreate the issue locally in the debian:stable container
          --> disabled on Ubuntu and Debian
- CentOS7: tests with pkcs11 URI fail on openssl command line level
- CentOS: works
- Fedora: works
- OpenSuSE Leap: package not available in main repo
- OpenSuSE Tumbleweed: works

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 ci/alt.sh        | 3 +++
 ci/fedora.sh     | 8 ++++++++
 ci/tumbleweed.sh | 3 +++
 3 files changed, 14 insertions(+)

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

