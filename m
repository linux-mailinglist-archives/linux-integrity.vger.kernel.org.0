Return-Path: <linux-integrity+bounces-11-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2687E83A7
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2B51C20AA7
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FF13B7A7;
	Fri, 10 Nov 2023 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e6Cck0cH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2093B7A5
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:50 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830DD3A99
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:48 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKFISo001086;
	Fri, 10 Nov 2023 20:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lxFOaKWhNFHhc/tATjy0VzJyvDQ7LPmxBJXDNhQXu/o=;
 b=e6Cck0cHO6wV8dKhkNCwSiAh0iU9ZOAkriY/1HQLgILaNVtkyzya+bO/jkes5hxSmem1
 jeXuBQeKP8maGHvwdZD9cAj2nks0OVqs6RngoeOFy+laXZ9cjZ6zXAcytO4jCgs8wlxf
 YvtYJw5U8LfsUINwCWtjKI1Tdkt1eb+55nMeBu5w5sRrCwfDvWFmnI3GEWb5aykd5T26
 QrILCETEcvtnfqGjv8IY1afYtKntC2rPdimH15a5qKYVmrxCAZDy2XJ7BqApUAPnWebn
 kaPcojFbOiLTMG1Z6SePvjHXBF9ftbNE7TDkxdwglEKv0eQNiex2n8zv8CW8oozhbZXj 1Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9ud586wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:44 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJ4mJE004176;
	Fri, 10 Nov 2023 20:21:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21dd4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLhbI20775616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44EC958058;
	Fri, 10 Nov 2023 20:21:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E770658057;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 09/14] tests: Address issues raised by shellcheck SC2294
Date: Fri, 10 Nov 2023 15:21:32 -0500
Message-ID: <20231110202137.3978820-10-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: dSS4XsToxOKqxBv2ABAVpv5aDx-qpk0p
X-Proofpoint-ORIG-GUID: dSS4XsToxOKqxBv2ABAVpv5aDx-qpk0p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=964 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100170

Address issues raised by shellcheck SC2294:
  "eval negates the benefit of arrays. Drop eval to preserve
   whitespace/symbols (or eval as string)."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am | 4 +++-
 tests/gen-keys.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index daddd0d..81f2d27 100644
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
2.41.0


