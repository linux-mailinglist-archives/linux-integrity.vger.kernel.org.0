Return-Path: <linux-integrity+bounces-311-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5733E800C2C
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269AC1C20F3D
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5093B2B5;
	Fri,  1 Dec 2023 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ADn3Ik5n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3810FC
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:55 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DVGJ3012484
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bFwkzrgYTvx/bONkknb0mGv7TBbeYwfgxiNyVrGnCXQ=;
 b=ADn3Ik5nTuMWzEqtPxD8Vi1FVK0E9QPNl93eU6IzTjTj5sh0Ag86HBchg1lBvlfmS9So
 hqt8K9iu1WGd7404ar0x17BpKR2qNTNxJY//4WMRO4+KU45IoxkrEE2QFC5G6sKiiCaA
 5io7WaYEBWo7QYSC0FMf7cIKn/CqX+IzzX1rKOcBKcUWFpjPubsp1Mpwsj+kjeikBhAB
 4NABoi2QVXeRL9h+pSbCcPrHUfE8rP5QpIJbPDWB/1S6aPEycG0eYGg8GbxMAARgU7G1
 guHrrPih7VmdUPzYaJM1ddOP1hHA2SQ9XEaTyUS0G1OKrbQdJgFMv+rulJRp4TdDserg NA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqfsuser0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXskN017353
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy2cqgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVq4R11338338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90405805A;
	Fri,  1 Dec 2023 13:31:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A57A58052;
	Fri,  1 Dec 2023 13:31:52 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:52 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 06/14] tests: Address issues raised by shellcheck SC2034
Date: Fri,  1 Dec 2023 08:31:28 -0500
Message-ID: <20231201133136.2124147-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201133136.2124147-1-stefanb@linux.ibm.com>
References: <20231201133136.2124147-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I8AUKRuQeh25OZIhFFA2UNDiy4lZNSiu
X-Proofpoint-ORIG-GUID: I8AUKRuQeh25OZIhFFA2UNDiy4lZNSiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=984 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010092

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


