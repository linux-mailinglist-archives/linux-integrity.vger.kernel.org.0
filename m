Return-Path: <linux-integrity+bounces-9488-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHiyJHkj/mmunAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9488-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:55:05 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A24FA430
	for <lists+linux-integrity@lfdr.de>; Fri, 08 May 2026 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F5E83006B46
	for <lists+linux-integrity@lfdr.de>; Fri,  8 May 2026 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C22421A12;
	Fri,  8 May 2026 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPSfo/+f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B04219E8;
	Fri,  8 May 2026 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262891; cv=none; b=HKDM5Duy82b4lvKug/AXU3StYYKcrw2SEl8Qc/fsslbprQfNTTZJtpqWE4eYNJ3Sw4fHlb9Yk1Bsr+4dW8fYCkBn1NWpCDs7yzK9fQVFb7zrkW6vbfynsRcVWxsCZW3qMKT6vxGA0O2pc4f0HOcYCywk116nLlUTJO90DPx22go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262891; c=relaxed/simple;
	bh=1dYHe65DV95VZFN3CAYebqbE8uRbj3es6XTQIjoGPRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olI95iFTqBRvCqSmZcMTjPEEOJdi5BoiDOdbX21AXt7+yAxsZd1yDpP2duhbZflylqVxHtKHLoKp5oaVlNW5DQa69+yUttDUBTRNnP52BI4yW3iWez+68nuyeevSlC6CIxSwHuI2Sbmyi0ktPI79XopdPSwr4DB4YFAScOz5jiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPSfo/+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78217C2BCB0;
	Fri,  8 May 2026 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262890;
	bh=1dYHe65DV95VZFN3CAYebqbE8uRbj3es6XTQIjoGPRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PPSfo/+fVPkzA3bjANTm5g4wn4Evv6yw/bSsW+NMe0DrTNkOaoWnCKoLLs3oQTIjG
	 Z4D7xL+JcM8ltnRKhkaHpRtU4p5O2bpm1e2PFn3sFjQd1AG5CXrhFVm7NczV5683VY
	 l7TnUIRUTbpspdRWPw4cK0gGtf9ze1zSIcXtmeCkvwAJvmZ6X7SEJtqxjWq06vvO0e
	 f5JCBxegxjmZR0mRCibXUZX3Pu2Qr11x5Nj1rT4Mdt7Jn3lmN3ch3FZU0z6WqR7LA8
	 5ipEQuTEqCIahOdbRea2e1Ck4T/v1X+RnOzM4OPRQZsWbVQa0uoTnX95Q6mht3oHKA
	 J/lJ84hYxHZGg==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Fri, 08 May 2026 18:54:15 +0100
Subject: [PATCH 1/4] Revert "firmware: arm_ffa: Change initcall level of
 ffa_init() to rootfs_initcall"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-b4-ffa_plat_dev-v1-1-c5a30f8cf7b8@kernel.org>
References: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
In-Reply-To: <20260508-b4-ffa_plat_dev-v1-0-c5a30f8cf7b8@kernel.org>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 276A24FA430
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9488-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Action: no action

From: Yeoreum Yun <yeoreum.yun@arm.com>

This reverts commit 0e0546eabcd6c19765a8dbf5b5db3723e7b0ea75, which was
added to address ordering issues with the IMA LSM initialisation where
the TPM would not be fully ready by the time IMA wanted it. This has
been resolved within IMA by retrying setup during late_initcall_sync if
the TPM is not available at first.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index eb2782848283..6efb85787e6e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2106,7 +2106,7 @@ static int __init ffa_init(void)
 	kfree(drv_info);
 	return ret;
 }
-rootfs_initcall(ffa_init);
+module_init(ffa_init);
 
 static void __exit ffa_exit(void)
 {

-- 
2.43.0


