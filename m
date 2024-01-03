Return-Path: <linux-integrity+bounces-633-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED22823094
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9778A285CA0
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 15:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B821B273;
	Wed,  3 Jan 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MW48QkkJ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MW48QkkJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95051B272;
	Wed,  3 Jan 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704295895;
	bh=UQvhsnGSpV/EWl0XpntG3HXlkzaoYbazK99y+TlLzkM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MW48QkkJkcg8doCQs1BIGCYwrRlPYeeF6jiS2oApXo9esYeFnQJJxyGTSZFRXowQp
	 HC2Dn1A//Oi1stn+Lw3bRAAMXEiG7Mis5VL1l2QqSblRjBMWHyfAOsClewxUSrdY72
	 EDEknzyweynEupIVGODtlstBBU+kqyHYyNpeRMzM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D82EF1286D2B;
	Wed,  3 Jan 2024 10:31:35 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id iI0swpkofHHk; Wed,  3 Jan 2024 10:31:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1704295895;
	bh=UQvhsnGSpV/EWl0XpntG3HXlkzaoYbazK99y+TlLzkM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=MW48QkkJkcg8doCQs1BIGCYwrRlPYeeF6jiS2oApXo9esYeFnQJJxyGTSZFRXowQp
	 HC2Dn1A//Oi1stn+Lw3bRAAMXEiG7Mis5VL1l2QqSblRjBMWHyfAOsClewxUSrdY72
	 EDEknzyweynEupIVGODtlstBBU+kqyHYyNpeRMzM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EDF361286AD1;
	Wed,  3 Jan 2024 10:31:34 -0500 (EST)
Message-ID: <926f031e15739ea9044c8aaa7bbe72ab18a8f3c5.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 13/20] tpm: Add HMAC session start and end functions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 03 Jan 2024 10:31:33 -0500
In-Reply-To: <CY566RG0WK3A.21KMYFHM9R6UR@suppilovahvero>
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
	 <20240102170408.21969-14-James.Bottomley@HansenPartnership.com>
	 <CY566RG0WK3A.21KMYFHM9R6UR@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-01-03 at 17:18 +0200, Jarkko Sakkinen wrote:
