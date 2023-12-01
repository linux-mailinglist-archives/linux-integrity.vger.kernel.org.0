Return-Path: <linux-integrity+bounces-321-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62731800C3A
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA89B2142B
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845F03AC29;
	Fri,  1 Dec 2023 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rh4U7Z/5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF6E131
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:32:01 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DMSU7011179;
	Fri, 1 Dec 2023 13:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ShLPU8A563ho3ExyzSyndBdAsqcrd38OTJBacAHnOiA=;
 b=Rh4U7Z/5VrXfCy49PZ+UoVa44HcFKGIN/9Vk8QJVdT7B1dcb/1Hnqgf7QFx1YzevJT9m
 60S0qBzYgE8FOMvJzeGOoGn1A4YI3VbMQTIIwMcWmaQauqHtrRPD7VYPea+jlhWB9wKT
 UmAPO/edWHdM8cpVISGChGIEsiYg7abiUgQqpuAEdoKRLpjiRaUcD1p/HIEV18cJr6Rm
 BP9kxi4xz6EoSdzgi/jPEN7yBCk/BWgjoLLcKRIFTefIAPiJKfUOiy0DB5yVV9Cq0FPW
 h+3xEbdfDz6xcZ0uu0NMqfHhiQM/54/TJMqWngZqs2qvaawq6PIYT6JkIKPKyfZing7Y bw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqgad09ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 13:31:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXwSC020432;
	Fri, 1 Dec 2023 13:31:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukvrm53km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 13:31:56 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVtlT14484132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E3975805E;
	Fri,  1 Dec 2023 13:31:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F28758063;
	Fri,  1 Dec 2023 13:31:55 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:55 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [ima-evm-utils PATCH v3 14/14] tests: Address issues raised by shellcheck SC2003
Date: Fri,  1 Dec 2023 08:31:36 -0500
Message-ID: <20231201133136.2124147-15-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: ziMFZ-cqcI-3PqKP__5nIf2G5aY4bRLk
X-Proofpoint-ORIG-GUID: ziMFZ-cqcI-3PqKP__5nIf2G5aY4bRLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010092

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
index 7b3d92b..a95c4d2 100644
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
index 7ddd149..10b0ad8 100755
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
2.43.0


