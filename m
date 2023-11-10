Return-Path: <linux-integrity+bounces-7-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26097E83A2
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DA628136E
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704013B7B0;
	Fri, 10 Nov 2023 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SR6fapni"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0473B796
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:50 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05293A9F
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:48 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJlcvh008892;
	Fri, 10 Nov 2023 20:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vPKMllWBMv9EhZMJbHk5NfrlIlxtDmxL83EU4sHUdns=;
 b=SR6fapniAdXB1mZe/b/xOXtVuJ+cAWInnIVXN3Gzf/xzvEPnFbUNrquCBpktsEPWwQkD
 WkKNhIUdhyyi5tYgOgjKsgY8wR5Gv5bc0dfp9OagyyFCMkyIxfuW11wMD5A0smQTGWK2
 wvoi9wicJDFnx6FfZzvTB/0GJbd5cTKfYsQ8Hb/w5hlVbbEnrfLwr98nzF7MiFq8c5sY
 MXnBilxlCtbIyJ3jSveg6TAQ35E7Xtfy5f4omDf5P5IMjfChcjQoJgejgj0SvL314GDv
 gywU5HMWjNIftf5n3+NPQSBF5JVaMT9B/JhKXENVwZ+XwYhbao+NXDtDSU9W7lH/kHjs dQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9tyy8w10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:43 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAIsBD2019248;
	Fri, 10 Nov 2023 20:21:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w24dcpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLgjM21168782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CF6258059;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8CFE58058;
	Fri, 10 Nov 2023 20:21:41 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:41 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 06/14] tests: Address issues raised by shellcheck SC2034
Date: Fri, 10 Nov 2023 15:21:29 -0500
Message-ID: <20231110202137.3978820-7-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: RXDZ9Rek1_m3ncG4ixEWOhVVR7CqO9cb
X-Proofpoint-ORIG-GUID: RXDZ9Rek1_m3ncG4ixEWOhVVR7CqO9cb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=951 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100171

Address issues raised by shellcheck SC2034:
  "foo appears unused. Verify it or export it."

Export PKCS11_KEYURI in a separate statement to avoid the following
shellcheck issue:

  SC2155 (warning): Declare and assign separately to avoid masking
                    return values.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am     | 2 +-
 tests/functions.sh    | 1 +
 tests/mmap_check.test | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index d6d0068..2c86ba8 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317 \
+	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/functions.sh b/tests/functions.sh
index 86e6597..66766ba 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -371,6 +371,7 @@ _softhsm_setup() {
   if msg=$(./softhsm_setup setup 2>&1); then
     echo "softhsm_setup setup succeeded: $msg"
     PKCS11_KEYURI=$(echo "$msg" | sed -n 's|^keyuri: \(.*\)|\1|p')
+    export PKCS11_KEYURI
 
     export EVMCTL_ENGINE="--engine pkcs11"
     export OPENSSL_ENGINE="-engine pkcs11"
diff --git a/tests/mmap_check.test b/tests/mmap_check.test
index 3d2e1b1..ecca066 100755
--- a/tests/mmap_check.test
+++ b/tests/mmap_check.test
@@ -5,6 +5,8 @@
 #
 # Check the behavior of MMAP_CHECK and MMAP_CHECK_REQPROT
 
+# shellcheck disable=SC2034
+
 trap '_report_exit_and_cleanup _cleanup_env cleanup' SIGINT SIGTERM SIGSEGV EXIT
 
 PATCHES=(
-- 
2.41.0