> On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
> > Add session  based HMAC  authentication plus parameter  decryption
> > and
> > response encryption  using AES. The  basic design is to  segregate
> > all
> > the nasty crypto, hash and hmac code into tpm2-sessions.c and
> > export a
> > usable API.  The API first of all starts off by gaining a session
> > with
> > tpm2_start_auth_session() which  initiates a session with  the TPM
> > and
> > allocates  an  opaque  tpm2_auth   structure  to  handle  the 
> > session
> > parameters.  The  design is that  session use will be  single
> > threaded
> > from start to finish under the ops lock, so the tpm2_auth structure
> > is
> > stored in struct tpm2_chip to simpify the externally visible API.
> > 
> > The session can be ended with tpm2_end_auth_session() which is
> > designed only to be used in error legs.  Ordinarily the further
> > session API (future patches) will end or continue the session
> > appropriately without having to call this.
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto
> > API parts
> > 
> > ---
> > 
> > v6: split into new patch, update config variable
> > ---
> >  drivers/char/tpm/Kconfig         |   3 +
> >  drivers/char/tpm/tpm-buf.c       |   1 +
> >  drivers/char/tpm/tpm-chip.c      |   3 +
> >  drivers/char/tpm/tpm2-sessions.c | 383
> > +++++++++++++++++++++++++++++++
> >  include/linux/tpm.h              |  34 +++
> >  5 files changed, 424 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index e3c39a83171b..086cb8588493 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -30,6 +30,9 @@ if TCG_TPM
> >  config TCG_TPM2_HMAC
> >         bool "Use encrypted and HMACd transactions on the TPM bus"
> >         default y
> > +       select CRYPTO_ECDH
> > +       select CRYPTO_LIB_AESCFB
> > +       select CRYPTO_LIB_SHA256
> >         help
> >            Setting this causes us to deploy a scheme which uses
> > request
> >           and response HMACs in addition to encryption for
> > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-
> > buf.c
> > index bb81180495d1..274130398569 100644
> > --- a/drivers/char/tpm/tpm-buf.c
> > +++ b/drivers/char/tpm/tpm-buf.c
> > @@ -44,6 +44,7 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag,
> > u32 ordinal)
> >         head->tag = cpu_to_be16(tag);
> >         head->length = cpu_to_be32(sizeof(*head));
> >         head->ordinal = cpu_to_be32(ordinal);
> > +       buf->handles = 0;
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_buf_reset);
> >  
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-
> > chip.c
> > index 42b1062e33cd..d93937326b2e 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -275,6 +275,9 @@ static void tpm_dev_release(struct device *dev)
> >         kfree(chip->work_space.context_buf);
> >         kfree(chip->work_space.session_buf);
> >         kfree(chip->allocated_banks);
> > +#ifdef CONFIG_TCG_TPM2_HMAC
> > +       kfree(chip->auth);
> > +#endif
> >         kfree(chip);
> >  }
> >  
> > diff --git a/drivers/char/tpm/tpm2-sessions.c
> > b/drivers/char/tpm/tpm2-sessions.c
> > index ef66c28bb332..bca6fe3ebb10 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -3,18 +3,397 @@
> >  /*
> >   * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
> >   *
> > + * Cryptographic helper routines for handling TPM2 sessions for
> > + * authorization HMAC and request response encryption.
> > + *
> > + * The idea is to ensure that every TPM command is HMAC protected
> > by a
> > + * session, meaning in-flight tampering would be detected and in
> > + * addition all sensitive inputs and responses should be
> > encrypted.
> > + *
> > + * The basic way this works is to use a TPM feature called salted
> > + * sessions where a random secret used in session construction is
> > + * encrypted to the public part of a known TPM key.  The problem
> > is we
> > + * have no known keys, so initially a primary Elliptic Curve key
> > is
> > + * derived from the NULL seed (we use EC because most TPMs
> > generate
> > + * these keys much faster than RSA ones).  The curve used is
> > NIST_P256
> > + * because that's now mandated to be present in 'TCG TPM v2.0
> > + * Provisioning Guidance'
> > + *
> > + * Threat problems: the initial TPM2_CreatePrimary is not (and
> > cannot
> > + * be) session protected, so a clever Man in the Middle could
> > return a
> > + * public key they control to this command and from there
> > intercept
> > + * and decode all subsequent session based transactions.  The
> > kernel
> > + * cannot mitigate this threat but, after boot, userspace can get
> > + * proof this has not happened by asking the TPM to certify the
> > NULL
> > + * key.  This certification would chain back to the TPM
> > Endorsement
> > + * Certificate and prove the NULL seed primary had not been
> > tampered
> > + * with and thus all sessions must have been cryptographically
> > secure.
> > + * To assist with this, the initial NULL seed public key name is
> > made
> > + * available in a sysfs file.
> > + *
> > + * Use of these functions:
> > + *
> > + * The design is all the crypto, hash and hmac gunk is confined in
> > this
> > + * file and never needs to be seen even by the kernel internal
> > user.  To
> > + * the user there's an init function tpm2_sessions_init() that
> > needs to
> > + * be called once per TPM which generates the NULL seed primary
> > key.
> > + *
> > + * These are the usage functions:
> > + *
> > + * tpm2_start_auth_session() which allocates the opaque auth
> > structure
> > + *     and gets a session from the TPM.  This must be called
> > before
> > + *     any of the following functions.  The session is protected
> > by a
> > + *     session_key which is derived from a random salt value
> > + *     encrypted to the NULL seed.
> > + * tpm2_end_auth_session() kills the session and frees the
> > resources.
> > + *     Under normal operation this function is done by
> > + *     tpm_buf_check_hmac_response(), so this is only to be used
> > on
> > + *     error legs where the latter is not executed.
> >   */
> >  
> >  #include "tpm.h"
> >  
> > +#include <linux/random.h>
> > +#include <linux/scatterlist.h>
> > +
> >  #include <asm/unaligned.h>
> >  
> >  #include <crypto/aes.h>
> > +#include <crypto/kpp.h>
> > +#include <crypto/ecdh.h>
> > +#include <crypto/hash.h>
> > +#include <crypto/hmac.h>
> >  
> >  /* if you change to AES256, you only need change this */
> >  #define AES_KEYBYTES   AES_KEYSIZE_128
> >  
> >  #define AES_KEYBITS    (AES_KEYBYTES*8)
> > +#define AUTH_MAX_NAMES 3
> > +
> > +/*
> > + * This is the structure that carries all the auth information
> > (like
> > + * session handle, nonces, session key and auth) from use to use
> > it is
> > + * designed to be opaque to anything outside.
> > + */
> > +struct tpm2_auth {
> > +       u32 handle;
> > +       /*
> > +        * This has two meanings: before
> > tpm_buf_fill_hmac_session()
> > +        * it marks the offset in the buffer of the start of the
> > +        * sessions (i.e. after all the handles).  Once the buffer
> > has
> > +        * been filled it markes the session number of our auth
> > +        * session so we can find it again in the response buffer.
> > +        *
> > +        * The two cases are distinguished because the first offset
> > +        * must always be greater than TPM_HEADER_SIZE and the
> > second
> > +        * must be less than or equal to 5.
> > +        */
> > +       u32 session;
> > +       /*
> > +        * the size here is variable and set by the size of
> > our_nonce
> > +        * which must be between 16 and the name hash length. we
> > set
> > +        * the maximum sha256 size for the greatest protection
> > +        */
> > +       u8 our_nonce[SHA256_DIGEST_SIZE];
> > +       u8 tpm_nonce[SHA256_DIGEST_SIZE];
> > +       /*
> > +        * the salt is only used across the session
> > command/response
> > +        * after that it can be used as a scratch area
> > +        */
> > +       union {
> > +               u8 salt[EC_PT_SZ];
> > +               /* scratch for key + IV */
> > +               u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
> > +       };
> > +       u8 session_key[SHA256_DIGEST_SIZE];
> > +};
> 
> Could this contain also the fields added in the previous patch?
> 
> Then obviously this data would be allocated together with chip
> but is there hard reason why this needs separate kzalloc and cannot
> be always allocated with chip blob?

It's session specific (and highly sensitive data), so it needs to be
allocated and destroyed with each session.  Our usage pattern under the
ops mutex means that every session is single threaded, so effectively
it has a 1:1 relationship with the chip, but part of the reason for all
of this is to remove visibility of the contents of this area from
anything other than the session code.  Essentially it's stuff the chip
doesn't need to know because it's always constructed when the session
is created.

I've also got a policy patch much later that requires two sessions, so
needs a push and pop mechanism which a static allocation in the chip
area won't work for.

James


