Return-Path: <linux-integrity+bounces-7265-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C60B98E01
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99EE16109C
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8628136C;
	Wed, 24 Sep 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="DRwF2xRs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFC4502F;
	Wed, 24 Sep 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702580; cv=none; b=iC633DRaHsz10VElmKJsTds1UYySUgAwOAqyzx1h/y/6GwM1zGEQzl3Ef6nKqzEuZtz+s9cY4hFENMVo9eulaiG0N7TUyKv0z8m8sr5Atd0e/rdNQxUB0uk9zoxu4m0Wrc8uyBCnfeDZ5jX+lcRR+pckD+7t2dJrcggqojXvCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702580; c=relaxed/simple;
	bh=dMJayFRQXCbfy7iFRVB54b2syrkiy8nEueH3QbLILTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+j8eqgVC+QOPaPmBskXcnmHbakhJCEWoJZ25UTJN4yUp4AuZkLN808ur37V5qlUZuj/Epu1Tcj8exDxN8VE2+/wQQy/KAL603DrALtuuSWbYRAO6pB6UxAG2IrVe1kicTqZRNl9nZhec1Khc9SCmYjo2YiLqUeZubszf+tpeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=DRwF2xRs; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K1s/oBfOLj5oIgwltUdaNspTmj/kufa3O8CRtPGUkXY=; b=DRwF2xRsWH/dYQFn3bBeJahJaM
	355/2JZAvH8ekwKFy9bMNLrZf5GL4hhAoodxeRmlF/BGAwvzLh6ANNSwXbUxNQ3WL2EFwJKOV6Kxl
	yAqKANnNDidvIPWcvUy0zh3YqjOiMLW2ENu0sXZWl96BLh36kCgzC4pyTP77kn0OlS9LJLcUdDw+o
	qolGoySAFCUNeamzY9zlFe1JaYliyUOGuHM6A8RKLFAWFttPqTMyt5/XZxjOsGjhE+UXS3zW7jhDY
	6pqL8w0CjTtwQrcM42pqzORw8bfFDdC1UigDeuwZ+FEHT/wV0O4QzoGwx1bbZ5En/v7QqbpXn2BPq
	RvEQy2bw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v1KsN-00EF72-22;
	Wed, 24 Sep 2025 09:29:23 +0100
Date: Wed, 24 Sep 2025 09:29:23 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] keys, trusted: Remove redundant helper
Message-ID: <aNOr4_xLQ30iTRSe@earth.li>
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250922164318.3540792-5-jarkko@kernel.org>

On Mon, Sep 22, 2025 at 07:43:17PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>tpm2_buf_append_auth has only single call site and most of its parameters
>are redundant. Open code it to the call site. Remove illegit FIXME comment
>as there is no categorized bug and replace it with more sane comment about
>implementation (i.e. "non-opionated inline comment").
>
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

Seems like a reasonable cleanup.

Reviewed-by: Jonathan McDowell <noodles@earth.li>

>---
> security/keys/trusted-keys/trusted_tpm2.c | 51 ++++-------------------
> 1 file changed, 9 insertions(+), 42 deletions(-)
>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index c414a7006d78..8e3b283a59b2 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -198,36 +198,6 @@ int tpm2_key_priv(void *context, size_t hdrlen,
> 	return 0;
> }
>
>-/**
>- * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
>- *
>- * @buf: an allocated tpm_buf instance
>- * @session_handle: session handle
>- * @nonce: the session nonce, may be NULL if not used
>- * @nonce_len: the session nonce length, may be 0 if not used
>- * @attributes: the session attributes
>- * @hmac: the session HMAC or password, may be NULL if not used
>- * @hmac_len: the session HMAC or password length, maybe 0 if not used
>- */
>-static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
>-				 const u8 *nonce, u16 nonce_len,
>-				 u8 attributes,
>-				 const u8 *hmac, u16 hmac_len)
>-{
>-	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
>-	tpm_buf_append_u32(buf, session_handle);
>-	tpm_buf_append_u16(buf, nonce_len);
>-
>-	if (nonce && nonce_len)
>-		tpm_buf_append(buf, nonce, nonce_len);
>-
>-	tpm_buf_append_u8(buf, attributes);
>-	tpm_buf_append_u16(buf, hmac_len);
>-
>-	if (hmac && hmac_len)
>-		tpm_buf_append(buf, hmac, hmac_len);
>-}
>-
> /**
>  * tpm2_seal_trusted() - seal the payload of a trusted key
>  *
>@@ -507,19 +477,16 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 					    options->blobauth_len);
> 	} else {
> 		/*
>-		 * FIXME: The policy session was generated outside the
>-		 * kernel so we don't known the nonce and thus can't
>-		 * calculate a HMAC on it.  Therefore, the user can
>-		 * only really use TPM2_PolicyPassword and we must
>-		 * send down the plain text password, which could be
>-		 * intercepted.  We can still encrypt the returned
>-		 * key, but that's small comfort since the interposer
>-		 * could repeat our actions with the exfiltrated
>-		 * password.
>+		 * The policy session is generated outside the kernel, and thus
>+		 * the password will end up being unencrypted on the bus, as
>+		 * HMAC nonce cannot be calculated for it.
> 		 */
>-		tpm2_buf_append_auth(&buf, options->policyhandle,
>-				     NULL /* nonce */, 0, 0,
>-				     options->blobauth, options->blobauth_len);
>+		tpm_buf_append_u32(&buf, 9 + options->blobauth_len);
>+		tpm_buf_append_u32(&buf, options->policyhandle);
>+		tpm_buf_append_u16(&buf, 0);
>+		tpm_buf_append_u8(&buf, 0);
>+		tpm_buf_append_u16(&buf, options->blobauth_len);
>+		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
> 		if (tpm2_chip_auth(chip)) {
> 			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
> 		} else  {
>-- 
>2.39.5
>
>

J.

-- 
If a program is useful, it must be changed.

