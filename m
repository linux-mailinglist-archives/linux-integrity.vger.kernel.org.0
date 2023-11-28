Return-Path: <linux-integrity+bounces-266-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50477FC224
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345EFB20EBE
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B170239AEC;
	Tue, 28 Nov 2023 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmH+Cphz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F030DF
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:20 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI2fEB024466
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jkZXqzpbssUnC0OA2mkXDPMADTo5mcz1OocVz0zMBhE=;
 b=rmH+CphzPBpsb0XU5UYlnU0ghCMUmthA54SWQKqGdSEIJ92hb4vRuVhPCubS/HCS1ozZ
 O9FmOC9e4KOPLZBjG+sWlVBJIcqLrbU9APXb4TVhX1trd05+JeXzbmodgkTs8ecI3YZG
 PMdB0cfPXvLTAX1ikCBZEL6My2BtwZHTGCzcx5GthcaL7asxuZJQ+nqcN3X1Cb6liXAH
 jBAky6YUMzM1sKnv8KK+M/RqNIeqcNAEj1CC/Z3kNIdev1u2ubOU23rkL5DCQ4Mfbth0
 JaQoqxIUiEo0w6S3bQ0OnYwLlTzbj8vQ9+573D2DJzXAIZcGwjB9oQQggjJQdPN8QXTD 4g== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unn4p8f18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFshtg012193
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrkhf2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:17 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGGFn2884326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDFFA5805C;
	Tue, 28 Nov 2023 18:16:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B90B5805A;
	Tue, 28 Nov 2023 18:16:16 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:16 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 04/14] tests: Address issues raised by shellcheck SC2320
Date: Tue, 28 Nov 2023 13:16:02 -0500
Message-ID: <20231128181613.1159958-5-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: JJR_Pn1MOSOmlv1hExDqXqH9hSUCt6Yq
X-Proofpoint-ORIG-GUID: JJR_Pn1MOSOmlv1hExDqXqH9hSUCt6Yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=998
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Address issues raised by shellcheck SC2320:
  "This $? refers to echo/printf, not a previous command.
   Assign to variable to avoid it being overwritten."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am              | 2 +-
 tests/mmap_check.test          | 8 +++-----
 tests/portable_signatures.test | 9 +++------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6fe18e4..3713771 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046 \
+	shellcheck -i SC2086,SC2181,SC2046,SC2320 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/mmap_check.test b/tests/mmap_check.test
index 2dd3433..e3e5c71 100755
--- a/tests/mmap_check.test
+++ b/tests/mmap_check.test
@@ -97,14 +97,12 @@ check_load_ima_rule() {
 
 	new_policy=$(mktemp -p "$g_mountpoint")
 	echo "$1" > "$new_policy"
-	echo "$new_policy" > /sys/kernel/security/ima/policy
-	result=$?
-	rm -f "$new_policy"
-
-	if [ "$result" -ne 0 ]; then
+	if ! echo "$new_policy" > /sys/kernel/security/ima/policy; then
+		rm -f "$new_policy"
 		echo "${RED}Failed to set IMA policy${NORM}"
 		return "$HARDFAIL"
 	fi
+	rm -f "$new_policy"
 
 	return "$OK"
 }
diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
index 9f3339b..7ddd149 100755
--- a/tests/portable_signatures.test
+++ b/tests/portable_signatures.test
@@ -80,7 +80,6 @@ METADATA_CHANGE_FOWNER_2=3002
 
 check_load_ima_rule() {
 	local rule_loaded
-	local result
 	local new_policy
 
 	rule_loaded=$(grep "$1" /sys/kernel/security/ima/policy)
@@ -88,14 +87,12 @@ check_load_ima_rule() {
 		new_policy=$(mktemp -p "$g_mountpoint")
 		echo "$1" > "$new_policy"
 		evmctl sign -o -a sha256 --imasig --key "$key_path" "$new_policy" &> /dev/null
-		echo "$new_policy" > /sys/kernel/security/ima/policy
-		result=$?
-		rm -f "$new_policy"
-
-		if [ "$result" -ne 0 ]; then
+		if ! echo "$new_policy" > /sys/kernel/security/ima/policy; then
+			rm -f "$new_policy"
 			echo "${RED}Failed to set IMA policy${NORM}"
 			return "$FAIL"
 		fi
+		rm -f "${new_policy}"
 	fi
 
 	return "$OK"
-- 
2.43.0


