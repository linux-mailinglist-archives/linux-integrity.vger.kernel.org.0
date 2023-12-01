Return-Path: <linux-integrity+bounces-317-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C570B800C35
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB55B20EDC
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9D0364C0;
	Fri,  1 Dec 2023 13:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P/5/jmqW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45375170E
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:57 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DCLu2031370
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MY0XxR1i2Uz5rXjsDP4/3t/rVNVP+DFyDGF055k7bZo=;
 b=P/5/jmqWgjsKoGvYTN9N+biDb+HiladU+xms1MMs5oGQAhnnTV1YtHGsWFDhdkYxNZv4
 pW7W8g5m19QzRPid6ufxNl4UczJbLhwPCBJ/V2iG3/MGd4kPZvQ+hAzM6UDwmdiGV27o
 XF/SM55LY69trA0ZuHs1jnA+PBTPBI2J71OT2iRivhc918pnncFiHznplDMkqSzs4amm
 YYRmcwkUPwxqN4AFWJBHsEjag1Ikukk6PmUaQ2k/BmcERsRc+nRBuB46Ctberg7iPb7W
 xiH1r/s2ZrX2LMsHOnOCmnT5zhwNzOLm77DdWVxWFTwTst9DwZIhp+AGXeWE35NKFcg9 +w== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqg5pgfkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AY30O000744
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8tnhfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVrY319727026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C43A75805A;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C54558052;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 09/14] tests: Address issues raised by shellcheck SC2294
Date: Fri,  1 Dec 2023 08:31:31 -0500
Message-ID: <20231201133136.2124147-10-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: 6PeXV3cA8scsOQKjDQ0tzQD6oKYxRDVk
X-Proofpoint-ORIG-GUID: 6PeXV3cA8scsOQKjDQ0tzQD6oKYxRDVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010092

Address issues raised by shellcheck SC2294:
  "eval negates the benefit of arrays. Drop eval to preserve
   whitespace/symbols (or eval as string)."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am | 4 +++-
 tests/gen-keys.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index df1fbff..9092c43 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,9 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
+	shellcheck \
+		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
+		-i SC2294 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 0b03ba4..c3d5a20 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -21,7 +21,7 @@ type openssl
 
 log() {
   echo >&2 - "$*"
-  eval "$@"
+  eval "$*"
 }
 
 if [ "$1" = clean ]; then
-- 
2.43.0


