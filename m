Return-Path: <linux-integrity+bounces-3808-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37A99CC95
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 16:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011281C2165E
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91571581EE;
	Mon, 14 Oct 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sDGyU9dh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC417C8D;
	Mon, 14 Oct 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915427; cv=none; b=QA9ihZ6zwJSbm2L+96En4cA9bgBhfE9LbLmu1GxPc41+HnLVfdB/+OUMPkOpp8jy4oKueO3coFODIOuwpTRNn67Pyk9ZrFVtwz3mM8J/QJAZHVxEf3ZZeE+4hw47SxmzCzUZEBbNiKhE62vxzoWH2rUvDty6ChnisqjzzL/RPXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915427; c=relaxed/simple;
	bh=ju4Mt8h2px3i7lcvR8qIN2n/WdXKkrr7yZo8Squbmg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAsgUmE2a9cwJ52Acgw5IuFfZ+WdfVsYZskhAQSEzIImB0cIkWeJw3vm+8Pxrz0j4XFSscyRgGXmAWmChiUcXLqnx5dRxVzW0aRArtFZMwjo1viYwiJFCDm8RLTu4S4FxXAPF9ZclqI6D1tJtut5v0RGHTeogZlQll0vPQPWCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sDGyU9dh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EDo2Ur025375;
	Mon, 14 Oct 2024 14:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=V4ZSJh+/gINXd1XQOEDszc54S6
	0PZh0QEq00yayxAHg=; b=sDGyU9dh+SuUWfYRzRCNWixcdxcacaebP5R8sCvDut
	XLvXwayQHy/6FDSKyk3qH6kmYbUJJiS0/frNdLe/Nwr203rXSjRjFjCkT5WwoSrd
	9I8u5hQZRW5b/3T5sP6rlpYC4DtfzdSA9UV26CpKjkLPPsbht2LlKUzFeZ+Z6W1W
	24YAF/d9rExQ1pBdEeqAl0t/W28YTrfEDlNGR+zJkwAu1mmRIwcdEZM1RarNhKAz
	Nlo+QLxPK4G7j0Vs4W9Y5TeBOwZGhvhKrFdHIoQB/1um20kWkMf25qnfvKBfZxPR
	C3tXa4WWcm47Nir49Hy5y/oahxnRx66uXGXyBZAX+QJw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4294heg4kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 14:16:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EDmwnB027452;
	Mon, 14 Oct 2024 14:16:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txf2ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 14:16:57 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49EEGutp48497024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 14:16:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6873558056;
	Mon, 14 Oct 2024 14:16:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 110005803F;
	Mon, 14 Oct 2024 14:16:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Oct 2024 14:16:55 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] tpm: ibmvtpm: Set TPM_OPS_AUTO_STARTUP flag on driver
Date: Mon, 14 Oct 2024 10:16:43 -0400
Message-ID: <20241014141643.3101129-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0aBf7fkdgq3XZUQFyWYEQFy7zRSFB2aG
X-Proofpoint-GUID: 0aBf7fkdgq3XZUQFyWYEQFy7zRSFB2aG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxscore=0 spamscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140103

Set the TPM_OPS_AUTO_STARTUP on the driver so that the ibmvtpm driver now
uses tpm2_auto_startup and tpm1_auto_startup like many other drivers do.
Remove tpm_get_timeouts, tpm2_get_cc_attrs_tbl, and tpm2_sessions_init
calls from it since these will all be called in tpm2_auto_startup and
tpm1_auto_startup.

The exporting of the tpm2_session_init symbol was only necessary while the
ibmvtpm driver was calling this function. Since this is not the case
anymore, remove this symbol from being exported.

What is new for the ibmvtpm driver is that now tpm2_do_selftest and
tpm1_do_selftest will be called that send commands to the TPM to perform
or continue its selftest. However, the firmware should already have sent
these commands so that the TPM will not do much work at this time.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm2-sessions.c |  1 -
 drivers/char/tpm/tpm_ibmvtpm.c   | 15 +--------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 511c67061728..b1a0a37f14d7 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -1362,5 +1362,4 @@ int tpm2_sessions_init(struct tpm_chip *chip)
 
 	return rc;
 }
-EXPORT_SYMBOL(tpm2_sessions_init);
 #endif /* CONFIG_TCG_TPM2_HMAC */
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 1e5b107d1f3b..76d048f63d55 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -450,6 +450,7 @@ static bool tpm_ibmvtpm_req_canceled(struct tpm_chip *chip, u8 status)
 }
 
 static const struct tpm_class_ops tpm_ibmvtpm = {
+	.flags = TPM_OPS_AUTO_STARTUP,
 	.recv = tpm_ibmvtpm_recv,
 	.send = tpm_ibmvtpm_send,
 	.cancel = tpm_ibmvtpm_cancel,
@@ -690,20 +691,6 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (!strcmp(id->compat, "IBM,vtpm20"))
 		chip->flags |= TPM_CHIP_FLAG_TPM2;
 
-	rc = tpm_get_timeouts(chip);
-	if (rc)
-		goto init_irq_cleanup;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		rc = tpm2_get_cc_attrs_tbl(chip);
-		if (rc)
-			goto init_irq_cleanup;
-
-		rc = tpm2_sessions_init(chip);
-		if (rc)
-			goto init_irq_cleanup;
-	}
-
 	return tpm_chip_register(chip);
 init_irq_cleanup:
 	do {
-- 
2.43.0


