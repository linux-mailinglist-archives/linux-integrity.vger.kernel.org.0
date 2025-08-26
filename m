Return-Path: <linux-integrity+bounces-6918-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0ACB356BF
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 10:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B902918874B5
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 08:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563322877DA;
	Tue, 26 Aug 2025 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usCqbP7u"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248892AE8D;
	Tue, 26 Aug 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196729; cv=none; b=Peqqe+TKLsl0op5KN0KKYJ5+jrUA19mEg/BciFtDiOvfefOyuXTJGpflokYmlFqx6lGZDVVMsshO30rP6jo1dl6CBgzwySic9uQO2jcgPLCp+ajb6cM3t8RghR3B7OlVnFK20iPSy13smAPcZuuaM33iIN9pQIBoAXK9yP3JKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196729; c=relaxed/simple;
	bh=VkeszMZY1ksdwbOs73xgWaFT2kBLSssyVgThE5cmC1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsGk6KVALGLQly6syq0a5kf608D4+mjc1bW509WHW2VNNcN1G7iQvmYEmhSpkPu/Ewq1Mr5zUtQE4wOJCb2nxVPx1zokp1e/ygt+Yx1lvl+xKEhzzPb7TPW3nzeeQHYIJBvV7ck1o21j7GnSSyiKrLVHoxrjWKDNeHiYmx0ZW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usCqbP7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2586BC4CEF1;
	Tue, 26 Aug 2025 08:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756196728;
	bh=VkeszMZY1ksdwbOs73xgWaFT2kBLSssyVgThE5cmC1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usCqbP7uRNQ13YBhnWf1Zp3LRYsBKqu9s5ZGGYDjRlye9lEVBvycZ/a1VLH9/QqAS
	 05y4bWzLtoV7x+7zQ88isnbgga89Ei82D+NnIk/gGnB7BeADgNPnPxGCRw1jIRSpOo
	 j96cUSDlXjWNJs/al4euZUYjJccKcrQoy9M4N9Ith4QrHWkE9qkuPv2yq7S7JNU0Fb
	 j/3bUpJMDW4zlVcHH/qfntY4p6sSgDiW8WAoE0Bfv7/mvx4wCpGxqPJNJckF+DfrdW
	 aaQRM5QUzqmwP4hc2YpG+q+A5UJpgTgZYAtCDoDMlFZRKSE5GL1Tig5J6VAmC48TM3
	 UDprsaBEvhw4Q==
Date: Tue, 26 Aug 2025 11:25:24 +0300
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
Message-ID: <aK1vdEcuN_xjhjyY@kernel.org>
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-5-jarkko@kernel.org>
 <ZmLnyp9j_QoPgj7W@gondor.apana.org.au>
 <D24EZPFV6DBS.1LZVHIVPITE83@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D24EZPFV6DBS.1LZVHIVPITE83@kernel.org>

On Thu, Jun 20, 2024 at 03:23:20AM +0300, Jarkko Sakkinen wrote:
> On Fri Jun 7, 2024 at 1:58 PM EEST, Herbert Xu wrote:
> > On Wed, May 29, 2024 at 12:08:09AM +0300, Jarkko Sakkinen wrote:
> > >
> > > +/*
> > > + * Sign operation is an encryption using the TPM's private key. With RSA the
> > > + * only difference between encryption and decryption is where the padding goes.
> > > + * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed to do
> > > + * encryption.
> > > + */
> > > +static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key *key,
> > > +			     struct kernel_pkey_params *params,
> > > +			     const void *in, void *out)
> > > +{
> > > +	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
> > > +	const struct tpm2_rsa_parms *p =
> > > +		(const struct tpm2_rsa_parms *)&key->data[o];
> > > +	const u16 mod_size = be16_to_cpu(p->modulus_size);
> > > +	const struct rsa_asn1_template *asn1;
> > > +	u32 in_len = params->in_len;
> > > +	void *asn1_wrapped = NULL;
> > > +	u8 *padded;
> > > +	int ret;
> > > +
> > > +	if (strcmp(params->encoding, "pkcs1") != 0) {
> > > +		ret = -ENOPKG;
> > > +		goto err;
> > > +	}
> > > +
> > > +	if (params->hash_algo) {
> > > +		asn1 = rsa_lookup_asn1(params->hash_algo);
> >
> > Could you please explain why this can't be done through pkcs1pad
> > instead of going to raw RSA?
> 
> Sorry was away couple of weeks from here. I replace this with TPM2_Sign
> as is done already in the ECDSA module, so I guess that is a "yes".

Time travelling back to 2024 ;-)

I can't recall what I was thining here butI'm glad that I did not put
the patch set further as now I have much more sane angle to this.

I realized while working on [1] that I'm better of making this to work
as API on rsapubkey.asn1 and rsaprivkey.asn1 and matching files for
ECC and do all steps inside kernel from this:

tpm2_createprimary --hierarchy o -G rsa2048 -c owner.txt
tpm2_evictcontrol -c owner.txt 0x81000001
tpm2_getcap handles-persistent
openssl genrsa -out private.pem 2048
tpm2_import -C 0x81000001 -G rsa -i private.pem -u key.pub -r key.priv
tpm2_encodeobject -C 0x81000001 -u key.pub -r key.priv -o key.priv.pem
openssl asn1parse -inform pem -in key.priv.pem -noout -out key.priv.der

I.e. my test tool does everything else except

openssl genrsa -out private.pem 2048

Im now pretty familiar with import procedure and how to prepare data
for TPM2_Import and is like the "spirit" of it i.e., take external
key and store it inside TPM2. That as side effect removes all the
use of tpm2key.asn1 from the patch set and simplifies flows
greatly.

And my Rust works help to get the preparation procedure exactly
right and none of those crazy tools and commands will be needed.

The matching C code following TCG Architecture spec  I'll first write in
user space and then port that kernel crypto APIs

That spans a question tho: should it be its own key type (as it is
right now or would it be better idea to have parameter/option for
hardware pre-existing RSA key types, or what would be the best
direction API wise to approach this?

[1] https://lore.kernel.org/tpm2/aKzaTYCI2GO_UPRB@kernel.org/T/#u

BR, Jarkko

