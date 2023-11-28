Return-Path: <linux-integrity+bounces-274-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FA7FC22E
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952DE282AD1
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A33D0B2;
	Tue, 28 Nov 2023 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TY5mPryD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF230E9
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:21 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHXjHQ011790
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MY0XxR1i2Uz5rXjsDP4/3t/rVNVP+DFyDGF055k7bZo=;
 b=TY5mPryDwrTfpzdRE3kFGIyGVHewmugU4qbiwFGd7DvSDyUnNAm5HII6/0sgYTV3B4Nm
 vHqdMHE8IpmUoY3/3fFGzAnUOKuckPbT5bduuxzZgfZbJCiLIxC15xfxGfpzaxOhzEG5
 Q/TUMm1VqmjmANc+E3YI/k08hqbKV556aielrTRGaXhpv86r9kHRFFIsUJ18pZdoDNSs
 b7akPkqxJ1GSkzRXktNSCxsmgGipHEb4vKPLs0Ie++jXQFeEiMpT834VWhX/yoTS4GyP
 cDJUfLer8eHztsFbWR8rcOrIWkIB0VAnevB6NRCwSbE0qjg4JJGGFj0cRjmfgy1OH6Dn HQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unmq9h7y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFwcDf031027
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8t1uj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGIN012190290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE5D458060;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 826495805A;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 09/14] tests: Address issues raised by shellcheck SC2294
Date: Tue, 28 Nov 2023 13:16:07 -0500
Message-ID: <20231128181613.1159958-10-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CWy8y1E96e8bXFcL5T1xBPm4YAfEG4q8
X-Proofpoint-GUID: CWy8y1E96e8bXFcL5T1xBPm4YAfEG4q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Address issues raised by shellcheck SC2294:
  "eval negates the benefit of arrays. Drop eval to preserve
   whitespace/symbols (or eval as string)."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am | 4 +++-
 tests/gen-keys.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index df1fbff..9092c43 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,9 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
+	shellcheck \
+		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
+		-i SC2294 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 0b03ba4..c3d5a20 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -21,7 +21,7 @@ type openssl
 
 log() {
   echo >&2 - "$*"
-  eval "$@"
+  eval "$*"
 }
 
 if [ "$1" = clean ]; then
-- 
2.43.0


