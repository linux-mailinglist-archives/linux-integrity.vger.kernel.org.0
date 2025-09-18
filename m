Return-Path: <linux-integrity+bounces-7148-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32672B82ED1
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 07:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1FF467AFF
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 05:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B41A3166;
	Thu, 18 Sep 2025 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIq8H4S5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998D34BA43;
	Thu, 18 Sep 2025 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758171840; cv=none; b=LjP0Jz9bK6lEmdg7yBgUSBjRyW/emsHCxvlBkJNl9OGmRiHNzwiWkHBz0FTh4+zMi4+6UUe+C1KM0CBSlw4zkla/8Ex97D4b094Yqps/1oXgSJXOWDlXwRoVmiRr1dHQzfR9m3wITRrKNfpBCqdq5rarKM2gDdx3gHVXh7BO4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758171840; c=relaxed/simple;
	bh=xEw7pIOEI0A+4r0NalC4RyzD0RTXdu8oCCdB5ILHM7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl1kQ6OLI5Gy4WVzrfuvJq0GPWxpKJ2LNFN1fJs/FsKjT8krZou25hqzXMG1KouDxg2WB4L8uDDoWqxE0kkJm3CND/Y80wjx3BaKe2ueJqVXXRx71C8AuMEmClTQbwngVEgP1cWMRd0/CjIjRSWoSCUFLOKeRJf/ueNkW7AWBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIq8H4S5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EB9C4CEE7;
	Thu, 18 Sep 2025 05:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758171840;
	bh=xEw7pIOEI0A+4r0NalC4RyzD0RTXdu8oCCdB5ILHM7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIq8H4S5iX5eQavz4HsElGAnb6U1OegTvbPlPdlOwJLaYCxc/tv63xoHv7iHYmSDS
	 piGCD1/BG7CHtI+NtBVvgsa0YO2LUE5nd8jpL3oD77RkbXLY7XUfGI70bCQLvgvddO
	 u4v37IeYHJbRw7OBjVUCyj51MajmfeHl5+N6XOJDRKf5WRC/9TPZJZLjaQ8WSmP33u
	 +F2N6CPF1g7Z+FJLUGJ6560MfhK8VH8Ugs23mOyw+a6j66YSG+rzwU5+HOd52SGrXz
	 k+oCY+a242uZf2WEG6KGAjXu+sUupKmYNpXEUNvDfjpLhYisNfPOLY+g07C4UNALBp
	 T9z2j9nmf3+Qg==
Date: Thu, 18 Sep 2025 08:03:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	Andreas.Fuchs@infineon.com, James Prestwood <prestwoj@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-crypto@vger.kernel.org, Stefan Berger <stefanb@linux.ibm.com>,
	Lennart Poettering <lennart@poettering.net>,
	"David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v7 4/5] keys: asymmetric: Add tpm2_key_rsa
Message-ID: <aMuSvJNt2KdVBIOA@kernel.org>
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-5-jarkko@kernel.org>
 <ZmLnyp9j_QoPgj7W@gondor.apana.org.au>
 <D24EZPFV6DBS.1LZVHIVPITE83@kernel.org>
 <aK1vdEcuN_xjhjyY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK1vdEcuN_xjhjyY@kernel.org>

On Tue, Aug 26, 2025 at 11:25:24AM +0300, Jarkko Sakkinen wrote:
> On Thu, Jun 20, 2024 at 03:23:20AM +0300, Jarkko Sakkinen wrote:
> > On Fri Jun 7, 2024 at 1:58 PM EEST, Herbert Xu wrote:
> > > On Wed, May 29, 2024 at 12:08:09AM +0300, Jarkko Sakkinen wrote:
> > > >
> > > > +/*
> > > > + * Sign operation is an encryption using the TPM's private key. With RSA the
> > > > + * only difference between encryption and decryption is where the padding goes.
> > > > + * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed to do
> > > > + * encryption.
> > > > + */
> > > > +static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key *key,
> > > > +			     struct kernel_pkey_params *params,
> > > > +			     const void *in, void *out)
> > > > +{
> > > > +	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
> > > > +	const struct tpm2_rsa_parms *p =
> > > > +		(const struct tpm2_rsa_parms *)&key->data[o];
> > > > +	const u16 mod_size = be16_to_cpu(p->modulus_size);
> > > > +	const struct rsa_asn1_template *asn1;
> > > > +	u32 in_len = params->in_len;
> > > > +	void *asn1_wrapped = NULL;
> > > > +	u8 *padded;
> > > > +	int ret;
> > > > +
> > > > +	if (strcmp(params->encoding, "pkcs1") != 0) {
> > > > +		ret = -ENOPKG;
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	if (params->hash_algo) {
> > > > +		asn1 = rsa_lookup_asn1(params->hash_algo);
> > >
> > > Could you please explain why this can't be done through pkcs1pad
> > > instead of going to raw RSA?
> > 
> > Sorry was away couple of weeks from here. I replace this with TPM2_Sign
> > as is done already in the ECDSA module, so I guess that is a "yes".
> 
> Time travelling back to 2024 ;-)
> 
> I can't recall what I was thining here butI'm glad that I did not put
> the patch set further as now I have much more sane angle to this.
> 
> I realized while working on [1] that I'm better of making this to work
> as API on rsapubkey.asn1 and rsaprivkey.asn1 and matching files for
> ECC and do all steps inside kernel from this:
> 
> tpm2_createprimary --hierarchy o -G rsa2048 -c owner.txt
> tpm2_evictcontrol -c owner.txt 0x81000001
> tpm2_getcap handles-persistent
> openssl genrsa -out private.pem 2048
> tpm2_import -C 0x81000001 -G rsa -i private.pem -u key.pub -r key.priv
> tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o key.priv.pem
> openssl asn1parse -inform pem -in key.priv.pem -noout -out key.priv.der
> 
> I.e. my test tool does everything else except
> 
> openssl genrsa -out private.pem 2048
> 
> Im now pretty familiar with import procedure and how to prepare data
> for TPM2_Import and is like the "spirit" of it i.e., take external
> key and store it inside TPM2. That as side effect removes all the
> use of tpm2key.asn1 from the patch set and simplifies flows
> greatly.
> 
> And my Rust works help to get the preparation procedure exactly
> right and none of those crazy tools and commands will be needed.
> 
> The matching C code following TCG Architecture spec  I'll first write in
> user space and then port that kernel crypto APIs
> 
> That spans a question tho: should it be its own key type (as it is
> right now or would it be better idea to have parameter/option for
> hardware pre-existing RSA key types, or what would be the best
> direction API wise to approach this?

This response was filled wrong conclusions. The current
separate key types is the correct path. It's best to use TpmKey ASN.1
import as the keys might also source from TPM2_Create command, not
necessarily necessarily from external source, or at least it would be
stupid to limit it to only external keys.

So yeah two options to get this finally somehere are either pkcs1pad
route or more likely to change this to use TPM2_Sign, which should
be able to address padding internally at the chip.

Also I think RSA key should only expose here signinig operation for
the time being and encryption should be something reconsidered later
(if ever).

Just had a such a long pause since I've revisited this that did not
recall the reasoning why it was implemeted like it was.


BR, Jarkko

