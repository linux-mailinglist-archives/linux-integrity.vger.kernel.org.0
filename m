Return-Path: <linux-integrity+bounces-277-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B897FC232
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483A2282B7E
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Nov 2023 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592C3D0B8;
	Tue, 28 Nov 2023 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZNQpp1C6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33AA30F1
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 10:16:22 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASIAdtK000674
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JHiDRhE1u083wRxbpYJTM1GLbDmSGh2BNNSLFCw1Yco=;
 b=ZNQpp1C6vEx5kgM9kIaIFI9HE8XfB4wYmmrY3JLrKFgken2US2E3swFH9hDR/94X5VxK
 z2/Ciy0payPcjJCi63QzPd5TTVHyW0S8GVlJXDP9J2dvzU8RJ8KC0PbKHrmqpK0rISJ9
 yRRF/xvtMusEepfTvZTqpXxzF2vUdSIBCfoNb+ossR6hwHF31M/BAMsF2mQXniPi12ej
 SzQNWeQjPt0Ki/9CnZcgGsnuChIRc8Mf9xpCJEogGuV2GvVOauFn15EKu9hjeTF9u++Z
 bkvyTJ4bE8O/Ow7Lc7abmfDN8b9idVOAKclBSUUBNGrUy0qA0P7EU9dxq4Cb4MZmjgJC 8g== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unn8k88c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASFw8nk004955
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk17pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 28 Nov 2023 18:16:20 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASIGKEH42861100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 18:16:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D2155805A;
	Tue, 28 Nov 2023 18:16:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B658958051;
	Tue, 28 Nov 2023 18:16:19 +0000 (GMT)
Received: from sbct-2.pok.ibm.com?044watson.ibm.com (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Nov 2023 18:16:19 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 12/14] tests: Address issues raised by shellcheck SC2043
Date: Tue, 28 Nov 2023 13:16:10 -0500
Message-ID: <20231128181613.1159958-13-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 5H7SeSlJnxA1JIf1R0K5a3n6DKNfBFZi
X-Proofpoint-GUID: 5H7SeSlJnxA1JIf1R0K5a3n6DKNfBFZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_20,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=883 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280146

Address issues raised by shellcheck SC2043:
  "This loop will only ever run once for a constant value. Did you
   perhaps mean to loop over dir/*, $var or $(cmd)?

Disable this check in gen-keys.sh to leave the loop alone.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am | 2 +-
 tests/gen-keys.sh | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 3c542d7..4ce71f4 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -28,7 +28,7 @@ distclean: distclean-keys
 shellcheck:
 	shellcheck \
 		-i SC2086,SC2181,SC2046,SC2320,SC2317,SC2034,SC2164,SC2166 \
-		-i SC2294,SC2206,SC2196 \
+		-i SC2294,SC2206,SC2196,SC2043 \
 		functions.sh gen-keys.sh install-fsverity.sh \
 		install-mount-idmapped.sh install-openssl3.sh \
 		install-swtpm.sh install-tss.sh softhsm_setup \
diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index c3d5a20..601ded2 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -15,6 +15,8 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
+# shellcheck disable=SC2043
+
 cd "$(dirname "$0")" || exit 1
 PATH=../src:$PATH
 type openssl
-- 
2.43.0


