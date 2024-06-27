Return-Path: <linux-integrity+bounces-2937-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA1291AF8B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2024 21:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347C42869A3
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2024 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F2405CC;
	Thu, 27 Jun 2024 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J/LoCLgW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E012EAEA
	for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516044; cv=none; b=HyARaPa8jA29EMTxcVelFgdkLbb7vZ54Sn4Ca5+aoB1k1vCVq4WuHpyoUpLyupnwg487GRgfnAOEH3G65JWIjiETiIgaYDUPBbNO/r2S+mhbmuMLAgr0YWxrUo3AiwJoMCkL1FjVyBxT1+3cwaUZ/ywogE5Dkcq4cf/EXlrp6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516044; c=relaxed/simple;
	bh=q5I3ue5pXOFaFcZG+la4qhNiovoZDk053Ua4gQfvwN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIYqDoP2jZ+dd0aWRaNkTOFjTvO7mhhYhhIYbtZzN0vHLqZd2ksDqFNS5g9EgBmdKHKFyCgAt9ZNe4eZIesXvgTEAjih4LXmXjcexIcIhK/tMWXQ2nFedDdaDf9GokLNmVXovrfhfP1vKHX1LiSnKnp9zEOP9KuSppdfDEkU400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J/LoCLgW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RIxep0027745
	for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2024 19:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=3v77jUAYVfradg02qM7CSDoHgE
	cR1mHxS1wLiiXI7H8=; b=J/LoCLgWsWyI0gBWlv8wFNubpCk0BWT22ROLBRlLVL
	nq8XkMuby5WUrGW95fYUWHKLr5XD4s4/AvsA2sd3+odm0RIZoK8n/GKCg59qLenv
	hJzHbvLmOE2ejXe4JzjgdwX7txCIqon/qAjvg+qir+xfImJMA9XYQ9mTr34oao8f
	iH02Jk+0nZFBtB/CpZiENyWHAMwKFkltNkLZeCHSJob4fXxyYZJQAPPDFpPRR7OG
	7MXJv+NakwBS2ci5+bEup0K7kaK7IOmGyF+jsRXMRrq82pZO0PZh9FY9NvhVw1rz
	JIdsdCC9SCTknn095SJ5CqjdhVN5IVt1zkCPrw1H1yyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 401dty81qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2024 19:20:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45RGiuVA000402
	for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2024 19:20:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3m19c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2024 19:20:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RJKVAb55116224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 19:20:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FCFE20043;
	Thu, 27 Jun 2024 19:20:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4C6820040;
	Thu, 27 Jun 2024 19:20:30 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.watson.ibm.com (unknown [9.31.110.109])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 19:20:30 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH] ci: EOL CentOS Stream 8 and CentOS 7
Date: Thu, 27 Jun 2024 15:20:21 -0400
Message-Id: <20240627192021.5075-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v9ylepTwkqAci5Xo7g65cD1Ge6yrFiXB
X-Proofpoint-GUID: v9ylepTwkqAci5Xo7g65cD1Ge6yrFiXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=952 impostorscore=0 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270141

Remove CentOS Stream 8 and CentOS 7, which reached End of Life (EOL) on
on May 31, 2024 and June 30, 2024 respectively.  Replace with CentOS
Stream 9.

tpm2-tss, tpm2-tss-devel and tss2-devel packages do not exist on
CentOS stream 9.  Differentiate between Fedora and CentOS.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .github/workflows/ci.yml |  4 ++--
 .travis.yml              |  6 +-----
 ci/fedora.sh             | 17 +++++++++++------
 ci/quay.io.sh            |  1 +
 4 files changed, 15 insertions(+), 13 deletions(-)
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
index 44fd956ab075..10d4256bb957 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -7,12 +7,17 @@ if [ -z "$CC" ]; then
 	exit 1
 fi
 
-case "$TSS" in
-ibmtss) TSS="tss2-devel";;
-tpm2-tss) TSS="tpm2-tss-devel";;
-'') echo "Missing TSS!" >&2; exit 1;;
-*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
-esac
+# Neither tss2-devel nor tpm2-tss-devel exist on CentOS stream 9
+if [ -f /etc/centos-release ]; then
+	TSS="$TSS"
+else
+	case "$TSS" in
+	ibmtss) TSS="tss2-devel";;
+	tpm2-tss) TSS="tpm2-tss-devel";;
+	'') echo "Missing TSS!" >&2; exit 1;;
+	*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
+	esac
+fi
 
 # ibmswtpm2 requires gcc
 [ "$CC" = "gcc" ] || CC="gcc $CC"
diff --git a/ci/quay.io.sh b/ci/quay.io.sh
new file mode 120000
index 000000000000..1479a43e04ed
--- /dev/null
+++ b/ci/quay.io.sh
@@ -0,0 +1 @@
+fedora.sh
\ No newline at end of file
-- 
2.39.3


