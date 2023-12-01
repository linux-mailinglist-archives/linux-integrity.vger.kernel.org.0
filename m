Return-Path: <linux-integrity+bounces-320-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1133D800C37
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BEF2815B8
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529313AC1A;
	Fri,  1 Dec 2023 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jOna0KrC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F3D170F
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:57 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DH4Yj021782
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K2OSIIWeR+/mVCpZD6SxIqXKHERmaQICjyFMubPt4pk=;
 b=jOna0KrCRxOIJMZyFp+m3gSkLaeaqu1uVYbMtGLdfalOnNgSLUtXI4qB/BXG8Gaowuer
 /rxFvT7KsExXobK9zLUY4QM2Tv06+LjB1YFaOFHSKPc3j4EJIsIh8xV/hYMOTzLWzaga
 DFratXW6GCoRhgaFK+JKq4M1dV2Iofk3Zglu6BOLwTOIRm4a65ScHkEiJZ8IWAyEr0aK
 6hjjxbw3Hl264kjLXcHnADnOXR4OdERkhhoKLv0axGHKL/e4LHbOZf/92gur+AD/E3CK
 3zaem2sbExGdPPXapNSVUJliZFOoLjU58/c7IMSQ5dgA7e0d9MvOV6vBZKYP5P8CBGNd og== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqg828f9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXo9C006360
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfkmuyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVtub26018418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 488A75805E;
	Fri,  1 Dec 2023 13:31:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A1B158056;
	Fri,  1 Dec 2023 13:31:55 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:54 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 13/14] tests: Address issues raised by shellcheck SC2295
Date: Fri,  1 Dec 2023 08:31:35 -0500
Message-ID: <20231201133136.2124147-14-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: no8t849zdzxHIcSd1aDzZadG74k7JcLi
X-Proofpoint-ORIG-GUID: no8t849zdzxHIcSd1aDzZadG74k7JcLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxlogscore=965 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010092

Address issues raised by shellcheck SC2295:
  "Expansions inside ${..} need to be quoted separately, otherwise they
   will match as a pattern."

There's not variable digest_type but it's a plain string and therefore
treat it as such.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/Makefile.am   | 2 +-
 tests/fsverity.test | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 4ce71f4..7b3d92b 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -28,7 +28,7 @@ distclean: distclean-keys
 shellcheck:
 	shellcheck \
 		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
-		-i SC2294,SC2206,SC2196,SC2043 \
+		-i SC2294,SC2206,SC2196,SC2043,SC2295 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/fsverity.test b/tests/fsverity.test
index ddd6993..a6ba68b 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -169,7 +169,7 @@ unqualified_bprm_rule() {
 	local rule_match="measure func=BPRM_CHECK"
 	local rule_dontmatch="fsuuid"
 
-	if [ -z "${rule##*$digest_type=verity*}" ]; then
+	if [ -z "${rule##*digest_type=verity*}" ]; then
 		if grep "$rule_match" $IMA_POLICY_FILE | grep -v "$rule_dontmatch"  &> /dev/null; then
 			return "$SKIP"
 		fi
-- 
2.43.0


