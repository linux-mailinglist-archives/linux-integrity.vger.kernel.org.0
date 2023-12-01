Return-Path: <linux-integrity+bounces-310-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BDA800C2D
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E8E1C20EF2
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3D3B293;
	Fri,  1 Dec 2023 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DISMloun"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0218E131
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:54 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DH0r6021627
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=afKzOp+VwXEGQXo8IEKvT21i3Iigfp751lGuZrymG44=;
 b=DISMlounoAYYbQFF9W21MVMhbO9RRnx/LaEXMfXEdIL+ZbfPV8BTB9fpGwopCvHzexdj
 p00cee45Se8/WfIEGT2gYkrkSXFphTFgCP14utq2D7xNJ+pwOiYGY38GSdrrp13XTHFy
 Hr4l0TnvK9WytjM0MB3tBOILiNpthp7k17WOteRwgfHc815X+BOkxUkWmbsOZHNN64Nj
 9zSM9PPdW8VZVX69c0DaI9gogLSJuYTshRdfIyT51NyoARXYFDNgX5nv22nKbAS5msDP
 OMEyK6BBxeo6TJWM7KwJQR5sJMRXhXZYMb8JW1rCeMYdw7AvlutUHwbQaFtRWPzENZSb 3g== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqg828f86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXsxR002615
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:53 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8p57rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVqNf11338336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 543D25805E;
	Fri,  1 Dec 2023 13:31:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C9785805A;
	Fri,  1 Dec 2023 13:31:52 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:51 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 05/14] tests: Address issues raised by shellcheck SC2317
Date: Fri,  1 Dec 2023 08:31:27 -0500
Message-ID: <20231201133136.2124147-6-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: 1cyYO2YydYwvv4rHqGgid4jI-6SJTkGy
X-Proofpoint-ORIG-GUID: 1cyYO2YydYwvv4rHqGgid4jI-6SJTkGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010092

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


