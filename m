Return-Path: <linux-integrity+bounces-316-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015F800C30
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 14:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2995F1C21109
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Dec 2023 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B43B7B5;
	Fri,  1 Dec 2023 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ab7+ifPJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4591700
	for <linux-integrity@vger.kernel.org>; Fri,  1 Dec 2023 05:31:57 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DRRUJ002094
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VGoSwG1/4hdiKBk6J2M99Mh8aeFeMRtUXlCTt018fmw=;
 b=ab7+ifPJXrpnCTrf8+862gC6yxpDNd9QTYCoxTYrcW1zdJ4gM5vZLxIch+xbtUz9wvL3
 WMbdXlSSD+I+/dGFIAOW1Ja3MVkVcbjVZG3H97BcrtRQKzARgwXvgVmN7Dd0moSsajp4
 8nDMLc+2KUOWY99CY7fGIH3g5YfVqRIjHYSxspDhSSfNCHfefDEB+QM4Jds7Y8mo2WGk
 E0xAx859Y7qKa8gBbDX30i4hyfWWDyPXNYiTRbMDdW6cKETVF7/PEAJW+n6yZ7LJO0oE
 0LL8iBKKJm91SlM5Ai/D6oKjMOxykhG7MR+sh3WmMxWQZmmseDuLVmua459v1Xn3NNBD nw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqgcqr4wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1AXs1Q017343
	for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2023 13:31:54 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy2cqgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2023 13:31:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1DVrVt19727024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 13:31:53 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67D575805A;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F0D258052;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 13:31:53 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 08/14] tests: Address issues raised by shellcheck SC2166
Date: Fri,  1 Dec 2023 08:31:30 -0500
Message-ID: <20231201133136.2124147-9-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: t9jvyM1CHzT7q7CXPvebTSI9FdBi-fHO
X-Proofpoint-ORIG-GUID: t9jvyM1CHzT7q7CXPvebTSI9FdBi-fHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_11,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=973
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010092

Address issues raised by shellcheck SC2166:
  "Prefer [ p ] && [ q ] as [ p -a q ] is not well defined."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am   | 2 +-
 tests/softhsm_setup | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index c5b2a2f..df1fbff 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -26,7 +26,7 @@ clean-local:
 distclean: distclean-keys
 
 shellcheck:
-	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164 \
+	shellcheck -i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/softhsm_setup b/tests/softhsm_setup
index 6f8a74e..fc33596 100755
--- a/tests/softhsm_setup
+++ b/tests/softhsm_setup
@@ -15,7 +15,7 @@ fi
 
 MAJOR=$(softhsm2-util -v | cut -d '.' -f1)
 MINOR=$(softhsm2-util -v | cut -d '.' -f2)
-if [ "${MAJOR}" -lt 2 ] || [ "${MAJOR}" -eq 2 -a "${MINOR}" -lt 2 ]; then
+if [[ "${MAJOR}" -lt 2 || ( "${MAJOR}" -eq 2  && "${MINOR}" -lt 2 ) ]]; then
 	echo "Need softhsm v2.2.0 or later"
 	exit 77
 fi
-- 
2.43.0


