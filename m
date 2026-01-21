Return-Path: <linux-integrity+bounces-8286-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCGfJuWDcGktYAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8286-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jan 2026 08:44:37 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BA852FA7
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jan 2026 08:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4198483171
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jan 2026 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846B94657F5;
	Wed, 21 Jan 2026 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1Zs+WH1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+lOgm+p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAEE43636E;
	Wed, 21 Jan 2026 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981469; cv=none; b=DHvWmgQV6jHBJFsbo8b6GETALoXhrBkrikPyLbiHjn99XzEdEpHQpAZN7sQ4tAg3GrdLAcz44wIp0CzWk67Bpn2F0eZT/gV/Xc77+FWA0INjO0Jc1vGimmANJgDpKXN0wJBTijpqcqj+iDZe4yI81nHEkuKxs6UJE+N4W44tdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981469; c=relaxed/simple;
	bh=rUxz+eQcTiT8Eocx/OCaRzNUkBbr9jqRN7boZLQK8kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XWHqHNDhWG7rhV7BHxwgThytloqIDFYB0pvd0vHOCyHQcECEsSizv7pkJsZ3IYSbj7iMGfB8vQNReZjF8JdcE03G3p20SMecxo4isVp7qNozAlF0gZdDIfNlSOlJ3WuTzL9yXNzr5SE2cvQieRV29us2PTx3Jcwb/Kxdul7FN9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1Zs+WH1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+lOgm+p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768981465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIvYdrSQBe9ir4MS5HtE9uB33oKlBqD71NakOZFLopY=;
	b=v1Zs+WH1ZyOow+0YL/klnFj6EK3JbtDcumtsZMtjSZeUaEyo50+5oKd//MMRHOGJl+rHJI
	RIury9GryLw7J4qopejXD5U2heogd0InaTELCdDN+QRizrVEtDGS1UJ887Ezl/9fvKQuPb
	dSmLxzjQ5jqGaPG5V1tmX4MJSvZmx9UB0rgPfMzVBeXIV+qnKdJLIqvFv6kDOUiYYpJChc
	J1Jx7zW2vCtjRYsyGcozqgjtV5awTQOecnLZL4miTU6iFdK565NFDV42/OkmZQkdLD6xxv
	e1P7VNg1MpE9ZYioywMqF3vAqSTc6faVFQiGLI6CKN8bRPHyCLm0xxEoROWsdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768981465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIvYdrSQBe9ir4MS5HtE9uB33oKlBqD71NakOZFLopY=;
	b=I+lOgm+pzQ36/jjh6Ru+zjwb3Sa/maN/GGeH14pqIN1KlUt9nZHb7P/lr92HOXKqNpv/U5
	iK1AYX3VPyQtd/CQ==
Date: Wed, 21 Jan 2026 08:43:59 +0100
Subject: [PATCH] efi: Mark UEFI skip cert quirks list as __initconst
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-uefi-certs-initconst-v1-1-896458b3e03f@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAL6DcGkC/x2MMQqAMAwAvyKZDbSFOvgVcZAkapZWmiqC+HeL4
 8HdPWBSVAzG7oEil5rm1MD3HdC+pE1QuTEEFwbng8dTVkWSUg01aaWcrCJHXpji6jwztPQozbr
 /7TS/7wd/MpKaZgAAAA==
X-Change-ID: 20260121-uefi-certs-initconst-d5dadc5f01dd
To: Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768981459; l=1160;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rUxz+eQcTiT8Eocx/OCaRzNUkBbr9jqRN7boZLQK8kM=;
 b=fqjAEQi5K3fgms6TjBCPCBImC+o0haepvCf5+TaCGsw84+grszBlGM2qZ6enMjLeQX3SfzWF8
 gpqH/W4EsxTA0KetSS/PRDctqoA/EQ+YacRTYYU+aNdihPtdyjlqxNd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8286-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 82BA852FA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only user is marked as __init, so there is no reason to keep this
data around after bootup.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 security/integrity/platform_certs/load_uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index d1fdd113450a..26523a2b29c7 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -19,7 +19,7 @@
  * a crash disabling EFI runtime services. The following quirk skips reading
  * these variables.
  */
-static const struct dmi_system_id uefi_skip_cert[] = {
+static const struct dmi_system_id uefi_skip_cert[] __initconst = {
 	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,1") },
 	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,2") },
 	{ UEFI_QUIRK_SKIP_CERT("Apple Inc.", "MacBookPro15,3") },

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260121-uefi-certs-initconst-d5dadc5f01dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


