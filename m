Return-Path: <linux-integrity+bounces-17-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86887E83B3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB01C20998
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEF938DDB;
	Fri, 10 Nov 2023 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="enWaXVQP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EC3AC2C
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:26:17 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C22D51
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:26:13 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKQ2Zl018332;
	Fri, 10 Nov 2023 20:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YlMj/lub72oGyBL4jGAuS1xTsZRJr+32ugkiMJymiu8=;
 b=enWaXVQPU9PcWoVEaMlh2m1OUHCHXge7rSnI2CBd63lZ0b1vSm+5nUr0sCC9FGvmouvp
 QC9pF2rndOhc143i78VF09zbqe/jq4ys9koEWB2urH60VLKlR9E43un7yfvNmyDtN+wr
 9qeSvSEs8UsDLG7UvtwaSylEzrPzaufajMZkhscRg6FyW3R1xCkDtBnAP9bXoNryKgiA
 NTWzo7DvXM9pn2uVuQn+3Kh2To7VIhkLKRirV3ZfL9HKp8Pwm0usnr4pVAIjSDyMW404
 mIMHijGgyjZ4Y42m3MjZPIESyls5l1mm52hoho+kCsFtX0gPI5FHUod3693QG8MU6UVl Dg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9udwr3s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:26:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJ2O88004124;
	Fri, 10 Nov 2023 20:21:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21dd4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLjo832375470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A7E558059;
	Fri, 10 Nov 2023 20:21:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0749E58057;
	Fri, 10 Nov 2023 20:21:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:44 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [ima-evm-utils PATCH 14/14] tests: Address issues raised by shellcheck SC2003
Date: Fri, 10 Nov 2023 15:21:37 -0500
Message-ID: <20231110202137.3978820-15-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 9JfzonUnCZid8xEBcVcp1tD0vbUYK8wP
X-Proofpoint-GUID: 9JfzonUnCZid8xEBcVcp1tD0vbUYK8wP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100171

Address issues detected by shellcheck SC2003:
  expr is antiquated. Consider rewriting this using $((..)), ${} or [[ ]].

The following statement in portable_signatures.test causes the issue:

  expr index "$TST_LIST" "check_evm_revalidate"

The man page for expr states:

       index STRING CHARS
              index in STRING where any CHARS is found, or 0

The intention is certainly not to find an index of any of the characters
in "check_evm_revalidate" in $TST_LIST but to find the word
"check_evm_revalidate" in $TST_LIST. Therefore, use grep -w to determine
whether the word is there.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
---
 tests/Makefile.am              | 2 --
 tests/portable_signatures.test | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index a5ee424..18b134c 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -27,8 +27,6 @@ distclean: distclean-keys
 
 shellcheck:
 	shellcheck \
-		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
-		-i SC2294,SC2206,SC2196,SC2043,SC2295 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
index 5251211..c6e2d99 100755
--- a/tests/portable_signatures.test
+++ b/tests/portable_signatures.test
@@ -1090,7 +1090,7 @@ if [ $((evm_value & EVM_INIT_X509)) -ne "$EVM_INIT_X509" ] && [ "$TST_EVM_CHANGE
 	echo "$EVM_INIT_X509" > /sys/kernel/security/evm 2> /dev/null
 fi
 
-if [ "$(expr index "$TST_LIST" "check_evm_revalidate")" -gt 0 ] && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
+if echo "$TST_LIST" | grep -q -w check_evm_revalidate && [ "$TST_EVM_CHANGE_MODE" -eq 1 ]; then
 	echo "$EVM_ALLOW_METADATA_WRITES" > /sys/kernel/security/evm 2> /dev/null
 fi
 
-- 
2.41.0


