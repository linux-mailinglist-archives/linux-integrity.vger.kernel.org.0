Return-Path: <linux-integrity+bounces-14-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4137E83AB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 21:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A3D2812FB
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Nov 2023 20:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF773B785;
	Fri, 10 Nov 2023 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lMEEmzzG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A33B794
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 20:21:52 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6E51732
	for <linux-integrity@vger.kernel.org>; Fri, 10 Nov 2023 12:21:51 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAKGxIA022850;
	Fri, 10 Nov 2023 20:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xfJnEGmOx8A+rV107lXUasDYNfRxN0OPwk6YLsCcgTg=;
 b=lMEEmzzGM27K/e3acpIuI2kQdbQZEMgwhkkU2UiNJxjOBwruaHP8Piq+cVbgHpOHCof5
 M01pjXXjLOAUE+kMz4RqhFe/3HUJWgHtghcvvL8ARLUELFDOTQLQ9QxNScKKXenHfz1C
 1p3OGWIM+IySClBTml8nMmjMH2JWYXvXdCjB8l7h57IrrRnvdZUN0GelkAEHhcFsw2fq
 Gl1DYHZgjzYImfvejAm+i0/uIBrnBGOCr42fXCS4RQSdICjE58GnI2jPy48qNkRcjw8E
 uEmNZCpsuS3stJu7bnDvagoAgzlGx7vW2p7PttpyVuoiD6aINRlTwvpCUMJEg5OCCNgb eg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9udp03nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:44 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAJCIOQ014325;
	Fri, 10 Nov 2023 20:21:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22de83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 20:21:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AAKLg2F63570210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Nov 2023 20:21:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D18A95805D;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8040058057;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Nov 2023 20:21:42 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 08/14] tests: Address issues raised by shellcheck SC2166
Date: Fri, 10 Nov 2023 15:21:31 -0500
Message-ID: <20231110202137.3978820-9-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vXWgATNGKmmyn6wGlrGGRLzkcy8PaFxA
X-Proofpoint-GUID: vXWgATNGKmmyn6wGlrGGRLzkcy8PaFxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=935
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311100170

Address issues raised by shellcheck SC2166:
  "Prefer [ p ] && [ q ] as [ p -a q ] is not well defined."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am   | 2 +-
 tests/softhsm_setup | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index c3eeb43..daddd0d 100644
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
2.41.0


