Return-Path: <linux-integrity+bounces-7318-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29023BACE17
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 14:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676027A191D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69D2BDC33;
	Tue, 30 Sep 2025 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZtOb4jT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7F34BA29;
	Tue, 30 Sep 2025 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235947; cv=none; b=Dk5DmR/UoHDed6zV8Aicp10D37QRHUhNjvsNbreLMuEOGwKq0heHvVnLaNlpXGLbu4HyiLLDiOzTRINrc4F5m0AmVbNqHQPlrapxNKPaV8A7b7hsvgcIsfVo0nFV201X/2u7hPi1IDvxfb1/gymnSWhsvtD3vaZCPiwshHBbsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235947; c=relaxed/simple;
	bh=FH7YiuqsbnWq/LnI9Rcmaje4Dk1Lpe5UJ99+64McSr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzFztlCHz5SCGe8z41GkxAUkdZvCYZT0pQpluAwVkk3cE00YapVJOdi1YQcTf7dKZgg4r08rWdOilPDzoF3NW7nUrRlbEh+zoq+XbxumPUXGLskJIOK8S5/iiypYNuh14ZnkUcZ8OZUg/q8ytT09APF53dy00QTTqY4QrjH0Zh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZtOb4jT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1669C4CEF0;
	Tue, 30 Sep 2025 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759235946;
	bh=FH7YiuqsbnWq/LnI9Rcmaje4Dk1Lpe5UJ99+64McSr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZtOb4jThe5hbr+Tyqyy0BX4IP44qyIJzByuIFNsfqHVVknUpDU63py3n8kqkXCVm
	 Dix4XQFJg9O4rP0F22GQ3Ete/n3Ec9hefJxp3G0JOyuekpTrNKEHhC2Dgi64LYkXDU
	 S0uYWNtPXOu8+Ohp9jBUHyTM0hnxuqIQAadcJ6epWuDKal/FJQl+5DucQfOFBXa5eZ
	 bx9uCAcnx5kKFgHaw+MAOUr7sh0ay1QWn1+GUPkANq/IalMH8ErGqBgZ3XBVMxCjS6
	 rEWnnLneqTXWv/FQdHcOYA2/oH/S35FVfhQvg95DlyOE4bmMzaOM+DcT6C3/Kgc0JB
	 F07dSaOF4JuPQ==
Date: Tue, 30 Sep 2025 15:39:02 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 03/10] KEYS: trusted: Use tpm_ret_to_err() in
 trusted_tpm2
Message-ID: <aNvPZmoF7ygfkYMq@kernel.org>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-4-jarkko@kernel.org>
 <7icpto3rnm2f4u6zaxl4xy7zvar3q4hhpgelq2gnazszdkwc3m@5dtivkqs5xdg>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7icpto3rnm2f4u6zaxl4xy7zvar3q4hhpgelq2gnazszdkwc3m@5dtivkqs5xdg>

On Tue, Sep 30, 2025 at 02:12:35PM +0200, Stefano Garzarella wrote:
> On Mon, Sep 29, 2025 at 10:48:25PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Use tpm_ret_to_err() to transmute TPM return codes in trusted_tpm2.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > v3:
> > - No changes.
> > v2:
> > - New patch split out from the fix.
> > ---
> > security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> > 1 file changed, 7 insertions(+), 19 deletions(-)
> 
> Nice clean up!
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Thank you.

> 
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
> > 
> 

BR, Jarkko

