Return-Path: <linux-integrity+bounces-9-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D117E83A5
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E9B281289
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC853B7B7;
	Fri, 10 Nov 2023 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T+zabnXk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CB3B798
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:50 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEA44B3
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:49 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJlcvi008892;
	Fri, 10 Nov 2023 20:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YHxiH+11atUrTFieddbFDrugkUOi3YwzCgHZ68+kqYc=;
 b=T+zabnXkRh6/Mpp+b6XiXlUVEYnj15w8x7eY0urOvVKYT6u7mltvd0SUq2dXvRrKjwdP
 Its8YBR+Fq3BgpHuZ1dGZSjk1pfixv4MxZ9/OPU0K8xaoBfsHNzEgG2bE+vVlT/n615f
 iMLeMj/wLEs7OUwo7maVrfIKpxzLOb4zR6Nf+9P6t09cJBrTWRpSQlyxsppSyhuCv1IB
 Z5CxzvEUKTibonr+EqpckqT79ZdQzFooqEfoL0oYpM146m38uBLFqf5dAfcfPCvkdGMV
 qBbfAb60bGlg++0j12Q5jRwZiSnn0UVyAKDdr3V2oT6E9yIrsLgEGLJ9wSPz8pGCgvt5 KQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9tyy8w1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJ0Op5003424;
	Fri, 10 Nov 2023 20:21:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w22dcqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLjDt46138008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E589158058;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D07558057;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 13/14] tests: Address issues raised by shellcheck SC2295
Date: Fri, 10 Nov 2023 15:21:36 -0500
Message-ID: <20231110202137.3978820-14-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110202137.3978820-1-stefanb@linux.ibm.com>
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VNCN_sRZtnyuCGkZYiuvpdkf95q7vT43
X-Proofpoint-ORIG-GUID: VNCN_sRZtnyuCGkZYiuvpdkf95q7vT43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=929 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100171

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
index 653e4dd..a5ee424 100644
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
index e924162..bfb0a5c 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -166,7 +166,7 @@ unqualified_bprm_rule() {
 	local rule_match="measure func=BPRM_CHECK"
 	local rule_dontmatch="fsuuid"
 
-	if [ -z "${rule##*$digest_type=verity*}" ]; then
+	if [ -z "${rule##*digest_type=verity*}" ]; then
 		if grep "$rule_match" $IMA_POLICY_FILE | grep -v "$rule_dontmatch"  &> /dev/null; then
 			return "$SKIP"
 		fi
-- 
2.41.0


