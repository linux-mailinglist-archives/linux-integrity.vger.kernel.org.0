Return-Path: <linux-integrity+bounces-275-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504AD7FC230
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9F0282AD8
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2AC3D0B3;
	Tue, 28 Nov 2023 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E33b+/NU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA03430F0
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:22 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHY02p012654
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K2OSIIWeR+/mVCpZD6SxIqXKHERmaQICjyFMubPt4pk=;
 b=E33b+/NUSl/HBx1neyf+uchtvn20ujevgxFEbLo8wQnOvTJ6dRwExJhyOzrKRdCRJglt
 iGT4YucgFA0At/fWgJRxOyNQ1wVSyXc9NXD4UpVcDS3uq6qyfL9VsBvcSVnjUXkHa8RM
 IAcseqK51b28sqMG39FCJoEtCtaL7wwT0oyFEKxFyIA2QItTsojISiW1jnrkuZoQ8n3V
 JBp8lQ9kcMkwd1Jwksr4L74CKv3NMmnljXjp9h4+6BfzEhSn8kiB0g/Sq0f+RfAMGPnu
 xyzwOhihJr6GHHBmoQMs0IARP23ypGoQZwQFkFj5j8VwVNDoBfBJlbY4zsSjb65Hu1j7 3g== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unmq9h804-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG0Hik018242
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1s2qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGKPQ34210242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FE55805E;
	Tue, 28 Nov 2023 18:16:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24AE458051;
	Tue, 28 Nov 2023 18:16:20 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 13/14] tests: Address issues raised by shellcheck SC2295
Date: Tue, 28 Nov 2023 13:16:11 -0500
Message-ID: <20231128181613.1159958-14-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: W6tE7mGhawyTjg6XHA0eIZK_jJ8bZSVz
X-Proofpoint-GUID: W6tE7mGhawyTjg6XHA0eIZK_jJ8bZSVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=970 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

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


