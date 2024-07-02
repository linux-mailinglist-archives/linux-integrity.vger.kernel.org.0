Return-Path: <linux-integrity+bounces-2966-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E102924BD9
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 00:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C7C1C21DA6
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5C1DA339;
	Tue,  2 Jul 2024 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cYMcwsnO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7C282E1
	for <linux-integrity@vger.kernel.org>; Tue,  2 Jul 2024 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960527; cv=none; b=TQs+bc1ccHSjiaSnMH9WZbwRyp6WPJarv9Z7dLICrowLitv1a7yaWtatxNAY0kQdvEc2fDZTmhr5KfHTHGGZag5NFZqXnTG7JZSGMlUDc7+pm2iv9d4JVzkOxYSmnqPhoR/L/XGu+nT1J/uL4iwC6Uq9RBLPk6T6swPNP2+B/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960527; c=relaxed/simple;
	bh=nGoi2OUl6iigAZShQGkOS73osibRYLO7ib4lLZ/4sBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmDXy2uP78txyhsMpVqayvqvKua2HOtKc7wfzK1oNstpKYv1f/u9xtDlcpRdPIoaAJxPSWunpqfkU3Tp4Jos3d+dxTdivwwR1d4OCwnX0kJ425UmtTedhuAAJ7rvcG0VXEKRHMWg0PVNvk9tD9q8PpYZKChvPAEGK0zNyUOGk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cYMcwsnO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462McWSC007782
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jul 2024 22:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=/3AqCYl8B37LehxReeIyGMpTA1
	qBsC8ju4UxpsCQmm8=; b=cYMcwsnOY2KUBqL2YQVJ9R43kKWxiHs25biWCjzo+W
	M9FEmjwCadmI0FOaXEbtRZiwK/2flpA4RQS92MsxggedrOEAl5wxSlOwOjA4tBTg
	RR9nUOGm78Ps68ig84tEHrxupmhfeoapr7L5nnlBHphLTay+rukOXyCEjlW+cKRl
	x8BzEYt1FPa+3nGOBwmPokyxSstfuRJz/PDXOxyKoPGWwqlHG38UBgfrZdAf8+eB
	WiX7A0Ma0/3DBii51DOf55mZcaSEJBy7mxDn5maN2F02191A9LP918KEw4oe38uO
	2bHawJaalB722uHn3x4HX7gPjTBClvfaLRZTXa5SooZA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404sxa8390-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jul 2024 22:48:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 462MjwcY024071
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jul 2024 22:48:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya3f06j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jul 2024 22:48:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 462Mmbbt33227332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 22:48:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C58E20043;
	Tue,  2 Jul 2024 22:48:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C85D20040;
	Tue,  2 Jul 2024 22:48:36 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com.com (unknown [9.61.154.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jul 2024 22:48:36 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2] ci: EOL CentOS Stream 8 and CentOS 7
Date: Tue,  2 Jul 2024 18:48:26 -0400
Message-ID: <20240702224826.12775-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZLp_IsgIdw88YFE-WxoOEfW6n6Bmc3_o
X-Proofpoint-ORIG-GUID: ZLp_IsgIdw88YFE-WxoOEfW6n6Bmc3_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_16,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020164

Remove CentOS Stream 8 and CentOS 7, which reached End of Life (EOL) on
on May 31, 2024 and June 30, 2024 respectively.  Replace with CentOS
Stream 9.

Install crb for tpm2-tss-devel and tss2-devel on CentOS stream 9.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .github/workflows/ci.yml | 4 ++--
 .travis.yml              | 6 +-----
 ci/fedora.sh             | 6 ++++++
 ci/quay.io.sh            | 1 +
 4 files changed, 10 insertions(+), 7 deletions(-)
 create mode 120000 ci/quay.io.sh

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 71fcaaeb3061..2144990f1793 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -160,9 +160,9 @@ jobs:
               TST_KERNEL: ../linux
               TST_EVM_CHANGE_MODE: 1
 
-          - container: "centos:7"
+          - container: "quay.io/centos/centos:stream9"
             env:
-              CC: gcc
+              CC: clang
               TSS: tpm2-tss
 
           - container: "debian:testing"
diff --git a/.travis.yml b/.travis.yml
index b8876f45333b..b69073883087 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -56,11 +56,7 @@ matrix:
           compiler: clang
 
         - os: linux
-          env: DISTRO=centos:7 TSS=tpm2-tss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
-          compiler: gcc
-
-        - os: linux
-          env: REPO="quay.io/centos/" DISTRO="${REPO}centos:stream8" TSS=tpm2-tss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
+          env: REPO="quay.io/centos/" DISTRO="${REPO}centos:stream9" TSS=tpm2-tss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
           compiler: clang
 
         - os: linux
diff --git a/ci/fedora.sh b/ci/fedora.sh
index 44fd956ab075..9fc3393721b8 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -7,6 +7,12 @@ if [ -z "$CC" ]; then
 	exit 1
 fi
 
+# Install crb for tss2-devel and tpm2-tss-devel on CentOS stream 9
+if [ -f /etc/centos-release ]; then
+	yum -y install dnf-plugins-core
+	yum -y config-manager --set-enabled crb
+fi
+
 case "$TSS" in
 ibmtss) TSS="tss2-devel";;
 tpm2-tss) TSS="tpm2-tss-devel";;
diff --git a/ci/quay.io.sh b/ci/quay.io.sh
new file mode 120000
index 000000000000..1479a43e04ed
--- /dev/null
+++ b/ci/quay.io.sh
@@ -0,0 +1 @@
+fedora.sh
\ No newline at end of file
-- 
2.43.0


