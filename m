Return-Path: <linux-integrity+bounces-272-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E67FC22A
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612E4282BE8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2233D0AE;
	Tue, 28 Nov 2023 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oj4k2GY2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFA630D1
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:22 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASIFrtS032484
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rfQxeGMBaqBV0+aNq47m5YRRAVMZThDcfBKt3QqpC0I=;
 b=Oj4k2GY29HkXhd9wfLBbNFhGMt2nt7/RAO2Jk8BR3yOd0PNkSua7WaHmQt3wxqjsjRFm
 3XV8OhhKyUtzVDRZiOPr6AjXIMNNi5gpYeulL6mz1Xnm1W1pCWFWquk233nuCEQAm5WO
 Nn/Lytj7ZJRSNyqHlsj1M7GfR5TQQu0PqVI+7dMPDkNjAd8jsUWa7SUtqmQPT9tAw+pd
 rSjgYUY1ZN8MSW6aoZXcvoSGucrAf5zNQABwDPtGNNj01Fl3SzEdrBtpqGPNbpF0/ibO
 PJAe/yxCdT5gX0OB8M2CMdjsNDA8XI0gbC/ZH5EzDSRCyMrm3Hxgi4F25FjbOQT5uUgz 7g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unn2fgh5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG0IIP027610
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyhs3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGJWf6816336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C65D5805A;
	Tue, 28 Nov 2023 18:16:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E47A758051;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 10/14] tests: Address issues raised by shellcheck SC2206
Date: Tue, 28 Nov 2023 13:16:08 -0500
Message-ID: <20231128181613.1159958-11-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: INUZRt62kQ7pql8GJgE_5Kvt3IHIzq6M
X-Proofpoint-ORIG-GUID: INUZRt62kQ7pql8GJgE_5Kvt3IHIzq6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Address issue raised by shellcheck SC2206:
  "Quote to prevent word splitting/globbing, or split robustly with
   mapfile or read -a."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am         | 2 +-
 tests/boot_aggregate.test | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index c7c2b21..c9a8d67 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -129,7 +129,7 @@ check() {
 		exit "$SKIP"
 	fi
 
-	boot_aggr=( $bootaggr )
+	read -r -a boot_aggr <<< "$bootaggr"
 
 	echo "INFO: Searching for the boot_aggregate in ${ASCII_RUNTIME_MEASUREMENTS}"
 	for hash in "${boot_aggr[@]}"; do
-- 
2.43.0


