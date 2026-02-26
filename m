Return-Path: <linux-integrity+bounces-8564-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEmYLYn0n2kyfAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8564-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 08:21:45 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBA81A1CAB
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 08:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0441E309008F
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Feb 2026 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E83638F921;
	Thu, 26 Feb 2026 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jT8yfCz3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCA38F220;
	Thu, 26 Feb 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090427; cv=none; b=bOJyk86dEp97WL6L47rB7D3a9cdGxNM7B9eK+dypJ2H40ThfauI7Dmj2C1fwPqhLcm5/eXUub/O2LQbtbsNf4tM18IOanC5sYKf3yDTzGImnl/aHg9YxRsilq5ww+VkulIPJV78ow+ZUc+N7MlJIqTqFWypGRey51q6/fy+91Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090427; c=relaxed/simple;
	bh=LFqBpkOHHrz0+82+lCKyk++cLTVpgpMp3m07f0lNCgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMy2XLKP4/Fx91zHI5XCQGylC3J1JILJ+I+kyt7Z8NL8sfd+FXctOq7Ky1YK0MPnax01naAPWJpAzrZ31o2MQKikCINGiTme5WxIws5L2muqnumyzIUDFpEljSBe8PI3YB9OYt+gP4NKBX2RPMGXnqlpsFtiDfOGSyFccVvgtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jT8yfCz3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772090423;
	bh=LFqBpkOHHrz0+82+lCKyk++cLTVpgpMp3m07f0lNCgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jT8yfCz3TIppnkqYmB8/TpSvxEhN4jrG2cAyDul0n15YBJ8ggCQjwtQPbiOOLJyG5
	 z2bxbSx07vjL/gfWaSw/nLHKjCYxrM7c8vXm9bNjbMWZwr5Uexaz49LnvE/I14mg/Z
	 jNC1mgH9K2B321H2bxFGFcA1h7hhGe45PNcWwXR4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 26 Feb 2026 08:20:12 +0100
Subject: [PATCH 1/2] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-ima-ifdef-v1-1-8b9613edbbdb@weissschuh.net>
References: <20260226-ima-ifdef-v1-0-8b9613edbbdb@weissschuh.net>
In-Reply-To: <20260226-ima-ifdef-v1-0-8b9613edbbdb@weissschuh.net>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Aaron Tomlin <atomlin@atomlin.com>, Nicolas Schier <nsc@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772090423; l=1084;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LFqBpkOHHrz0+82+lCKyk++cLTVpgpMp3m07f0lNCgQ=;
 b=nAGuJZ+hD7tATfpRDB+PXn1L2Sppj9pwxenqRNLuGBmFSNYr51V69W6Utwz9lEKLgATOQDLvH
 kfewoqnvE0QCWYsxgMnFHPoexywWkeZBnHkIf3srxtygU9BxU3+Ur4Z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8564-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,ellerman.id.au,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,weissschuh.net:mid,weissschuh.net:dkim,weissschuh.net:email,atomlin.com:email]
X-Rspamd-Queue-Id: 2EBA81A1CAB
X-Rspamd-Action: no action

When configuration settings are disabled the guarded functions are
defined as empty stubs, so the check is unnecessary.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
---
 security/integrity/ima/ima_efi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 138029bfcce1..a35dd166ad47 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -68,10 +68,8 @@ static const char * const sb_arch_rules[] = {
 const char * const *arch_get_ima_policy(void)
 {
 	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
-		if (IS_ENABLED(CONFIG_MODULE_SIG))
-			set_module_sig_enforced();
-		if (IS_ENABLED(CONFIG_KEXEC_SIG))
-			set_kexec_sig_enforced();
+		set_module_sig_enforced();
+		set_kexec_sig_enforced();
 		return sb_arch_rules;
 	}
 	return NULL;

-- 
2.53.0


