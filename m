Return-Path: <linux-integrity+bounces-269-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B477FC220
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF73C282BE3
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DDE3D0A6;
	Tue, 28 Nov 2023 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pHk8q2/o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E668B30E6
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:20 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI2aV1024095
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/r4mXdj+WL0aG04+qDwl6s2cokRhzG2wubQlL8Wx94E=;
 b=pHk8q2/oGgUelcMLMaKQ6zKIaR13f1Q/XV0NCWEZaNg2VPuDOfsXVi69Bjbp6A9W4iLT
 fis6ey4B1M4Il1uMMW+twTXdh3vrqTZ/KUHlR00rTZvf5zAVVhtq5Ri8kx0fGvWg182y
 QUsefH14fmK2voFXwmsrWTCm1hZBu/R/xfVKtgFAgEfaWCMErc/eW1CLj/1mBC+heB7V
 k4gE/Hsj4gIWh/CWBvFm+vZI9TM7Ufzy+CDg+fUiLj01YlDcntV17HT7k1xpIvmTnlZO
 URaJ4soU8+gkCp6A5zT/XLgCroLXURVGvQ4uE+QYJntjiJseXm7yhOvECOJdsJeJe0RJ ig== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unn4p8f2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG8Ac1028313
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nhk1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGIPr19661530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09A985805E;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB295805A;
	Tue, 28 Nov 2023 18:16:17 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 07/14] tests: Address issues raised by shellcheck SC2164
Date: Tue, 28 Nov 2023 13:16:05 -0500
Message-ID: <20231128181613.1159958-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128181613.1159958-1-stefanb@linux.ibm.com>
References: <20231128181613.1159958-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9Zz6U3g_qHtxHmbgOKKcaItnSm-cyfZV
X-Proofpoint-ORIG-GUID: 9Zz6U3g_qHtxHmbgOKKcaItnSm-cyfZV
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

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


