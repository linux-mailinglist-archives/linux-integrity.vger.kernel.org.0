Return-Path: <linux-integrity+bounces-7523-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95AC07D0E
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 20:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A320F1AA1CE8
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB753451C9;
	Fri, 24 Oct 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usTsn1SF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4530BB97;
	Fri, 24 Oct 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331763; cv=none; b=SJYy3NDatoyhJ6ZenpvDT9Use9JiKvanvjTUpnsqLsLGmO01/y7pMRixPRyjJRlTyWrgcpJArkfJH0JLm6l2nREPSPd7CLnYJ5NyTreZ4SNSmnbxc8k3NK+kVOEPCexUjBy0SLqItlLYRvKf0WlScwmGx6BQo0Uh12Sh8oyBM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331763; c=relaxed/simple;
	bh=m2hG588lr+ZDX3+zgtXdvSd6rN2Scyj1sP9/47ZL4ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB3WPWLyN+Vv04nlzkPetLbcRCyXt2LIw4Ag2RG0HPGbk7DFb5EQ//jxxjGhYFfoq7wcFA170ZNoKEqnQzpwX0V7+NsDm4ttGIUzqoOAJc7CUVu3eM7CjhE9o3MwpEKFXpCsUmJ2+3CH+vTCHmCko3Kc7pBPGcxUr7JxOazYraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usTsn1SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81733C4CEF1;
	Fri, 24 Oct 2025 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761331762;
	bh=m2hG588lr+ZDX3+zgtXdvSd6rN2Scyj1sP9/47ZL4ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usTsn1SFVlCJOQ+Is77PDZ3TLouCjGUzC+AmY4KGYDTgrcueMfygC9pGeMlkZfoH1
	 XKa7rppvvancXyU3cOdb8HVjRB3EjnDkl9Y2PzMZxeGW9KDKtnYfN2oFHCheJDmn13
	 pVamjpD2VIfnsZGmIQZXvahckqfQD4ext2XkRue7X3RDbnulngQBmJKcdXWq1Fsddh
	 3dF7ZsKHGWp0sqXhNm2stxxQ0uYlcgR47w6Q+1OwAezk22SMPHMkjbSi3xzIxgNHAO
	 hX6B6zB68+Ib0oYH1CT6+N0U1JPDeDrUF6hy0opRypmFqP2nXIU+J3Q+92vXD12aQL
	 aXsSCgWFhca3A==
Date: Fri, 24 Oct 2025 21:49:17 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-integrity@vger.kernel.org, keyring@vger.kernel.org,
	dpsmith@apertussolutions.com, ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 10/10] tpm-buf: Enable managed and stack allocations.
Message-ID: <aPvKLYMtXZeQnA5D@kernel.org>
References: <20251018111725.3116386-1-jarkko@kernel.org>
 <20251018111725.3116386-11-jarkko@kernel.org>
 <yynqxoqux5whcbsnticikhwmupqh57xfbll5egzkn42kj7gkaf@s4kwxfmto5ia>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yynqxoqux5whcbsnticikhwmupqh57xfbll5egzkn42kj7gkaf@s4kwxfmto5ia>

On Mon, Oct 20, 2025 at 11:04:51AM +0200, Stefano Garzarella wrote:
> On Sat, Oct 18, 2025 at 02:17:25PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Decouple kzalloc from buffer creation, so that a managed allocation can be
> > done trivially:
> > 
> > 	struct tpm_buf *buf __free(kfree) buf = kzalloc(TPM_BUFSIZE,
> > 							GFP_KERNEL);
> > 	if (!buf)
> > 		return -ENOMEM;
> > 	tpm_buf_init(buf, TPM_BUFSIZE);
> > 
> > Alternatively, stack allocations are also possible:
> > 
> > 	u8 buf_data[512];
> > 	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
> > 	tpm_buf_init(buf, sizeof(buf_data));
> > 
> > Given that every single tpm_transmit_cmd() call site needs to be changed,
> > place command names from TCG 1.2 and 2.0 specifications to the @dest
> > parameter, which will e.g., help tracing bugs.
> 
> Perhaps my previous message fell through the cracks, but I still have a
> couple of comments (perhaps trivial, sorry in that case) that have not been
> answered about this patch:

