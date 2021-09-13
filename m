Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369D7409F90
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbhIMWTp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34194 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235947AbhIMWTn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:43 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DM7gGK019883
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=R8jxx4oEsfcaO/2zaTFo5GLEjSEe2gGwuMFrpAhgPlc=;
 b=tCrUCQY4ujmhSO1BC9WUF5d767cyYF69+qopcZTUNnN1QmjSwNlIEcITSM/Ln/2J054E
 U6yVqL80nGSyjCtEn0jDOB1IbbrT0G86JVm8arZPx3PBXajD7z6K4n6cZ6iS17i2hERH
 eVwnusfL4miq+WTDsTgrVuGdHsUdLbYTge6mCWFvQZCBawKCuaO0DyL4tRfeFHnXP8VI
 GtJbJfgazbutqAn/vcp4+fqTBr0UigjYHGgUbI7EStfyxMXkxIYLqnQ//VDTD8ojBJCS
 WMtuUqkkbitSYrsLkvlFGFJsT8R8Dy9U+zcjkcHiIcsdDjhvsYstpTWuwOnQA80X6p0u 0Q== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b232jaqjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:26 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMHkF1021001
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:26 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3b0m3adaxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:26 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMIOQ916777564
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:24 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DEDBBE054;
        Mon, 13 Sep 2021 22:18:24 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E7FDBE053;
        Mon, 13 Sep 2021 22:18:24 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:24 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 9/9] tests: Get the packages for pkcs11 testing on the CI/CD system
Date:   Mon, 13 Sep 2021 18:18:13 -0400
Message-Id: <20210913221813.2554880-10-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iXceF0yaLmTN8PxXoFpXXYi8sSxkgrqG
X-Proofpoint-ORIG-GUID: iXceF0yaLmTN8PxXoFpXXYi8sSxkgrqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130046
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Get the packages for pkcs11 testing on the CI/CD system, where available.
On those system where it is not available, skip the two tests.

The following distros cannot run the pkcs11 tests:

- Alpine: package with pkcs11 engine not available
- CentOS7: softhsm 2.1.0 is too old for tests to work; tests also fail
           when trying to sign with pkcs11 URI using openssl command line tool
- OpenSuSE Leap: softhsm package not available in main repo

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

