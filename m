Return-Path: <linux-integrity+bounces-9659-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPw8BioAFGquIQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9659-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:54:18 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B27875C7507
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 274403004631
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597703D567A;
	Mon, 25 May 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oXUUoUze"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4981AAE28;
	Mon, 25 May 2026 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779695656; cv=none; b=QFnY4mml45xGhzro2oqS6jCTtd2Fc5d/tn0PyvNKwU5isYgC3SmQb+Jqcrkb/aY+hSM6hYNDOEme3q5GI40Q7a4kWFJ4vabNjE4tFHteBjxGuXwEnCm9k/8hDelwmiG0+6q/qJIX3LDzVcWT1tImJrPqy7vLGgydKWDJy9DX2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779695656; c=relaxed/simple;
	bh=GLjR0pOZvKp6t4lRJ9X/m4e9jLFN4QEWM1Bm7UejT0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qi3VC1UFoODUbhSRx9YBsDU2Ir6n2d3+jNRq8/YsMFOSYo85MYqq/QqSKd7e7Kc5Wr3Y6vwcv9r5r+ccjQVR5hgSq/9xW+23KAdg1ceT4G5x9pehRKiGLN03lIZfrRRFfMeRBhhQ+5G3EUSC+I4bbUo5Rnn+7ocqwLOoPLoWfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oXUUoUze; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BEBC2696;
	Mon, 25 May 2026 00:54:09 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49A233F7D8;
	Mon, 25 May 2026 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779695654; bh=GLjR0pOZvKp6t4lRJ9X/m4e9jLFN4QEWM1Bm7UejT0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXUUoUze3gRaoy5rs1I9qYbVpyax3KUTAbJsTV4KhfqThaacdhq5QUSnkOSCWIaHr
	 WzWC3kQGmbn0DNhWmsmUfOroeCnim69N1eWFGKzp8qZ2CvmvL4bXB+xHVJBdsNSGFC
	 2c/lVO06jz8HBaQVscj1aH0ONrl18lA5wC2aPPVI=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: paul@paul-moore.com,
	zohar@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	noodles@earth.li,
	jarkko@kernel.org,
	sudeep.holla@kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	jgg@ziepe.ca,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 1/3] security: lsm: Allow LSMs to register for late_initcall_sync init
Date: Mon, 25 May 2026 08:54:02 +0100
Message-Id: <20260525075404.3480282-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525075404.3480282-1-yeoreum.yun@arm.com>
References: <20260525075404.3480282-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,arm.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9659-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,arm.com:email,arm.com:mid,arm.com:dkim]
X-Rspamd-Queue-Id: B27875C7507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are situations where LSMs have dependencies that might mean they
want to be initialised later in the boot process, to ensure those
dependencies are available. In particular there are some TPM setups (Arm
FF-A devices, SPI attached TPMs) required by IMA which are not
guaranteed to be initialised for regular initcall_late.

Add an initcall_late_sync option that can be used in these situations.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/linux/lsm_hooks.h |  2 ++
 security/lsm_init.c       | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..c4488c4a6d8a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -167,6 +167,7 @@ enum lsm_order {
  * @initcall_fs: LSM callback for fs_initcall setup, optional
  * @initcall_device: LSM callback for device_initcall() setup, optional
  * @initcall_late: LSM callback for late_initcall() setup, optional
+ * @initcall_late_sync: LSM callback for late_initcall_sync() setup, optional
  */
 struct lsm_info {
 	const struct lsm_id *id;
@@ -182,6 +183,7 @@ struct lsm_info {
 	int (*initcall_fs)(void);
 	int (*initcall_device)(void);
 	int (*initcall_late)(void);
+	int (*initcall_late_sync)(void);
 };
 
 #define DEFINE_LSM(lsm)							\
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7c0fd17f1601..a1ad641811de 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,13 +556,22 @@ device_initcall(security_initcall_device);
  * security_initcall_late - Run the LSM late initcalls
  */
 static int __init security_initcall_late(void)
+{
+	return lsm_initcall(late);
+}
+late_initcall(security_initcall_late);
+
+/**
+ * security_initcall_late_sync - Run the LSM late initcalls sync
+ */
+static int __init security_initcall_late_sync(void)
 {
 	int rc;
 
-	rc = lsm_initcall(late);
+	rc = lsm_initcall(late_sync);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
 	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-late_initcall(security_initcall_late);
+late_initcall_sync(security_initcall_late_sync);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


