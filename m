Return-Path: <linux-integrity+bounces-9222-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGVkFSt24mnh6AAAu9opvQ
	(envelope-from <linux-integrity+bounces-9222-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 20:04:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEA541DCB9
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 20:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9760D30E8836
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 17:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB731E83D;
	Fri, 17 Apr 2026 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T1aXdFw1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9C2D0614;
	Fri, 17 Apr 2026 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776448694; cv=none; b=sFtx45XYsTtBz7EZpX0emVznVwl2ky6PRsqp97Ip4Zfw9VYOQxokyp8Bnfgelqclqc363UQ9+JWc2kXDFifJTpceI95M3H6OBQTrL0Gjw/wuw5JfcwTfPwQDPCR/nz3O2zk5PePZuUUETS/G44WwocBmY5LlSEvQQo+DNvM52Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776448694; c=relaxed/simple;
	bh=+KnBVwVQsum+9CObFDKz95hXpLV5Rw5969CJRIdIoIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTT6cgVKTWr33ouCP9xQtRWUASnBoFHL2h1w96ZxHolt8r+2NQc4EmcfJ+VOf1PZKHe5KWHaTTIFXoTJW9DCJmuaV736c7vqLmnjtzi49XNehbtKWgMPvPRtRTSfA9cfyiNxfX2+tDSca1ZxcbuZhxhNwzoy0IJMBvB0QECyAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T1aXdFw1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 428DC2944;
	Fri, 17 Apr 2026 10:58:06 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9599E3F7D8;
	Fri, 17 Apr 2026 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776448691; bh=+KnBVwVQsum+9CObFDKz95hXpLV5Rw5969CJRIdIoIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1aXdFw1ZQlfTCMfEZ9QDq5gUlkhpeOXtZ0gmNCAyubzlZS0aaDtkG5KpO01D/tw0
	 JK3FDNZRqo83n2Mhodpavo4N6RsNmJIBwhsa3oHBveTiwpNnS1kT/bfR7200hrhaPD
	 ZrunDHUHk9bimOBUfriy68s5iKVOlVJwTBFXZVWU=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	sudeep.holla@kernel.org,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH 2/4] tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in
Date: Fri, 17 Apr 2026 18:57:57 +0100
Message-Id: <20260417175759.3191279-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417175759.3191279-1-yeoreum.yun@arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9222-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBEA541DCB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.

However, as IMA init function is changed to late_initcall_sync level.
So, this change isn't required anymore.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/char/tpm/tpm_crb_ffa.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb_ffa.c b/drivers/char/tpm/tpm_crb_ffa.c
index 99f1c1e5644b..025c4d4b17ca 100644
--- a/drivers/char/tpm/tpm_crb_ffa.c
+++ b/drivers/char/tpm/tpm_crb_ffa.c
@@ -177,23 +177,13 @@ static int tpm_crb_ffa_to_linux_errno(int errno)
  */
 int tpm_crb_ffa_init(void)
 {
-	int ret = 0;
-
-	if (!IS_MODULE(CONFIG_TCG_ARM_CRB_FFA)) {
-		ret = ffa_register(&tpm_crb_ffa_driver);
-		if (ret) {
-			tpm_crb_ffa = ERR_PTR(-ENODEV);
-			return ret;
-		}
-	}
-
 	if (!tpm_crb_ffa)
-		ret = -ENOENT;
+		return -ENOENT;

 	if (IS_ERR_VALUE(tpm_crb_ffa))
-		ret = -ENODEV;
+		return -ENODEV;

-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(tpm_crb_ffa_init);

@@ -405,9 +395,7 @@ static struct ffa_driver tpm_crb_ffa_driver = {
 	.id_table = tpm_crb_ffa_device_id,
 };

-#ifdef MODULE
 module_ffa_driver(tpm_crb_ffa_driver);
-#endif

 MODULE_AUTHOR("Arm");
 MODULE_DESCRIPTION("TPM CRB FFA driver");
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


