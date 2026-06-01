Return-Path: <linux-integrity+bounces-9710-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id O+bSF6yYHWpOcgkAu9opvQ
	(envelope-from <linux-integrity+bounces-9710-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 16:35:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A991620F44
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7B1C3049720
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2026 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41C53BC687;
	Mon,  1 Jun 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="F+Wo+tiF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0B3AF669;
	Mon,  1 Jun 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324084; cv=none; b=rApO7uPh93m7uzDb/6/T8/SsL9aZgJUANBU6ker9IXTR7C3H60UlgFsO23HcQ+6Omh//FQSrC6yHI1Fi/A60nIwlflr8opNU1QLFak7HSaBLM8iNGBMV9lLN44pjuaXhszDjxDCvQkNPnFnJnEbqWknaONeR6yy9Y+ltMY6Nn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324084; c=relaxed/simple;
	bh=GLjR0pOZvKp6t4lRJ9X/m4e9jLFN4QEWM1Bm7UejT0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbiOkGug4iWtRZNZi0Fo9UtP8sDprGvSeVODaKD31U8bsujG51j0acKz3wPO/ezWs5vQxmEEEi2qP6NgibvT+JyDNi7bQQt0lAIzEzlQkX3U1Gu1FOE26P5Y9VMYNrX3vWVBKXKL9nwtr4iB+VeH/jCjm5UK7ngvWE1VLK50fn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=F+Wo+tiF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAD0F1655;
	Mon,  1 Jun 2026 07:27:56 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 175B63F632;
	Mon,  1 Jun 2026 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780324081; bh=GLjR0pOZvKp6t4lRJ9X/m4e9jLFN4QEWM1Bm7UejT0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+Wo+tiFIW3vfmru7Hu7KHaUMdY55qbRt9bvyD2bPrNE5hJ++C/oomnuc5jQ3uEWO
	 w3LbFRDPC8RlqQBu9ozi0Dc5UceMTW96HDiYl7D8BMQMoxd8FAsUE//Ri2xv2rLikA
	 qMmbp7uSOkfrpgFiEbte1vBTII6PHKRruJBipb84=
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
Subject: [PATCH v5 1/4] security: lsm: allow LSMs to register for late_initcall_sync init
Date: Mon,  1 Jun 2026 15:27:46 +0100
Message-Id: <20260601142749.3379697-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601142749.3379697-1-yeoreum.yun@arm.com>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,arm.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9710-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:mid,arm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A991620F44
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


