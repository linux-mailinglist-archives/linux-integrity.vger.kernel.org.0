Return-Path: <linux-integrity+bounces-7239-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B55B9654C
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B4C3AFEE1
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Sep 2025 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C42157A6B;
	Tue, 23 Sep 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQrD8pIx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B423A989;
	Tue, 23 Sep 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638112; cv=none; b=h92wZP3LlxCc4yF4VBUHw9/lt90FDSQ7rfGjNdAVwz17unUxkyU9Jn0L492ONVoSKxPl+FUmDwOuZ6aHTS3DHRrPn2Ef+1dPYOl0VV7OK+qGgfq1j61KIgTi9w18G1eFkYVr1XRWo9/pGkiSmHFl25RP473xhFeR8v4ePS5wUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638112; c=relaxed/simple;
	bh=lk7dIsuWICp06xrsWrHrfsHtjecVw9bVejsvuGuCMrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpNjaPygZtfLp/Quu/iplSv+5OAhwH5zqrxNGx+QQH+VU/4BXVnDOCl50yH+u7jnvpb+HCdRZkySPxb39QVJ9jUQH9A7rtd8ONEOnmMnVto6Q3WjbfaL/QTqY9/Df6vOisSzRyfbUAXaF2IsWMT7z8GKo8g4HK8FNhLs5YgJcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQrD8pIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65976C4CEF5;
	Tue, 23 Sep 2025 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758638111;
	bh=lk7dIsuWICp06xrsWrHrfsHtjecVw9bVejsvuGuCMrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQrD8pIxRlw9IDlRvkNgfGIILlA8hs0HUHOi3fE4LRYy67TuvSTLg7+YhApNbAsqG
	 f5bGU8pm2nTQbJer6J8NVrv/051hj8i6IIzXvNkiWEYDqfEAiQlEfrbb2ng4PPOC6z
	 wJ4JIcCj22LVnAaDjjjOuOzg8I5GpeAlKVa1ygxBOMarTRLMprJR9ng+sFffOs5noq
	 JdqFjs1oNB/uX1Kk3IJR5FOBAY+GfcKBdoOgO/Cxja3JeCKvoMv2AUpWzOOizEY+aF
	 uQLlfln8Vm4xcSeCYBDAKNOCvoRSziVAj9VCsdSycU6vyweN9spi7IV0LyL/DuwHwt
	 eTmRFQX4j4LZA==
Date: Tue, 23 Sep 2025 17:35:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Use -EPERM as fallback error code in tpm_ret_to_err
Message-ID: <aNKwG2Q6AG3BNB2c@kernel.org>
References: <20250922072332.2649135-1-jarkko@kernel.org>
 <tnxfamnvxoanaihka3em7ktmzkervoea43zn2l3mqxvnuivb6n@p5nn34vns3zf>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tnxfamnvxoanaihka3em7ktmzkervoea43zn2l3mqxvnuivb6n@p5nn34vns3zf>

On Mon, Sep 22, 2025 at 11:25:42AM +0200, Stefano Garzarella wrote:
> On Mon, Sep 22, 2025 at 10:23:32AM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Using -EFAULT here was not the best idea for tpm_ret_to_err as the fallback
> > error code as it is no concise with trusted keys.
> > 
> > Change the fallback as -EPERM, process TPM_RC_HASH also in tpm_ret_to_err,
> > and by these changes make the helper applicable for trusted keys.
> > 
> > Cc: stable@vger.kernel.org # v6.15+
> > Fixes: 539fbab37881 ("tpm: Mask TPM RC in tpm2_start_auth_session()")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > include/linux/tpm.h                       |  9 +++++---
> > security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> > 2 files changed, 13 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index dc0338a783f3..667d290789ca 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -449,13 +449,16 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> > 	if (ret < 0)
> > 		return ret;
> > 
> > -	switch (tpm2_rc_value(ret)) {
> > -	case TPM2_RC_SUCCESS:
> 
> I slightly prefer the `case TPM2_RC_SUCCESS` but I don't have a strong
> opinion.
> 
> > +	if (!ret)
> > 		return 0;
> 
> If we want to remove the `case TPM2_RC_SUCCESS`, can we just merge this
> condition with the if on top, I mean:
> 
> 	if (ret <= 0)
> 		return ret;

I can cope with this i.e. revert back, it's not really part of the scope
and was totally intentional

> 
> > +
> > +	switch (tpm2_rc_value(ret)) {
> > 	case TPM2_RC_SESSION_MEMORY:
> > 		return -ENOMEM;
> > +	case TPM2_RC_HASH:
> > +		return -EINVAL;
> > 	default:
> > -		return -EFAULT;
> > +		return -EPERM;
> > 	}
> > }
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 024be262702f..e165b117bbca 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -348,25 +348,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> > 	}
> > 
> > 	blob_len = tpm2_key_encode(payload, options, &buf.data[offset], blob_len);
> > +	if (blob_len < 0)
> > +		rc = blob_len;
> > 
> > out:
> > 	tpm_buf_destroy(&sized);
> > 	tpm_buf_destroy(&buf);
> > 
> > -	if (rc > 0) {
> > -		if (tpm2_rc_value(rc) == TPM2_RC_HASH)
> > -			rc = -EINVAL;
> > -		else
> > -			rc = -EPERM;
> > -	}
> > -	if (blob_len < 0)
> 
> nit: since `blob_len` is not accessed anymore in the error path, can we
> avoid to set it to 0 when declaring it?
> 
> Thanks,
> Stefano
> 
> > -		rc = blob_len;
> > -	else
> > +	if (!rc)
> > 		payload->blob_len = blob_len;
> > 
> > out_put:
> > 	tpm_put_ops(chip);
> > -	return rc;
> > +	return tpm_ret_to_err(rc);
> > }
> > 
> > /**
> > @@ -468,10 +462,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
> > 		kfree(blob);
> > 	tpm_buf_destroy(&buf);
> > 
> > -	if (rc > 0)
> > -		rc = -EPERM;
> > -
> > -	return rc;
> > +	return tpm_ret_to_err(rc);
> > }
> > 
> > /**
> > @@ -534,8 +525,6 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> > 	tpm_buf_fill_hmac_session(chip, &buf);
> > 	rc = tpm_transmit_cmd(chip, &buf, 6, "unsealing");
> > 	rc = tpm_buf_check_hmac_response(chip, &buf, rc);
> > -	if (rc > 0)
> > -		rc = -EPERM;
> > 
> > 	if (!rc) {
> > 		data_len = be16_to_cpup(
> > @@ -568,7 +557,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
> > 
> > out:
> > 	tpm_buf_destroy(&buf);
> > -	return rc;
> > +	return tpm_ret_to_err(rc);
> > }
> > 
> > /**
> > @@ -600,6 +589,5 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
> > 
> > out:
> > 	tpm_put_ops(chip);
> > -
> > -	return rc;
> > +	return tpm_ret_to_err(rc);
> > }
> > -- 
> > 2.39.5
> > 
> 

BR, Jarkko

