Return-Path: <linux-integrity+bounces-444-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3681338E
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936B11F21F22
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B507B5B1EB;
	Thu, 14 Dec 2023 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xe9pvBZf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF86BD;
	Thu, 14 Dec 2023 06:50:03 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEE7F6G014417;
	Thu, 14 Dec 2023 14:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=jbJEYnJ0Zg+2AC4OCmM5ThHPrzgc1KXKJnFKYACU7ts=;
 b=Xe9pvBZff/dpCUdX8+XUc+AhwsaRqYDaaSfYK4c3Jz29IppzScBFTdAm898+v+WFuayc
 CycjaoVeMaCnY6tHPYo5Kt1T24UrrgNWuSZR4E2KuJtn4UO5N7OJ6ru+Dw+N68k1S4lV
 PBi3+He4LTXhRiKUhAgGAJC2lFv8JsePRLDXJrXl3W609ScobnMcnQMrFXRRkWN/ktHH
 npS69ZdXTnVbmsY1yrwtO5AZVhA5rm6+i88UGhYgVsfQzDHxE2i98AMtshg/1vGVJYu/
 hhGMcPBfhvAHK2e5xhl4E94Nz+zqA68jGziiJrpUaNoUVG9xO54gvtDVlkko8RKCW8Nu Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v036f1jah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 14:49:59 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEEPX4W021123;
	Thu, 14 Dec 2023 14:49:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v036f1j90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 14:49:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEkAuW008491;
	Thu, 14 Dec 2023 14:49:57 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw2jtscfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 14:49:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEEnv6533424026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 14:49:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ABA05805C;
	Thu, 14 Dec 2023 14:49:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203105805A;
	Thu, 14 Dec 2023 14:49:57 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Dec 2023 14:49:57 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Cc: Joel Stanley <joel@jms.id.au>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ninad Palsule <ninad@linux.ibm.com>
Subject: [PATCH v1 1/1] tpm: tis-i2c: Add more compatible strings
Date: Thu, 14 Dec 2023 08:49:53 -0600
Message-Id: <20231214144954.3833998-2-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214144954.3833998-1-ninad@linux.ibm.com>
References: <20231214144954.3833998-1-ninad@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lXUf8h3EUZXDhLwBOV-gcp3RYdvVihdX
X-Proofpoint-GUID: mX-nYjHeYN4ee4836NkBQahwom8-hOOC
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140103

From: Joel Stanley <joel@jms.id.au>

The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.

https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/

Add a compatible string for it, and the generic compatible.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 drivers/char/tpm/tpm_tis_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index a897402cc36a..9511c0d50185 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
 #ifdef CONFIG_OF
 static const struct of_device_id of_tis_i2c_match[] = {
 	{ .compatible = "infineon,slb9673", },
+	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "tcg,tpm-tis-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
-- 
2.39.2


