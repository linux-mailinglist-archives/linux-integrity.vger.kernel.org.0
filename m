Return-Path: <linux-integrity+bounces-10-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8187E83A8
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D0B1F20CA1
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EEC3B798;
	Fri, 10 Nov 2023 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QJYYIBqC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC13B7AD
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:51 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C92469A
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:49 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKGuqd022765;
	Fri, 10 Nov 2023 20:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fWNpVsHO/PVuAOL/S0Mm6vQAub1wC+L6XH0/ozRK0U8=;
 b=QJYYIBqCydzaSpjWAw89Wzdp9Ww/6Q4o/1gQ7alvI8vS5DdhGhxxnVZWOtelCG4hPnn1
 x1IvLzT2ZOPAAXAkl73ZB8QA/lJhBwbj8vnmG0aQxez23ZViweqNuUbpK6IHUIRp3tNH
 R/IlZa6BggFlVFa7sh0J8JyDiEIrWbAMK3uWfFzZ4PXz0ZBf9Jjyzxymy/GuwQMtB6c0
 ByaNW+f1Uk/SLQYd2n6s6YqhjtPqMc4dgNXSESM31BJhuKFgCKJ1mBW3gOog3M/IUR1F
 Dd8puF2n0Alu6LK7oW0DB3sLZtlYFtqpUTIOa/OJUr0bh5yT8cpbS600MQbBtguGhn0t TQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9udp03nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJaawH019286;
	Fri, 10 Nov 2023 20:21:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w24dcq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:44 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLiGN48628392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F76758058;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C21A858057;
	Fri, 10 Nov 2023 20:21:43 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:43 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 11/14] tests: Address issues raised by shellcheck SC2196
Date: Fri, 10 Nov 2023 15:21:34 -0500
Message-ID: <20231110202137.3978820-12-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: JmxtmjY64ddaZopJOtDoRUmMEC_cAtkz
X-Proofpoint-GUID: JmxtmjY64ddaZopJOtDoRUmMEC_cAtkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=957
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100170

Address issues raised by shellcheck SC2196:
  "egrep is non-standard and deprecated. Use grep -E instead."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am  | 2 +-
 tests/functions.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index cd3dd89..5de1dfb 100644
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
index 66766ba..f56dc52 100755
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
2.41.0


