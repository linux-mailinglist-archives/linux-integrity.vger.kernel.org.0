Return-Path: <linux-integrity+bounces-646-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0A38247FA
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D86B1C2213D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC7628DB6;
	Thu,  4 Jan 2024 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSWn9QaW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1B28DB1;
	Thu,  4 Jan 2024 18:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B9CC433C8;
	Thu,  4 Jan 2024 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704391787;
	bh=hSioqLHhj9pF//ccyhzKYmhuXLfAGxR5kYPWh3aQPPA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=OSWn9QaWHp+mqsoxaaHHaspjOuYwBRXxxVIeOVzxbT0r8YCgquzQaheGfE+6VpMgv
	 UJjX92p9RLDN8pTxv6UiKjAqU34u4IdTs/NeZ4IJYUpx6OVh8H5ynQive68knUxirq
	 uuiO+oOvl0PbIsB7Nf+Uz+r2LEHHZku1//iDu+cUWuRFpYN1yNBA+D3rO3RVuiS10y
	 J5ApYgurLHXowb/Kc6ntRnI2ezVqxC3EPXf/zNZdRC90Osxi3njv9btWjPBkvyp3hT
	 iuljI2PzY/6gp5lFK+rJ5OIT7JDw27UGjzUeoMmchiIFe3QU15YjGpPWjvXc18fStx
	 6btH5UJGcR5hw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jan 2024 20:09:44 +0200
Message-Id: <CY64GOLHZ2ZS.VIOWWUMZTV6U@suppilovahvero>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v6 13/20] tpm: Add HMAC session start and end functions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240102170408.21969-1-James.Bottomley@HansenPartnership.com>
 <20240102170408.21969-14-James.Bottomley@HansenPartnership.com>
 <CY566RG0WK3A.21KMYFHM9R6UR@suppilovahvero>
 <926f031e15739ea9044c8aaa7bbe72ab18a8f3c5.camel@HansenPartnership.com>
In-Reply-To: <926f031e15739ea9044c8aaa7bbe72ab18a8f3c5.camel@HansenPartnership.com>

