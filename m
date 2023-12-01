Return-Path: <linux-integrity+bounces-313-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3E800C31
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A041B21380
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634C3B79A;
	Fri,  1 Dec 2023 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rg5tzaZe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191A810FF
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:56 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DCQtw004727
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/r4mXdj+WL0aG04+qDwl6s2cokRhzG2wubQlL8Wx94E=;
 b=Rg5tzaZeKFJwGqUhNIqy8tmx75QHkTykkcEKOBlGSmqasLSORJ1pLgbFmMhdq5xHsjOq
 YWPsaWTX0rTZ66IovmF1FwzLKXXBqP5N6xvhFhiyoIXtTkdhwt5BIanD8OcsV9D6XdEY
 1P+p+o/mpjqiNk1PPfmnVkaKyRg0EmuQXKFqXflqe6vhSHM1TiwpwkkJoouoeF+GdFYY
 +0naSe88xja3YiJJCBwuH7F3tzoxTyPMRSRJe95ZqehUjcNlEUZ2kakIczxva9TV5CzF
 B91OY5BNfeqF/CRDHnR0arUaBk1+FVSyFCosFZZsyH8vpBaZKvCdaU8GcBxAluUvVlj7 mw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqg5qrjg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXs9T002619
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8p57rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVraV19727020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0964158056;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEC0A58052;
	Fri,  1 Dec 2023 13:31:52 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:52 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 07/14] tests: Address issues raised by shellcheck SC2164
Date: Fri,  1 Dec 2023 08:31:29 -0500
Message-ID: <20231201133136.2124147-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201133136.2124147-1-stefanb@linux.ibm.com>
References: <20231201133136.2124147-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hCxbpzjEFZgwkVs1Svdv206J2cYyAGMf
X-Proofpoint-ORIG-GUID: hCxbpzjEFZgwkVs1Svdv206J2cYyAGMf
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
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010092

Address issues raised by shellcheck SC2164:
  "Use cd ... || exit in case cd fails."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am               | 2 +-
 tests/boot_aggregate.test       | 2 +-
 tests/install-fsverity.sh       | 2 +-
 tests/install-mount-idmapped.sh | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 79e2775..c5b2a2f 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034 \
+	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 04aef9b..c7c2b21 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -17,7 +17,7 @@ trap '_report_exit_and_cleanup cleanup' SIGINT SIGTERM EXIT
 # Base VERBOSE on the environment variable, if set.
 VERBOSE="${VERBOSE:-0}"
 
-cd "$(dirname "$0")"
+cd "$(dirname "$0")" || exit 1
 export PATH=../src:$PATH
 export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
 . ./functions.sh
diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
index fa31b2b..e2b0286 100755
--- a/tests/install-fsverity.sh
+++ b/tests/install-fsverity.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
 git clone https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git
-cd fsverity-utils
+cd fsverity-utils || exit 1
 CC=gcc make -j"$(nproc)"
 cd ..
diff --git a/tests/install-mount-idmapped.sh b/tests/install-mount-idmapped.sh
index c954006..d8a673c 100755
--- a/tests/install-mount-idmapped.sh
+++ b/tests/install-mount-idmapped.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
 git clone https://github.com/brauner/mount-idmapped.git
-cd mount-idmapped
+cd mount-idmapped || exit 1
 gcc -o mount-idmapped mount-idmapped.c
 cd ..
-- 
2.43.0


