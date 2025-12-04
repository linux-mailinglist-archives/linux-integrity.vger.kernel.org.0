Return-Path: <linux-integrity+bounces-7800-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE51CA5037
	for <lists+linux-integrity@lfdr.de>; Thu, 04 Dec 2025 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 901FB3087F6B
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Dec 2025 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1853469ED;
	Thu,  4 Dec 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFTuQf0X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314A345722;
	Thu,  4 Dec 2025 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764874190; cv=none; b=pGF9hrz8rFmMib/buvuPbNharRWYR98r0pH4jDWD2Z7v3bRnEUJw5hs+Dq/sw6GYd9kjg1uw8v6mlZNNmgwC5f0tjMOpui3j6JvhtcTLfAIPc+tq/tpVfcsdXyOpvJLVmBp0aXvj4QnMlKBGZ4NsSQRGEkz1eBIhbnt94Irhea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764874190; c=relaxed/simple;
	bh=ntEGzVbu3Nc47Kvk7Gkh2aUK/xS/Fh3L15HEk7QQ/fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl8ki4kxfqmdy2Z3yiekZg/zqrW/9P7tcynztybDlVleZqeEWz8GcXqhkPc7+dff08hbOZ2I0+2JnRVPzpPi00k1Z5MKLL1qHhdU1sl5ZtuLginatwx81xnV8Yk5XRPJHAj5XjpDGxqSc+Jj6dE2MG9uHzB88Zlr1wu3Og4MmO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFTuQf0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C6BC116C6;
	Thu,  4 Dec 2025 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764874189;
	bh=ntEGzVbu3Nc47Kvk7Gkh2aUK/xS/Fh3L15HEk7QQ/fA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFTuQf0Xv5R/jjyuqnqEglHAhN+0CDjLXH+2yQ2BkhdlNHsiYYTU22QD/xEo2rqBC
	 KRxEBB+c+/F/fvgaFkrHC7htj+I+eARYgr60d0JBIZd0ZZe5qPpfJB6r96J48OhvBg
	 MSXOWUgSNWBkaI+buWMNUIuADy98xN8bGX+UbFE4wuEmy2TLB0O65tZJxGPuHB2iuv
	 ntH1fColfdd46Fo/c+oUBcelcKjM0dbLNo/w4wLbZxImA+eobbHzolgClZkjmOeQ1Z
	 Uua5CGsq+S+93gUhV70Tbys6ZkybROlVt3YlgTpzTJphLh98DdGitcWKjxMmHnIOAF
	 CzVuNDnMxIahA==
Date: Thu, 4 Dec 2025 20:49:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 2/4] tpm2-sessions: Fix tpm2_read_public range checks
Message-ID: <aTHXyjlI06n_7K2e@kernel.org>
References: <20251203221215.536031-1-jarkko@kernel.org>
 <20251203221215.536031-3-jarkko@kernel.org>
 <aTGmuhRCbHANjjzV@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTGmuhRCbHANjjzV@earth.li>

On Thu, Dec 04, 2025 at 03:20:26PM +0000, Jonathan McDowell wrote:
> On Thu, Dec 04, 2025 at 12:12:12AM +0200, Jarkko Sakkinen wrote:
> > 'tpm2_read_public' has some rudimentary range checks but the function
> > does not ensure that the response buffer has enough bytes for the full
> > TPMT_HA payload.
> > 
> > Re-implement the function with necessary checks and validation.
> > 
> > Cc: stable@vger.kernel.org # v6.10+
> > Fixes: d0a25bb961e6 ("tpm: Add HMAC session name/handle append")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> A minor nit about variable naming, but:
> 
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> 
> > v2:
> > - Made the fix localized instead of spread all over the place.
> > ---
> > drivers/char/tpm/tpm2-cmd.c      |  3 ++
> > drivers/char/tpm/tpm2-sessions.c | 77 +++++++++++++++++---------------
> > 2 files changed, 44 insertions(+), 36 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index be4a9c7f2e1a..34e3599f094f 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -11,8 +11,11 @@
> >  * used by the kernel internally.
> >  */
> > 
> > +#include "linux/dev_printk.h"
> > +#include "linux/tpm.h"
> > #include "tpm.h"
> > #include <crypto/hash_info.h>
> > +#include <linux/unaligned.h>
> > 
> > static bool disable_pcr_integrity;
> > module_param(disable_pcr_integrity, bool, 0444);
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> > index a265e9752a5e..e9f439be3916 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -163,54 +163,59 @@ static int name_size(const u8 *name)
> > 	}
> > }
> > 
> > -static int tpm2_parse_read_public(char *name, struct tpm_buf *buf)
> > +static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
> > {
> > -	struct tpm_header *head = (struct tpm_header *)buf->data;
> > +	u32 mso = tpm2_handle_mso(handle);
> > 	off_t offset = TPM_HEADER_SIZE;
> > -	u32 tot_len = be32_to_cpu(head->length);
> > -	int ret;
> > -	u32 val;
> > -
> > -	/* we're starting after the header so adjust the length */
> > -	tot_len -= TPM_HEADER_SIZE;
> > -
> > -	/* skip public */
> > -	val = tpm_buf_read_u16(buf, &offset);
> > -	if (val > tot_len)
> > -		return -EINVAL;
> > -	offset += val;
> > -	/* name */
> > -
> > -	val = tpm_buf_read_u16(buf, &offset);
> > -	ret = name_size(&buf->data[offset]);
> > -	if (ret < 0)
> > -		return ret;
> > +	struct tpm_buf buf;
> > +	int rc, rc2;
> > 
> > -	if (val != ret)
> > +	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
> > +	    mso != TPM2_MSO_NVRAM)
> > 		return -EINVAL;
> > 
> > -	memcpy(name, &buf->data[offset], val);
> > -	/* forget the rest */
> > -	return 0;
> > -}
> > -
> > -static int tpm2_read_public(struct tpm_chip *chip, u32 handle, char *name)
> > -{
> > -	struct tpm_buf buf;
> > -	int rc;
> > -
> > 	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_READ_PUBLIC);
> > 	if (rc)
> > 		return rc;
> > 
> > 	tpm_buf_append_u32(&buf, handle);
> > -	rc = tpm_transmit_cmd(chip, &buf, 0, "read public");
> > -	if (rc == TPM2_RC_SUCCESS)
> > -		rc = tpm2_parse_read_public(name, &buf);
> > 
> > -	tpm_buf_destroy(&buf);
> > +	rc = tpm_transmit_cmd(chip, &buf, 0, "TPM2_ReadPublic");
> > +	if (rc) {
> > +		tpm_buf_destroy(&buf);
> > +		return tpm_ret_to_err(rc);
> > +	}
> > 
> > -	return rc;
> > +	/* Skip TPMT_PUBLIC: */
> > +	offset += tpm_buf_read_u16(&buf, &offset);
> > +
> > +	/*
> > +	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
> > +	 * TPMT_HA (the extra four bytes).
> > +	 */
> > +	if (offset + 4 > tpm_buf_length(&buf)) {
> > +		tpm_buf_destroy(&buf);
> > +		return -EIO;
> > +	}
> > +
> > +	rc = tpm_buf_read_u16(&buf, &offset);
> > +	rc2 = name_size(&buf.data[offset]);
> 
> rc2 is not great naming. We only use it for this, so perhaps name_len?

I'll rename it as 'name_size_alg' for the sake of clarity. It is TPM
name size mapped from algorithm ID. That should make the means and
purpose dead obvious.

BR, Jarkko

