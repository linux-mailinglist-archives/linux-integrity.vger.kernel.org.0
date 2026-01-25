Return-Path: <linux-integrity+bounces-8314-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GZSH/tudmnyQgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8314-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:28:59 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF30F82280
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 20:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8096303AB63
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Jan 2026 19:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038492F362A;
	Sun, 25 Jan 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1t1gwLw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44AB2F12A5;
	Sun, 25 Jan 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769369167; cv=none; b=O0BayPaFe/HRKld8FTSFsx0IvbHirYAmZbt7bMGSZEwBvdkbc7ZB57A4yIxzYZGIH1wI5JpzH1NGTXA5/MDjKiHV6JrVN9otNA5o5IdNe/2Qwdq+H/kDB9IcScqvPo383/ShLohbR3YdKM9YyBIHhJq907/HI5caddEyOIhuGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769369167; c=relaxed/simple;
	bh=5edvRXiZtKuCqYiyovDpX6TJD/qNz0z+e7B/kJJvrgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FERsqGdVcdaKHKqRi6RF0uktgyTJ3ddI7kHyrkrab8DmponNc31plCn6BMn0hppUIf3nQ1DNPA6zeyJx5gryU5hi/70jA89KhwvmeSOV8JxfusSaCswAJf2SBQBGCwfEHq20hIyNWfl5RWcVq8sSXNT1E7XyesBCzGXxaZ/LV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1t1gwLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29489C4CEF1;
	Sun, 25 Jan 2026 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769369167;
	bh=5edvRXiZtKuCqYiyovDpX6TJD/qNz0z+e7B/kJJvrgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1t1gwLw9B7EfCjDkrDVNY1HcosD7na6FOwZj2ckixl4xtS+5U6NrLKnqCD/yS1Uk
	 WoTIm8hpBIA/pFJgolKmOgYBrHWy4vbfFtiBJH2PRiEdmCaX1MVt8U3oMqck6Ip00v
	 28dpdWSJ/x/V1VFlyoexVbO6wbQebvI+/1WRaeBkQo/mUvkTuqcnF8Z76SGgXAq0Xh
	 xLKsnCCszI7wrJm51uySQ3EqeO4oLeEsyZfVq9eGUvhkCSO/H7uGBD0IrhXXmEYpMI
	 tA5rnviJ6nMDWyu0MkOSAhn5sZf++9w+s9brH7jHSiih9Eo9iQIRqAzRIAJODJOFhT
	 WHWOQUp4M2DHQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Jonathan McDowell <noodles@meta.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org (open list:KEYS-TRUSTED),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 06/11] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Sun, 25 Jan 2026 21:25:16 +0200
Message-ID: <20260125192526.782202-7-jarkko@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125192526.782202-1-jarkko@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8314-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: BF30F82280
X-Rspamd-Action: no action

TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always does
set up either password or HMAC session.

Remove the branch in tpm2_unseal_cmd() conditionally setting
TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised at
run-time, and thus does not cause regressions.

Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 4894aae6ef70..ec84ea945d3b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -451,10 +451,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
-	struct tpm_header *head;
 	struct tpm_buf buf;
 	u16 data_len;
-	int offset;
 	u8 *data;
 	int rc;
 
@@ -495,14 +493,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		tpm_buf_append_u16(&buf, options->blobauth_len);
 		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
 
-		if (tpm2_chip_auth(chip)) {
+		if (tpm2_chip_auth(chip))
 			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
-		} else  {
-			offset = buf.handles * 4 + TPM_HEADER_SIZE;
-			head = (struct tpm_header *)buf.data;
-			if (tpm_buf_length(&buf) == offset)
-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-		}
 	}
 
 	rc = tpm_buf_fill_hmac_session(chip, &buf);
-- 
2.52.0


