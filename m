Return-Path: <linux-integrity+bounces-315-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF3800C2F
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A958281BB2
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CB83B7AC;
	Fri,  1 Dec 2023 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T9tLawNB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC5C170B
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:57 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DCPDm004656
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KaMD53FyaY+U/ZprZcrTpPx3OZ9FrxMKcTpsjJ9Qc3c=;
 b=T9tLawNBZOf/i0LQdsr7XET1IoxShFQFAXT+ntBEu2fXKyIotpM5cIh430SREnnMXtrE
 6sdZiJk87aoitzq1I8x2oPfvpofCbdmbai2OY/hxiWzbw0h8U/afMxfajPqKbT51yQrr
 ZLChPrrgqF75mHH2FOPtOYbtW3y0z9ceNwqOINWmu8KB36Ab4v7MbPWSFWHgGDpKmCPu
 EGoDZaM+4ilf+ZxGIXASbiQvZZ5/NdYmB7OTn9CrkM+RsZ1YZqhvupwHs/mEjXG6syML
 luIoSisJ4XR8YsnOU4e0xsXzCVeq9yffz9q1Va43alifcyZ6FSMPespIySeVSc4E2mBb 8A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqg5qrjgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:56 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXmAa031619
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukun05e9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVsL48192606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D78E58056;
	Fri,  1 Dec 2023 13:31:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9B0D58052;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 10/14] tests: Address issues raised by shellcheck SC2206
Date: Fri,  1 Dec 2023 08:31:32 -0500
Message-ID: <20231201133136.2124147-11-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: wMe74yucleFojm6zttKUcrIpmzUlAfxr
X-Proofpoint-ORIG-GUID: wMe74yucleFojm6zttKUcrIpmzUlAfxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010092

Address issue raised by shellcheck SC2206:
  "Quote to prevent word splitting/globbing, or split robustly with
   mapfile or read -a."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am         | 2 +-
 tests/boot_aggregate.test | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 9092c43..cbf637c 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -28,7 +28,7 @@ distclean: distclean-keys
 shellcheck:
 	shellcheck \
 		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
-		-i SC2294 \
+		-i SC2294,SC2206 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index c7c2b21..7817c2b 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -128,8 +128,7 @@ check() {
 		echo "${CYAN}SKIP: evmctl ima_boot_aggregate: $bootaggr${NORM}"
 		exit "$SKIP"
 	fi
-
-	boot_aggr=( $bootaggr )
+	IFS=$'\n' readarray -t boot_aggr <<< "$bootaggr"
 
 	echo "INFO: Searching for the boot_aggregate in ${ASCII_RUNTIME_MEASUREMENTS}"
 	for hash in "${boot_aggr[@]}"; do
-- 
2.43.0


