Return-Path: <linux-integrity+bounces-268-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7467FC21E
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B191F20FA4
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711D3D0A3;
	Tue, 28 Nov 2023 18:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vv/ADVsm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06E30E1
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:20 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI2aP9023992
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=afKzOp+VwXEGQXo8IEKvT21i3Iigfp751lGuZrymG44=;
 b=Vv/ADVsmYx2HU1aYi5esCxKVtm3UW531vVnG6DQDjAS2VLAL5x16Q6DoBrKM2OwGawrM
 QMZmO1EFPGNq+bNU2F9l7QwKQObjNmqzk6eclOEn11gZdMQqc6v2goCGw3de8pLjxVCi
 BUpTaWreylukTfcNBiUtJt4sKZzCSk3Wembn9OIRH4JXB88iBomP8ETgUvTAp7BeuCzv
 48dtu+EbqSqRr0fMHT4zTsLkHtHEyBHKAOn+H71AoxnAWeUpVP1R4GzKLr603CDiaZAs
 NHFGec4XO/GdMincr7i3ZEbYzb4kyC3Fo8TcUyycJEDEXY2M0HdY6QYqFSn9I+kP2nd+ 3A== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unn4p8f1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG5NmY027644
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyhs3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGHYM918180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BE2B58051;
	Tue, 28 Nov 2023 18:16:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00ED15805A;
	Tue, 28 Nov 2023 18:16:17 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:16 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 05/14] tests: Address issues raised by shellcheck SC2317
Date: Tue, 28 Nov 2023 13:16:03 -0500
Message-ID: <20231128181613.1159958-6-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: I6gPQtwGsJj_36X7I9wlHrK1Hf5Yioua
X-Proofpoint-ORIG-GUID: I6gPQtwGsJj_36X7I9wlHrK1Hf5Yioua
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Address issues raised by shellcheck SC2317:
  "Command appears to be unreachable. Check usage (or ignore if invoked
   indirectly)."

Disable this check in fsverity.test since functions are called
indirectly there.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am   | 2 +-
 tests/fsverity.test | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 3713771..e2fcb16 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046,SC2320 \
+	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/fsverity.test b/tests/fsverity.test
index 2b338ca..ddd6993 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -29,6 +29,8 @@
 # since the policy rules are walked sequentially, the system's IMA
 # custom policy rules might take precedence.
 
+# shellcheck disable=SC2317
+
 cd "$(dirname "$0")" || exit 1
 PATH=../src:../fsverity-utils:/usr/sbin:$PATH
 source ./functions.sh
-- 
2.43.0