On Wed Jan 3, 2024 at 5:31 PM EET, James Bottomley wrote:
> On Wed, 2024-01-03 at 17:18 +0200, Jarkko Sakkinen wrote:
> > On Tue Jan 2, 2024 at 7:04 PM EET, James Bottomley wrote:
> > > Add session=C2=A0 based HMAC=C2=A0 authentication plus parameter=C2=
=A0 decryption
> > > and
> > > response encryption=C2=A0 using AES. The=C2=A0 basic design is to=C2=
=A0 segregate
> > > all
> > > the nasty crypto, hash and hmac code into tpm2-sessions.c and
> > > export a
> > > usable API.=C2=A0 The API first of all starts off by gaining a sessio=
n
> > > with
> > > tpm2_start_auth_session() which=C2=A0 initiates a session with=C2=A0 =
the TPM
> > > and
> > > allocates=C2=A0 an=C2=A0 opaque=C2=A0 tpm2_auth=C2=A0=C2=A0 structure=
=C2=A0 to=C2=A0 handle=C2=A0 the=C2=A0
> > > session
> > > parameters.=C2=A0 The=C2=A0 design is that=C2=A0 session use will be=
=C2=A0 single
> > > threaded
> > > from start to finish under the ops lock, so the tpm2_auth structure
> > > is
> > > stored in struct tpm2_chip to simpify the externally visible API.
> > >=20
> > > The session can be ended with tpm2_end_auth_session() which is
> > > designed only to be used in error legs.=C2=A0 Ordinarily the further
> > > session API (future patches) will end or continue the session
> > > appropriately without having to call this.
> > >=20
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > > Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # crypto
> > > API parts
> > >=20
> > > ---
> > >=20
> > > v6: split into new patch, update config variable
> > > ---
> > > =C2=A0drivers/char/tpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 3 +
> > > =C2=A0drivers/char/tpm/tpm-buf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0=C2=A0 1 +
> > > =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 3 +
> > > =C2=A0drivers/char/tpm/tpm2-sessions.c | 383
> > > +++++++++++++++++++++++++++++++
> > > =C2=A0include/linux/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++
> > > =C2=A05 files changed, 424 insertions(+)
> > >=20
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index e3c39a83171b..086cb8588493 100644
> > > --- a/drivers/char/tpm/Kconfig
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -30,6 +30,9 @@ if TCG_TPM
> > > =C2=A0config TCG_TPM2_HMAC
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Use encrypted a=
nd HMACd transactions on the TPM bus"
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_ECDH
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_LIB_AESCFB
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select CRYPTO_LIB_SHA256
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Setting =
this causes us to deploy a scheme which uses
> > > request
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and response H=
MACs in addition to encryption for
> > > diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-
> > > buf.c
> > > index bb81180495d1..274130398569 100644
> > > --- a/drivers/char/tpm/tpm-buf.c
> > > +++ b/drivers/char/tpm/tpm-buf.c
> > > @@ -44,6 +44,7 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag,
> > > u32 ordinal)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0head->tag =3D cpu_to_=
be16(tag);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0head->length =3D cpu_=
to_be32(sizeof(*head));
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0head->ordinal =3D cpu=
_to_be32(ordinal);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf->handles =3D 0;
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_GPL(tpm_buf_reset);
> > > =C2=A0
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-
> > > chip.c
> > > index 42b1062e33cd..d93937326b2e 100644
> > > --- a/drivers/char/tpm/tpm-chip.c
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -275,6 +275,9 @@ static void tpm_dev_release(struct device *dev)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(chip->work_spac=
e.context_buf);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(chip->work_spac=
e.session_buf);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(chip->allocated=
_banks);
> > > +#ifdef CONFIG_TCG_TPM2_HMAC
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(chip->auth);
> > > +#endif
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(chip);
> > > =C2=A0}
> > > =C2=A0
> > > diff --git a/drivers/char/tpm/tpm2-sessions.c
> > > b/drivers/char/tpm/tpm2-sessions.c
> > > index ef66c28bb332..bca6fe3ebb10 100644
> > > --- a/drivers/char/tpm/tpm2-sessions.c
> > > +++ b/drivers/char/tpm/tpm2-sessions.c
> > > @@ -3,18 +3,397 @@
> > > =C2=A0/*
> > > =C2=A0 * Copyright (C) 2018 James.Bottomley@HansenPartnership.com
> > > =C2=A0 *
> > > + * Cryptographic helper routines for handling TPM2 sessions for
> > > + * authorization HMAC and request response encryption.
> > > + *
> > > + * The idea is to ensure that every TPM command is HMAC protected
> > > by a
> > > + * session, meaning in-flight tampering would be detected and in
> > > + * addition all sensitive inputs and responses should be
> > > encrypted.
> > > + *
> > > + * The basic way this works is to use a TPM feature called salted
> > > + * sessions where a random secret used in session construction is
> > > + * encrypted to the public part of a known TPM key.=C2=A0 The proble=
m
> > > is we
> > > + * have no known keys, so initially a primary Elliptic Curve key
> > > is
> > > + * derived from the NULL seed (we use EC because most TPMs
> > > generate
> > > + * these keys much faster than RSA ones).=C2=A0 The curve used is
> > > NIST_P256
> > > + * because that's now mandated to be present in 'TCG TPM v2.0
> > > + * Provisioning Guidance'
> > > + *
> > > + * Threat problems: the initial TPM2_CreatePrimary is not (and
> > > cannot
> > > + * be) session protected, so a clever Man in the Middle could
> > > return a
> > > + * public key they control to this command and from there
> > > intercept
> > > + * and decode all subsequent session based transactions.=C2=A0 The
> > > kernel
> > > + * cannot mitigate this threat but, after boot, userspace can get
> > > + * proof this has not happened by asking the TPM to certify the
> > > NULL
> > > + * key.=C2=A0 This certification would chain back to the TPM
> > > Endorsement
> > > + * Certificate and prove the NULL seed primary had not been
> > > tampered
> > > + * with and thus all sessions must have been cryptographically
> > > secure.
> > > + * To assist with this, the initial NULL seed public key name is
> > > made
> > > + * available in a sysfs file.
> > > + *
> > > + * Use of these functions:
> > > + *
> > > + * The design is all the crypto, hash and hmac gunk is confined in
> > > this
> > > + * file and never needs to be seen even by the kernel internal
> > > user.=C2=A0 To
> > > + * the user there's an init function tpm2_sessions_init() that
> > > needs to
> > > + * be called once per TPM which generates the NULL seed primary
> > > key.
> > > + *
> > > + * These are the usage functions:
> > > + *
> > > + * tpm2_start_auth_session() which allocates the opaque auth
> > > structure
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0and gets a session from the TPM.=C2=
=A0 This must be called
> > > before
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0any of the following functions.=C2=
=A0 The session is protected
> > > by a
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0session_key which is derived from a =
random salt value
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0encrypted to the NULL seed.
> > > + * tpm2_end_auth_session() kills the session and frees the
> > > resources.
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Under normal operation this function=
 is done by
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_check_hmac_response(), so th=
is is only to be used
> > > on
> > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error legs where the latter is not e=
xecuted.
> > > =C2=A0 */
> > > =C2=A0
> > > =C2=A0#include "tpm.h"
> > > =C2=A0
> > > +#include <linux/random.h>
> > > +#include <linux/scatterlist.h>
> > > +
> > > =C2=A0#include <asm/unaligned.h>
> > > =C2=A0
> > > =C2=A0#include <crypto/aes.h>
> > > +#include <crypto/kpp.h>
> > > +#include <crypto/ecdh.h>
> > > +#include <crypto/hash.h>
> > > +#include <crypto/hmac.h>
> > > =C2=A0
> > > =C2=A0/* if you change to AES256, you only need change this */
> > > =C2=A0#define AES_KEYBYTES=C2=A0=C2=A0=C2=A0AES_KEYSIZE_128
> > > =C2=A0
> > > =C2=A0#define AES_KEYBITS=C2=A0=C2=A0=C2=A0=C2=A0(AES_KEYBYTES*8)
> > > +#define AUTH_MAX_NAMES=C2=A03
> > > +
> > > +/*
> > > + * This is the structure that carries all the auth information
> > > (like
> > > + * session handle, nonces, session key and auth) from use to use
> > > it is
> > > + * designed to be opaque to anything outside.
> > > + */
> > > +struct tpm2_auth {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 handle;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This has two meanings: =
before
> > > tpm_buf_fill_hmac_session()
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it marks the offset in =
the buffer of the start of the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * sessions (i.e. after al=
l the handles).=C2=A0 Once the buffer
> > > has
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * been filled it markes t=
he session number of our auth
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * session so we can find =
it again in the response buffer.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The two cases are disti=
nguished because the first offset
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must always be greater =
than TPM_HEADER_SIZE and the
> > > second
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must be less than or eq=
ual to 5.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 session;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the size here is variab=
le and set by the size of
> > > our_nonce
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * which must be between 1=
6 and the name hash length. we
> > > set
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the maximum sha256 size=
 for the greatest protection
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 our_nonce[SHA256_DIGEST=
_SIZE];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 tpm_nonce[SHA256_DIGEST=
_SIZE];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the salt is only used a=
cross the session
> > > command/response
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * after that it can be us=
ed as a scratch area
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0u8 salt[EC_PT_SZ];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0/* scratch for key + IV */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 session_key[SHA256_DIGE=
ST_SIZE];
> > > +};
> >=20
> > Could this contain also the fields added in the previous patch?
> >=20
> > Then obviously this data would be allocated together with chip
> > but is there hard reason why this needs separate kzalloc and cannot
> > be always allocated with chip blob?
>
> It's session specific (and highly sensitive data), so it needs to be
> allocated and destroyed with each session.  Our usage pattern under the
> ops mutex means that every session is single threaded, so effectively
> it has a 1:1 relationship with the chip, but part of the reason for all
> of this is to remove visibility of the contents of this area from
> anything other than the session code.  Essentially it's stuff the chip
> doesn't need to know because it's always constructed when the session
> is created.
>
> I've also got a policy patch much later that requires two sessions, so
> needs a push and pop mechanism which a static allocation in the chip
> area won't work for.
>
> James

Given the 1:1 relationship keeping the fields in tpm_chip has the
benefit of not having to deal with allocation error.

I guess having struct tpm2_auth (dunno, maybe tpm2_hmac_auth tho)
does make sense because then it could be declared as static field
and zeroed with memzero_explicit().

I don't see any point saving memory here at least...

BR, Jarkko

