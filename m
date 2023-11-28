Return-Path: <linux-integrity+bounces-265-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63537FC217
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C3282AD7
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF039AD9;
	Tue, 28 Nov 2023 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fX6ob5gT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87CF30D8
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:18 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHXniT011874
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=cAL4DHFP7UoXYvElFpKrVWL6OfvJaJg0nyWk6phGV2E=;
 b=fX6ob5gTQngm9XrSh5v4ylYjYzuQU7LPgda8OBsQnWivQDUoxDlgFZimOP4rckQWXDxy
 u4BuFb8eK1y47RCE2zEPlPBo4+D5Nbx7oQsCGR8Fxfz1qCRZBFKycx7OrYQK4TC4Z15Q
 CAaKA2aK3YfAEaWkwGPLsZsUv4d0z4JoyNVKiZ/8FHaXkDQAHwc+OzVg1sRov9GOthON
 MZ3YJcPNa7EbS15ho8vgW88yHh69MJLqoGUUFpGzrUDJepyN5Y26Xyy2YE/gu/8r55Hm
 iUXKhvw1cMwukYyorFls+9CkxJekMFdy+IbUF9cu0SQ7lZf0i8vWv2xWb+j5nhbJdZss Mw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unmq9h7ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:17 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG26wT031065
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8t1uhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGGq621824120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8458E58051;
	Tue, 28 Nov 2023 18:16:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 425FE5805A;
	Tue, 28 Nov 2023 18:16:16 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:16 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 03/14] tests: Address issues raised by shellcheck SC2046
Date: Tue, 28 Nov 2023 13:16:01 -0500
Message-ID: <20231128181613.1159958-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128181613.1159958-1-stefanb@linux.ibm.com>
References: <20231128181613.1159958-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _1R2sdjY3nQA1kODfOuy6OOoPgNnn-Bp
X-Proofpoint-GUID: _1R2sdjY3nQA1kODfOuy6OOoPgNnn-Bp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Address issues raised by shellcheck SC2046:
  "Quote this to prevent word splitting."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am         | 2 +-
 tests/install-fsverity.sh | 2 +-
 tests/install-openssl3.sh | 2 +-
 tests/install-swtpm.sh    | 9 +++++----
 tests/install-tss.sh      | 2 +-
 tests/softhsm_setup       | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 86796c3..6fe18e4 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181 \
+	shellcheck -i SC2086,SC2181,SC2046 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
index c760485..fa31b2b 100755
--- a/tests/install-fsverity.sh
+++ b/tests/install-fsverity.sh
@@ -2,5 +2,5 @@
 
 git clone https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git
 cd fsverity-utils
-CC=gcc make -j$(nproc)
+CC=gcc make -j"$(nproc)"
 cd ..
diff --git a/tests/install-openssl3.sh b/tests/install-openssl3.sh
index 6658c23..edd99de 100755
--- a/tests/install-openssl3.sh
+++ b/tests/install-openssl3.sh
@@ -21,7 +21,7 @@ fi
 ./Configure ${FLAGS:+${FLAGS}} no-engine no-dynamic-engine --prefix=/opt/openssl3 --openssldir=/opt/openssl3
 # Uncomment for debugging
 # perl configdata.pm --dump | grep engine
-make -j$(nproc)
+make -j"$(nproc)"
 # only install apps and library
 sudo make install_sw
 
diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index ff44b52..a0e60ee 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -ex
+#!/bin/bash -ex
 
 # No need to run via sudo if we already have permissions.
 # Also, some distros do not have sudo configured for root:
@@ -10,7 +10,8 @@ else
 fi
 
 git clone https://git.code.sf.net/p/ibmswtpm2/tpm2
-cd tpm2/src
-make -j$(nproc)
+pushd tpm2/src 1>/dev/null || exit 1
+make -j"$(nproc)"
 $SUDO cp tpm_server /usr/local/bin/
-cd ../..
+popd 1>/dev/null
+
diff --git a/tests/install-tss.sh b/tests/install-tss.sh
index c9c179e..31ea690 100755
--- a/tests/install-tss.sh
+++ b/tests/install-tss.sh
@@ -3,6 +3,6 @@
 set -ex
 git clone https://git.code.sf.net/p/ibmtpm20tss/tss
 cd tss
-autoreconf -i && ./configure --disable-tpm-1.2 --disable-hwtpm && make -j$(nproc) && sudo make install
+autoreconf -i && ./configure --disable-tpm-1.2 --disable-hwtpm && make -j"$(nproc)" && sudo make install
 cd ..
 rm -rf tss
diff --git a/tests/softhsm_setup b/tests/softhsm_setup
index 95bf0b1..6f8a74e 100755
--- a/tests/softhsm_setup
+++ b/tests/softhsm_setup
@@ -82,7 +82,7 @@ setup_softhsm() {
 		fi
 		sudo mv /etc/gnutls/pkcs11.conf \
 			/etc/gnutls/pkcs11.conf.bak &>/dev/null
-		if [ $(id -u) -eq 0 ]; then
+		if [ "$(id -u)" -eq 0 ]; then
 			SONAME="$(sudo -u nobody brew ls --verbose softhsm | \
 				  grep -E "\.so$")"
 		else
-- 
2.43.0


