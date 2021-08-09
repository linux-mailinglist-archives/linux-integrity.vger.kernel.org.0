Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF833E4860
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbhHIPLC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 11:11:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50254 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235284AbhHIPLB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 11:11:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179F2tTP168625
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 11:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G/U2VTUWRFdYulfF4SiTJa9/LeDOd+/xQxwVs//3lu4=;
 b=W/50qeCvcLkBiX98FIyqKosSBmFerGnuw4QHt1LX6Usgy3tIEHJ5q3GArWbX6EG4Dp7i
 2N5J2XdYyNT0Ip3TGdZtQfjE8CgLcUmhPXsypab3Doy8SQRH7iU0YSHKkNIQf9STbsGg
 5Izc3fqRu7wl3fn+9xHzdlieoLpT1TAzVDwxi3tA9nzVkjv1rltVVE5qixKDYje3DF2n
 YQk5ZxNK9toYhRPm7y0UUenbtdT5ion/LegEy4k40RbbeSjdF6k374XgSUkBNg/gXki/
 5+OcYzNK0O9gVtY9W9eFyndge0MiDVQk/a/9crvdhbODIfSMyGmrSptjXYlvuI1RbXAE Hw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab5k3jpec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 11:10:38 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179F2iAT029086
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 15:10:36 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3a9htbtjjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 15:10:34 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179FATVH11403692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 15:10:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A44E27E2E8;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 957EE7E305;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 4/4] tests: Get the packages for pkcs11 testing on the CI/CD system
Date:   Mon,  9 Aug 2021 11:10:26 -0400
Message-Id: <20210809151026.195038-5-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
References: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TZEgtwkS0DxpNV7sHQg1j_sa6IleL2Yn
X-Proofpoint-GUID: TZEgtwkS0DxpNV7sHQg1j_sa6IleL2Yn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_05:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090111
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

