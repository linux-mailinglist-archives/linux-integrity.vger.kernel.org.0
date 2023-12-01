Return-Path: <linux-integrity+bounces-319-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F649800C36
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2AE281CCD
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B5838F9C;
	Fri,  1 Dec 2023 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="adUwKPnR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BFF1711
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:57 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DCNDr004570
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PvRr2WMpQ+NEW4x9VXN+i9Zw+jCaHaoQWacHjjMi3tM=;
 b=adUwKPnRweINNiigU7zJX5zV1yH6sdnIFfddHGeC0SoUrD4EX/Mtit2r+Xvw3fj5EhZJ
 UYC6BsWLkDcG1CdjnoyYsB2GQkBeXuhGCe0CHdhAKE/cJTkzNNKuYgSHy69YJnG+AsZe
 X8iw2ZF/0DOMuayiebjgVbFDbxf5f5nEo7WXbCnU6P65SB1dL94x3WGO8fTIkHUfsIqK
 4bcNbJzHe6Lg9VBgWnU+kH+Z7koS4oZ6tuBqhfh6SCPXlbsgHrB9686LoyKzZd/8AsJB
 6ZyZzwa96HqYgFwtxdh6JmijHZTlpHJ5qL2Lsw2bQwsLiJ2leQFDGt7/EcGsvpAcpvrQ wg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqg5qrjgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:57 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXof9006365
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfkmuy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVsiX16188022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AF6558062;
	Fri,  1 Dec 2023 13:31:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 433525805E;
	Fri,  1 Dec 2023 13:31:54 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:54 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 11/14] tests: Address issues raised by shellcheck SC2196
Date: Fri,  1 Dec 2023 08:31:33 -0500
Message-ID: <20231201133136.2124147-12-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: J3gcA06gBaCaq6dHzbFoOvTs1Ncirvjb
X-Proofpoint-ORIG-GUID: J3gcA06gBaCaq6dHzbFoOvTs1Ncirvjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=998 malwarescore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010092

Address issues raised by shellcheck SC2196:
  "egrep is non-standard and deprecated. Use grep -E instead."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am  | 2 +-
 tests/functions.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index cbf637c..3c542d7 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -28,7 +28,7 @@ distclean: distclean-keys
 shellcheck:
 	shellcheck \
 		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
-		-i SC2294,SC2206 \
+		-i SC2294,SC2206,SC2196 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/functions.sh b/tests/functions.sh
index 4ad61ef..c39b894 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -272,7 +272,7 @@ _test_xattr() {
   local file=$1 attr=$2 prefix=$3
   local text_for=${ADD_TEXT_FOR:+ for $ADD_TEXT_FOR}
 
-  if ! getfattr -n "$attr" -e hex "$file" | egrep -qx "$attr=$prefix"; then
+  if ! getfattr -n "$attr" -e hex "$file" | grep -qx -E "$attr=$prefix"; then
     color_red_on_failure
     echo "Did not find expected hash$text_for:"
     echo "    $attr=$prefix"
-- 
2.43.0


