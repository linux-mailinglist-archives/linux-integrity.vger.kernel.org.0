Return-Path: <linux-integrity+bounces-9749-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q1SeMFbiImorewEAu9opvQ
	(envelope-from <linux-integrity+bounces-9749-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 16:51:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0DF648FEE
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 16:51:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=ah1pfGCl;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9749-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9749-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A0A130799DE
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AEA3D525A;
	Fri,  5 Jun 2026 14:43:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FC3D0C17;
	Fri,  5 Jun 2026 14:43:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670631; cv=none; b=KBn8LXdFG3M7ZV4uHpBSOA8+qN4sgCJadCyU8loK7axQY8yIVPFT8DteZ3eKAZ4zPcfQRNc++Cm1KYfEDfBXPdaW0dhWLztZTh1jM5vIh7poHZIMZzjwne19zblYimIaSfo4TFS4UZfbxrYOGcq9hnzwtgJiR5nzlCB3LiYbR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670631; c=relaxed/simple;
	bh=89AoJatEzNGhZ8P3NpK73/gHwNaQ1811DMSbBBQix/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LZZelEPgzTH0SQJyAS6RYb6mLEWrDr41j7oNLBPUTk92ZguDfmXi3NpBGPmdcj80rDGQdVce+AYRO3LsVvH/y6cVDPWM+IhQsPsp0EkyUG4uFlAQO7nbT7HXQhsYT8k1qbt63vT+iVx38p8SuvtpGcOHUjtyWjhoazgbH3rU0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ah1pfGCl; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D8F4237B;
	Fri,  5 Jun 2026 07:43:43 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31F1D3F7D8;
	Fri,  5 Jun 2026 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780670628; bh=89AoJatEzNGhZ8P3NpK73/gHwNaQ1811DMSbBBQix/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ah1pfGClri3U5Sw30ICpHlpa7EpLjXxcd5QRwRahQ5ulAQQl2k+xRuKLPy6HVOGKI
	 /Tuh03zHLNiLetXUgcQCIPJbchjFYkNdGGnur/OTKoj4Bhn30nCcsqftjJcnpEoE/G
	 Np2tFFWkGuMDDmWrfsJtyOk3e58VJKXz7zZ5qxzo=
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
Subject: [PATCH v6 4/4] tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in
Date: Fri,  5 Jun 2026 15:43:25 +0100
Message-Id: <20260605144325.434436-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605144325.434436-1-yeoreum.yun@arm.com>
References: <20260605144325.434436-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca,arm.com];
	TAGGED_FROM(0.00)[bounces-9749-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:zohar@linux.ibm.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:yeoreum.yun@arm.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yeoreum.yun@arm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim,arm.com:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C0DF648FEE

commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's built-in")
probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.

However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
initialises IMA at the late_initcall_sync level, so this change is no
longer required.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
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


