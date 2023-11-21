Return-Path: <linux-integrity+bounces-152-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C30A7F35CF
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 19:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C701C20D65
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 18:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB722090;
	Tue, 21 Nov 2023 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cUjDCpsH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE572F9
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 10:18:21 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALHMM0r015594
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 18:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=1MrusoKIPciVCKx1iaJFwPBn+4QmhccB142SevO1W2I=;
 b=cUjDCpsHdDboUiVbctphuwLZgj/eTx0lx4u8HKl8bv/I51YFX6BbHmwbFb5zD5Hr13iP
 Q0bQ0u1RlAdycuNWr2OhNW9egKm0fkxDWc6AsYPkZeAfWmlThqfRz3mKcuIWG15NI0b8
 HLHmVIoPfWwEg9PJysf7TGyoAIkY6hBHUoCK5TTtbYjZo+NiZ7q8TcwmDup5ttOSuggT
 DZW+3jdv6xPiJuoM8N1VDYFa/9ZNuIwqW/A6UekuX/KnFpHSuuNOKnRXoHWAtPQI900I
 zwf+5w49WZ+1xO3/bMFx6YaXS7e8uL8K8VHyU/Q2C2W+hB4T83//WxarRrLm+U+Wu7kq kQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh0vx979d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 18:18:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALGJ4NW010295
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 18:18:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tka7uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 18:18:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALIIJkl33227442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 18:18:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED3095805A;
	Tue, 21 Nov 2023 18:18:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABD0B58052;
	Tue, 21 Nov 2023 18:18:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Nov 2023 18:18:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH] Add note for how password needs to be provided when -p is used
Date: Tue, 21 Nov 2023 13:18:11 -0500
Message-ID: <20231121181811.43560-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QI8Blj0O07MGbkI2ScZVZZRHg3D6yijK
X-Proofpoint-GUID: QI8Blj0O07MGbkI2ScZVZZRHg3D6yijK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_10,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=793
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210143

Add a note describing how a password needs to be provided when -p
is used.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README       | 2 +-
 src/evmctl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 7239dda..54746ef 100644
--- a/README
+++ b/README
@@ -59,7 +59,7 @@ OPTIONS
       --keyid-from-cert file
                      read keyid value from SKID of a x509 cert file
   -o, --portable     generate portable EVM signatures
-  -p, --pass         password for encrypted signing key
+  -p, --pass         password for encrypted signing key; use -p<password>
   -r, --recursive    recurse into directories (sign)
   -t, --type         file types to fix 'fxm' (f: file)
                      x - skip fixing if both ima and evm xattrs exist (use with caution)
diff --git a/src/evmctl.c b/src/evmctl.c
index 8caf9bd..2710a27 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2851,7 +2851,7 @@ static void usage(void)
 		"      --keyid-from-cert file\n"
 		"                     read keyid value from SKID of a x509 cert file\n"
 		"  -o, --portable     generate portable EVM signatures\n"
-		"  -p, --pass         password for encrypted signing key\n"
+		"  -p, --pass         password for encrypted signing; use -p<password>\n"
 		"  -r, --recursive    recurse into directories (sign)\n"
 		"  -t, --type         file types to fix 'fxm' (f: file)\n"
 		"                     x - skip fixing if both ima and evm xattrs exist (use with caution)\n"
-- 
2.42.0


