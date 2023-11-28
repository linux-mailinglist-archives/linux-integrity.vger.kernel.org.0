Return-Path: <linux-integrity+bounces-271-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32B17FC226
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1E51C20D16
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261B3D0AC;
	Tue, 28 Nov 2023 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tSQAgh6x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266BF30E8
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:21 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASIAe73000720
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VGoSwG1/4hdiKBk6J2M99Mh8aeFeMRtUXlCTt018fmw=;
 b=tSQAgh6x6nfFNsM81t0ZjwwSJSthLSnJHo6pTn5DSB3F8h/76y3fzd76rfL9AqNXpqgP
 bCJLkVLGX6di9q548sMaj5M5pZjCYRYzWq9JvYDeC++up1baniOKRZQesdY6t5gVBnDQ
 jWu+Th0GsP9tsrhJx8jQJqm45beJjt+sIDURprhhj3k+v8f/7W563xqpvvygJxKcQCcV
 /cQ0yObifNhKl4IXoN9FHbe2x2z+724Blo16gYTQY6iWkGupzJKMJo6MYkScAGZYphg8
 VsqjWF3SZagQsuEQ5M15eJK8UwFMkmx4Yf6g7VMLZ9pQx6hYxKSdppsCR9/Scumiq+SG 5w== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unn8k88bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG0QJr027615
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukumyhs3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:19 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGIS046006710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B97558051;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 205535805A;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 08/14] tests: Address issues raised by shellcheck SC2166
Date: Tue, 28 Nov 2023 13:16:06 -0500
Message-ID: <20231128181613.1159958-9-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gqj8OIW3sXJLD1x9Dx7nqX3SgxGcMuyG
X-Proofpoint-GUID: gqj8OIW3sXJLD1x9Dx7nqX3SgxGcMuyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=975 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280146

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


