Return-Path: <linux-integrity+bounces-5-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF87E83A1
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6286A281302
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B53B7A9;
	Fri, 10 Nov 2023 20:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GkU4M68E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E843B785
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:49 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B6A9
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:47 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKE6Q6010973;
	Fri, 10 Nov 2023 20:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=+uJhgvUY7XS95kn+BR/0Rzx+H9oPkU5ICD2HnQ6hxc8=;
 b=GkU4M68EUMds+cv3v3cieZl5PNF4/pESzMByefh2ouRvtHA8PpMDhmWzepFIGkKxnDGS
 kOTNC2Kkk6gDvp3pgVNa0lLgQc6DZeVk2cZkZ1w1G5ZB607uqKWZhfBDzxU6J/vMMhYm
 gKuqbAw3sjcbWtOBIk4BaElLsPbWncf2FtVYJfltzk99k413yPC2FbwBFKSkcIwJm89U
 8VdqagJrFzRRZ68zTvsHOTawwoqo/LYPvRzIY9UWsi9mANoOTnE6TOXQaB/ciURCFF3b
 JjE2BKw7AO3MhzF5GcX7bs6ep0CQn5YfYO/OXZQkKOCiFtqND08wvdOdtfMJhD23V1m2 Ew== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9ucb08e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:44 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJQxpA004112;
	Fri, 10 Nov 2023 20:21:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21dd49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLgSF22741566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AF4958061;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22F9458058;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 07/14] tests: Address issues raised by shellcheck SC2164
Date: Fri, 10 Nov 2023 15:21:30 -0500
Message-ID: <20231110202137.3978820-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110202137.3978820-1-stefanb@linux.ibm.com>
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x4r-UtGJOTQwyDc2prWicbm-0uhUjR8l
X-Proofpoint-ORIG-GUID: x4r-UtGJOTQwyDc2prWicbm-0uhUjR8l
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100170

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
index 2c86ba8..c3eeb43 100644
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
2.41.0


