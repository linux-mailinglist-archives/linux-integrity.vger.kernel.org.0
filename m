Return-Path: <linux-integrity+bounces-7266-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF976B98E55
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 10:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F8B17BCC8
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413C2848A9;
	Wed, 24 Sep 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="O9Dwn1OX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED4283FEF;
	Wed, 24 Sep 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702763; cv=none; b=Mu3YElHz0njdUMmbpCKUTRWEppKQelt5FC5GuyDk1dDkR28Jq1KSxBS7sFRftDxarIi1y9tF5tf3w0WnWhgCwWut6Rpb5ds393tAmTiR+OqhYfBmDQliNZjbnWKvTsdLwUqJ+kdrZ9Hlksqu3EGkE1eFnikePbWl1Nh0luA1h+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702763; c=relaxed/simple;
	bh=cLezCJAwAqkORNPG2HLqUibKGtDN8FG7pnsNn8TTtQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beYzcgmnn2a7y2JjY1btvp9yO+XNfmnSlG0lswrlxeH2XSgShtQnGy6UUejIdZpRiCDyz5moGmzUzJ7mEg3jqdcGwts+5IPjUHN5+GrX7h+RrNFDzyNWKVdwIh83BapphSiyeflwCSiJvlqZMMURce6wmOIav1S8lqGkIo7ofXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=O9Dwn1OX; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RyV9TsLTTABJTwKwOuUIKaaq22w3uW9zvHP3pAU/Okk=; b=O9Dwn1OXZKG8McfoWulnOThMgd
	b7B+c1uIUc0+gKEdI6chrGk3TEv9Kr57JYsfx3yVaCRd5kdGv2g2lO/UNzBQCnUBJUSb/E4yZD0pH
	sQwUWtzn761xZRh/AdrYcYyQ1XekEPLqv/a55MSS+p5HqGivZNjekAIYN5PSr4Ln9ikUf+S/7vnUp
	PMrfWODHAkoxis3P6f/nLajknhwWp+1Wx4ddKy/ibg6Zmr2f2gTc+oKWQb06Ae1WvwsRpREebdVyM
	k2102/mtG6kYPdzRjnh+drIXIefqd3OnA2bZJYjDIGJXa/rCNE0/Vs0B1otoc+DoYfem3ddrvO4q9
	2YQGUQoQ==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v1KvR-00EFVU-15;
	Wed, 24 Sep 2025 09:32:33 +0100
Date: Wed, 24 Sep 2025 09:32:33 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/4] tpm: Use -EPERM as fallback error code in
 tpm_ret_to_err
Message-ID: <aNOsoVOZPXns6WB2@earth.li>
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-2-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250922164318.3540792-2-jarkko@kernel.org>

On Mon, Sep 22, 2025 at 07:43:14PM +0300, Jarkko Sakkinen wrote:
>From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>
>Using -EFAULT here was not the best idea for tpm_ret_to_err as the fallback
>error code as it is no concise with trusted keys.
>
>Change the fallback as -EPERM, process TPM_RC_HASH also in tpm_ret_to_err,
>and by these changes make the helper applicable for trusted keys.
>
>Fixes: 539fbab37881 ("tpm: Mask TPM RC in tpm2_start_auth_session()")
>Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>---
> include/linux/tpm.h                       |  9 +++++---
> security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> 2 files changed, 13 insertions(+), 22 deletions(-)
>
>diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>index dc0338a783f3..667d290789ca 100644
>--- a/include/linux/tpm.h
>+++ b/include/linux/tpm.h
>@@ -449,13 +449,16 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> 	if (ret < 0)
> 		return ret;
>
>-	switch (tpm2_rc_value(ret)) {
>-	case TPM2_RC_SUCCESS:
>+	if (!ret)
> 		return 0;

Fold this into the check above to get:

	if (ret <= 0)

?

>+
>+	switch (tpm2_rc_value(ret)) {
> 	case TPM2_RC_SESSION_MEMORY:
> 		return -ENOMEM;
>+	case TPM2_RC_HASH:
>+		return -EINVAL;
> 	default:
>-		return -EFAULT;
>+		return -EPERM;
> 	}
> }
>
>diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>index 024be262702f..e165b117bbca 100644
>--- a/security/keys/trusted-keys/trusted_tpm2.c
>+++ b/security/keys/trusted-keys/trusted_tpm2.c
>@@ -348,25 +348,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> 	}
>
> 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
>+	if (blob_len < 0)
>+		rc = blob_len;
>
> out:
> 	tpm_buf_destroy(&sized);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0) {
>-		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
>-			rc = -EINVAL;
>-		else
>-			rc = -EPERM;
>-	}
>-	if (blob_len < 0)
>-		rc = blob_len;
>-	else
>+	if (!rc)
> 		payload->blob_len = blob_len;
>
> out_put:
> 	tpm_put_ops(chip);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -468,10 +462,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> 		kfree(blob);
> 	tpm_buf_destroy(&buf);
>
>-	if (rc > 0)
>-		rc = -EPERM;
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -534,8 +525,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> 	tpm_buf_fill_hmac_session(chip, &buf);
> 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
> 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
>-	if (rc > 0)
>-		rc = -EPERM;
>
> 	if (!rc) {
> 		data_len = be16_to_cpup(
>@@ -568,7 +557,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>
> out:
> 	tpm_buf_destroy(&buf);
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>
> /**
>@@ -600,6 +589,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
>
> out:
> 	tpm_put_ops(chip);
>-
>-	return rc;
>+	return tpm_ret_to_err(rc);
> }
>-- 
>2.39.5
>
>

J.

-- 
Web [  Sleep?  Isn't that some inferior replacement for caffeine?  ]
site: https:// [                                          ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24