I think what happened is that there was enough time that I forgot what
I had or hadn't done :-) I'll address your comments.

> 
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> > v6
> > - Update commit message.
> > v5:
> > - There was a spurious change in tpm2_seal_trusted() error
> >  code handling introduce by this patch.
> > v4:
> > - Since every single tpm_transmit_cmd() call site needs to be
> >  changed anyhow, use 'dest' parameter more structured and
> >  actually useful way, and pick the string TCG 1.2 and 2.0
> >  specifications.
> > - tpm1-cmd: Remove useless rc declarations and repliace them
> >  with trivial "return tpm_transmit_cmd" statement.
> > - Reverted spurious changes in include/linux/tpm.h.
> > - Use concisely TPM_BUFSIZE instead of PAGE_SIZE.
> > v3:
> > - A new patch from the earlier series with more scoped changes and
> >  less abstract commit message.
> > ---
> > drivers/char/tpm/tpm-buf.c                | 122 +++++----
> > drivers/char/tpm/tpm-sysfs.c              |  21 +-
> > drivers/char/tpm/tpm.h                    |   1 -
> > drivers/char/tpm/tpm1-cmd.c               | 162 +++++-------
> > drivers/char/tpm/tpm2-cmd.c               | 299 ++++++++++------------
> > drivers/char/tpm/tpm2-sessions.c          | 122 +++++----
> > drivers/char/tpm/tpm2-space.c             |  44 ++--
> > drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +--
> > include/linux/tpm.h                       |  18 +-
> > security/keys/trusted-keys/trusted_tpm1.c |  34 ++-
> > security/keys/trusted-keys/trusted_tpm2.c | 175 ++++++-------
> > 11 files changed, 484 insertions(+), 544 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> > index 1b9dee0d0681..a3bf3c3d0c48 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> 
> [...]
> 
> > @@ -92,6 +119,9 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
> >  */
> > u32 tpm_buf_length(struct tpm_buf *buf)
> 
> Should we update the return value to u16?

Ack.

> 
> 
> > {
> > +	if (buf->flags & TPM_BUF_INVALID)
> > +		return 0;
> > +
> > 	return buf->length;
> > }
> > EXPORT_SYMBOL_GPL(tpm_buf_length);
> 
> [...]
> 
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index 636acb66a4f6..3ac204a902de 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -310,9 +310,8 @@ static int TSS_checkhmac2(unsigned char *buffer,
> >  * For key specific tpm requests, we will generate and send our
> >  * own TPM command packets using the drivers send function.
> >  */
> > -static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
> > +static int trusted_tpm_send(void *cmd, size_t buflen)
> > {
> > -	struct tpm_buf buf;
> > 	int rc;
> > 
> > 	if (!chip)
> > @@ -322,15 +321,12 @@ static int trusted_tpm_send(unsigned char *cmd, size_t buflen)
> > 	if (rc)
> > 		return rc;
> > 
> > -	buf.flags = 0;
> > -	buf.length = buflen;
> > -	buf.data = cmd;
> > 	dump_tpm_buf(cmd);
> > -	rc = tpm_transmit_cmd(chip, &buf, 4, "sending data");
> > +	rc = tpm_transmit_cmd(chip, cmd, 4, "sending data");
> 
> Is it fine here to remove the intermediate tpm_buf ?
> 
> IIUC tpm_transmit_cmd() needs a tpm_buf, while here we are passing just
> the "data", or in some way it's a nested tpm_buf?

This does not look right at all. I'll fix it and add automated test
suite for TPM 1.x to my standard test shenanigans so that I can
continuously test its correctness [1]. It anyhow should have TPM 1.2
tests (especially for trusted keys). As it becomes more rare
accidental bugs could easily hover in.

Thanks, this was really good catch. I'll address both bug and make
sure that I don't do the same mistake twice :-)

> 
> > 	dump_tpm_buf(cmd);
> > 
> > +	/* Convert TPM error to -EPERM. */
> > 	if (rc > 0)
> > -		/* TPM error */
> > 		rc = -EPERM;
> > 
> > 	tpm_put_ops(chip);
> 
> Thanks,
> Stefano
> 

[1] https://codeberg.org/jarkko/linux-tpmdd-test

BR, Jarkko

