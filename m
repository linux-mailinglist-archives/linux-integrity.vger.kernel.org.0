Return-Path: <linux-integrity+bounces-276-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7549D7FC23C
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5A2B21425
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F83D0B5;
	Tue, 28 Nov 2023 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P7uZ83tE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B4C30EF
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:22 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHlbKx022937
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PvRr2WMpQ+NEW4x9VXN+i9Zw+jCaHaoQWacHjjMi3tM=;
 b=P7uZ83tEAird+4nWXJyW8Q3JSFH4dkQG8/yZSZ6nzMNxkWuX6QGoa7S6mMEXNuys8IEe
 dLrB2ZdU2yTuFH2OXDLbEsZEoymHNFMMpUdZSIzqTpVK7EAF6BCuc2sVKAGJo7HD7O8z
 WIlCyw7SNPEukwbrDr6HAHKbpb6D4KaB4GpatJ0POUQdTbvaobhkA4Fr7iuNZt/AvWTa
 iMySvIJPnrPrgVAgvxm454iu1RSixrPfjP9o8kCku/F6mDZcbal/mhHV4xnvSmNj3fat
 JCCSVqGPZ9coMB+qTP8t6v08nnz4i0XmZCqQ4XfLjEmXl2dHPDxtbwbt9vdLFVI2OxcC dw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unmwg8tph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASIChcf004930
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk17p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGJgh14353116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F70B5805A;
	Tue, 28 Nov 2023 18:16:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5338158051;
	Tue, 28 Nov 2023 18:16:19 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 11/14] tests: Address issues raised by shellcheck SC2196
Date: Tue, 28 Nov 2023 13:16:09 -0500
Message-ID: <20231128181613.1159958-12-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: UtVZEJmzrr6RyDXF5knLcsc0mM_LY5in
X-Proofpoint-GUID: UtVZEJmzrr6RyDXF5knLcsc0mM_LY5in
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280146

Address issues raised by shellcheck SC2196:
  "egrep is non-standard and deprecated. Use grep -E instead."

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am  | 2 +-
 tests/functions.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index cbf637c..3c542d7 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -28,7 +28,7 @@ distclean: distclean-keys
 shellcheck:
 	shellcheck \
 		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
-		-i SC2294,SC2206 \
+		-i SC2294,SC2206,SC2196 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/functions.sh b/tests/functions.sh
index 4ad61ef..c39b894 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -272,7 +272,7 @@ _test_xattr() {
   local file=$1 attr=$2 prefix=$3
   local text_for=${ADD_TEXT_FOR:+ for $ADD_TEXT_FOR}
 
-  if ! getfattr -n "$attr" -e hex "$file" | egrep -qx "$attr=$prefix"; then
+  if ! getfattr -n "$attr" -e hex "$file" | grep -qx -E "$attr=$prefix"; then
     color_red_on_failure
     echo "Did not find expected hash$text_for:"
     echo "    $attr=$prefix"
-- 
2.43.0


