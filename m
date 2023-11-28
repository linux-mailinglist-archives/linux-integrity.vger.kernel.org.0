Return-Path: <linux-integrity+bounces-270-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A6D7FC223
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5100B282AC5
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D93D0AA;
	Tue, 28 Nov 2023 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZtajOYxp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872930E3
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:20 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHrd5T031363
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bFwkzrgYTvx/bONkknb0mGv7TBbeYwfgxiNyVrGnCXQ=;
 b=ZtajOYxpMd4o/6fMko/JTy2GKkoJu+PnFiAkKVRX3CNM5TU0JfxNDUenKH8FXhPeOREF
 ZpVIUS2LzfCZn2de9BIYxoQOcejfRfQQEb+EQVeKSkCwtHfYiZRRaIpn+LAfUFyeELZ5
 vfy0p7y5U7qX9Cw3jWMYsnPj+V6sKfIHobvijTUVrJDIxRlCJ6p1QUAVS9aXfXksZo9L
 aMCR+FuMuhuHmzM5qJl1v7eKrp/levZCBgpdflSDKnHC//YauN74rj5xJRHjnHLfR2o8
 C3pzFB/I/v92MTK7kq3cAmCZjlplYI4/lDqecfqrE4xgXwA/0yk12Lbma7ISWNfatY2z bQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unn0n0m39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG0N2w012189
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkhf2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGHNM25821800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AE695805C;
	Tue, 28 Nov 2023 18:16:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62DDB5805A;
	Tue, 28 Nov 2023 18:16:17 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 06/14] tests: Address issues raised by shellcheck SC2034
Date: Tue, 28 Nov 2023 13:16:04 -0500
Message-ID: <20231128181613.1159958-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128181613.1159958-1-stefanb@linux.ibm.com>
References: <20231128181613.1159958-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CQCkjJsILQFso7J_07VfQ7XtIlpT7VjH
X-Proofpoint-GUID: CQCkjJsILQFso7J_07VfQ7XtIlpT7VjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=985
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Address issues raised by shellcheck SC2034:
  "foo appears unused. Verify it or export it."

Export PKCS11_KEYURI in a separate statement to avoid the following
shellcheck issue:

  SC2155 (warning): Declare and assign separately to avoid masking
                    return values.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am     | 2 +-
 tests/functions.sh    | 1 +
 tests/mmap_check.test | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index e2fcb16..79e2775 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317 \
+	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/functions.sh b/tests/functions.sh
index 9670b3a..4ad61ef 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -371,6 +371,7 @@ _softhsm_setup() {
   if msg=$(./softhsm_setup setup 2>&1); then
     echo "softhsm_setup setup succeeded: $msg"
     PKCS11_KEYURI=$(echo "$msg" | sed -n 's|^keyuri: \(.*\)|\1|p')
+    export PKCS11_KEYURI
 
     export EVMCTL_ENGINE="--engine pkcs11"
     export OPENSSL_ENGINE="-engine pkcs11"
diff --git a/tests/mmap_check.test b/tests/mmap_check.test
index e3e5c71..18412b5 100755
--- a/tests/mmap_check.test
+++ b/tests/mmap_check.test
@@ -5,6 +5,8 @@
 #
 # Check the behavior of MMAP_CHECK and MMAP_CHECK_REQPROT
 
+# shellcheck disable=SC2034
+
 trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
 
 PATCHES=(
-- 
2.43.0


