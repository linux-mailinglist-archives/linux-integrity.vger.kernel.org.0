Return-Path: <linux-integrity+bounces-4-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862287E83A0
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69571C2097B
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB63B791;
	Fri, 10 Nov 2023 20:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CMqfNR0r"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35233B2A9
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:47 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8771732
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:46 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKHRoW020759;
	Fri, 10 Nov 2023 20:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+2rZEPMAQFj+AunMdhU9QwFlTsBewfcZFVT7NgDnMVU=;
 b=CMqfNR0r1VlvHGXu/uhTXsCbWDrkWUWBBXGLtgfHbKlNcI5suZvNzU1yN7ROgCImSzrD
 1rz6ADhd9fwazRTTSNRMytz/Bs9h00r/vRxc962PPQCB5nuryNBWjmJilOADl1yPqzQi
 iTPAOk/QaJogDBpe5SiGSw/Cx2OWuntRkTLOP9ilXb3r7TSbgG4Smis1+MiVRloYMCOI
 CLqDVakhyDO3faAuZ3acZqsbzoI6c3nYqxsqe60WOTxH4T4C33L2vf4hIR9G3qEpwDir
 ujkqpzdn3zf+xSYYOHHhR4ugtqaNWrBs2KMWArMq9yYoz0vvO73deoiJALkkUXMufYSv CQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9ue0g3ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJMjlx019429;
	Fri, 10 Nov 2023 20:21:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w24dcpk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLfDW8651290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C3A858057;
	Fri, 10 Nov 2023 20:21:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E804558059;
	Fri, 10 Nov 2023 20:21:40 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:40 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 04/14] tests: Address issues raised by shellcheck SC2320
Date: Fri, 10 Nov 2023 15:21:27 -0500
Message-ID: <20231110202137.3978820-5-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: oA_tKu2FG21X4bOhz9FgoXuyZONhPhRc
X-Proofpoint-GUID: oA_tKu2FG21X4bOhz9FgoXuyZONhPhRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100171

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
index bcc1ee4..babfa7a 100644
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
index 2dd3433..3d2e1b1 100755
--- a/tests/mmap_check.test
+++ b/tests/mmap_check.test
@@ -97,11 +97,9 @@ check_load_ima_rule() {
 
 	new_policy=$(mktemp -p "$g_mountpoint")
 	echo "$1" > "$new_policy"
-	echo "$new_policy" > /sys/kernel/security/ima/policy
-	result=$?
-	rm -f "$new_policy"
-
-	if [ "$result" -ne 0 ]; then
+	if echo "$new_policy" > /sys/kernel/security/ima/policy; then
+		rm -f "$new_policy"
+	else
 		echo "${RED}Failed to set IMA policy${NORM}"
 		return "$HARDFAIL"
 	fi
diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
index 9f3339b..5251211 100755
--- a/tests/portable_signatures.test
+++ b/tests/portable_signatures.test
@@ -80,7 +80,6 @@ METADATA_CHANGE_FOWNER_2=3002
 
 check_load_ima_rule() {
 	local rule_loaded
-	local result
 	local new_policy
 
 	rule_loaded=$(grep "$1" /sys/kernel/security/ima/policy)
@@ -88,11 +87,9 @@ check_load_ima_rule() {
 		new_policy=$(mktemp -p "$g_mountpoint")
 		echo "$1" > "$new_policy"
 		evmctl sign -o -a sha256 --imasig --key "$key_path" "$new_policy" &> /dev/null
-		echo "$new_policy" > /sys/kernel/security/ima/policy
-		result=$?
-		rm -f "$new_policy"
-
-		if [ "$result" -ne 0 ]; then
+		if echo "$new_policy" > /sys/kernel/security/ima/policy; then
+			rm -f "$new_policy"
+		else
 			echo "${RED}Failed to set IMA policy${NORM}"
 			return "$FAIL"
 		fi
-- 
2.41.0


