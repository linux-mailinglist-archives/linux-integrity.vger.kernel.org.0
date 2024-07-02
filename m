Return-Path: <linux-integrity+bounces-2967-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B027924BE4
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 00:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61DB1F216FC
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 22:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647EA55C08;
	Tue,  2 Jul 2024 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RDtc127y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11A1DA301
	for <linux-integrity@vger.kernel.org>; Tue,  2 Jul 2024 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960825; cv=none; b=pOo4fODIn4ORe0z8OOiW7QBQett7GDdMW/Fe0zGv+JtAoQQMlSvkBsUfW5jegA0jlKv66ZCyqiV5R1bUF/Z7RbJe4i2wdspuUdhydbAdIiZ8driGEw6OVWUKm/p8fe+vO2mdcowUBFZT/NYPf+XOpeKasCAQ1TIoUo8oQSvJSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960825; c=relaxed/simple;
	bh=XEJvXHgk4DEqY4tbGcVVYYsEAFI8+kxhublaHwwRkks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gg75ghXSKZZSNrhb08JsRbLOxqApIxah2EttqxAG/I0YcgYzQhbOj52+wcGWxreluJlDe7N6SrQeviD7QXAXjN35lJDEyGDLDcr4KiUfX5KGf8YNTvY70CSLd02zaRKpDXPepSynWUZzPcgjtdZr7LfOx83udBXICQTcNn9HuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RDtc127y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462Lx23V009489
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jul 2024 22:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=E6HBOPDIZAI27cevnQbbYF1rCz
	Egw0iWUDBh+xpdpGs=; b=RDtc127ybYWcRgosZO85pzefIzSzx63VWrYKLZPtHE
	3ZfCF925+ACwBuY3lLW+GAKxV4ygN/WcS8rlrTqCQC248XwiGhRcYY86DeAwqcV5
	5IHwVEJj6T9esDkGL4r8QhOolWDm3iWtwbm2Xj7D8Frq+fnyjJY++abHZxtxZqsQ
	6bwj1Rh8cTgY/ZUI7RWdtKCnUAtNxVRQLgdiQGXsVVH7bgi8ightlxao6WiTHkxM
	QKsGKf4/TByl6iRGgNyBfAQvOvLBFE84Q7e3xd+yro9LJZvd9TF6HgFPsJKh77SA
	/pGHHqorEdHXVoeCMysyzgRt1/iCFKH79aH3ky8MOXfw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404sxa83hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jul 2024 22:53:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 462LLigX026448
	for <linux-integrity@vger.kernel.org>; Tue, 2 Jul 2024 22:53:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402wkpycvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Tue, 02 Jul 2024 22:53:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 462MrZDB32834000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 22:53:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA27A20049;
	Tue,  2 Jul 2024 22:53:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C88E420040;
	Tue,  2 Jul 2024 22:53:33 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com.com (unknown [9.61.154.133])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jul 2024 22:53:33 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH] Require specifying openssl PKCS11 engine or provider access method
Date: Tue,  2 Jul 2024 18:53:30 -0400
Message-ID: <20240702225330.13136-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dJWVkzHSOH3ij0YQtCp_wuuSfCYeT539
X-Proofpoint-ORIG-GUID: dJWVkzHSOH3ij0YQtCp_wuuSfCYeT539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_16,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=992 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020168

Directly calling the new imaevm_signhash() function without specifying
the access_info may result in dereferencing a NULL pointer.  Require
specifying the openssl PKCS11 access method.

Fixes: 5d89393ff9ab ("Implement imaevm_signhash library function and deprecate sign_hash")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index a0176c0df9ef..6321f105d91f 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -1118,6 +1118,11 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass,
 	EVP_PKEY *pkey = NULL;
 
 	if (!strncmp(keyfile, "pkcs11:", 7)) {
+		if (!access_info) {
+			log_err("PKCS11 engine or provider not specified");
+			return NULL;
+		}
+
 		switch (access_info->type) {
 		case IMAEVM_OSSL_ACCESS_TYPE_ENGINE:
 			pkey = read_priv_pkey_engine(access_info->u.engine,
-- 
2.43.0


