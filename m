Return-Path: <linux-integrity+bounces-3678-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53182984957
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7549C1C232F2
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FB1AB6E8;
	Tue, 24 Sep 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad8Dnb8E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2A1AAE2D;
	Tue, 24 Sep 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194406; cv=none; b=P0eq0hwKpb3255kC2syFQsQNcd+x+BTDWunE6BCSdiiSQRhuooGdXamLAdTPqB9qMYi0EiCfEm0BSMjmZJ8LHIPPcY4ZVODZnfXmbK/AoIoEoVLvX8erj26FJhl1b0XiLvvthxpTQYBQ1PskWX4hhpLQa1rHzXSmbnfz/e/y7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194406; c=relaxed/simple;
	bh=E0HPrDszblN8VJOrdeajUB6d3Yu9y1ethcovl037+/Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=WeXcnxoXIllSx8FKXZHXBHh/uP14v4UxbK/8BbPMqPQwMRWEHe7tNocEpdU6Jx1+g+JIKBeW0S6pi7VgD/NSZ564mBMF4NmT0ZCHTWmOALZXK016g/L7pU5qBcHK1yR9MSPEMoKiafPpKwbgbN1SOAtYWukHpN4PORsG/ICT/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad8Dnb8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32743C4CEC4;
	Tue, 24 Sep 2024 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727194405;
	bh=E0HPrDszblN8VJOrdeajUB6d3Yu9y1ethcovl037+/Y=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Ad8Dnb8EqPqZinbGTzO5qT5OFHfyOKf8U4aYdnE+7SpB67uToO/3xAZFLyTeENSaA
	 JwyFzaqBIyJELb5NKowe+uJQyEzXEcLvNly3KsD4ebsris/OeTkhLoS3AglFJ00xcE
	 E5CogEHigEWGM+2w0pY/jAHJVaRPOGiGscbJK0YoWyPDEPpSjGxTre2+9KXmzrMXHd
	 CjfEQcgdsTRXSekynfj16KcGoeF39/Kc1s8DvOcMYKIq2mSyt8mFPBDwnibfmj/LF5
	 /bKxvW0sCmpS1Uy7KB3b4Ch/TyaavMFBx+75fkpudNZYViL0qrW2us9BjOqKk+FipQ
	 mCkx9i3vqHieg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 19:13:22 +0300
Message-Id: <D4ENBEH902OY.2HO91169I3HV0@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>,
 <stable@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] tpm: Allocate chip->auth in
 tpm2_start_auth_session()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-5-jarkko@kernel.org>
 <12e17497239dd9b47059b03a0273e2d995371278.camel@HansenPartnership.com>
In-Reply-To: <12e17497239dd9b47059b03a0273e2d995371278.camel@HansenPartnership.com>

On Tue Sep 24, 2024 at 4:33 PM EEST, James Bottomley wrote:
> On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > Move allocation of chip->auth to tpm2_start_auth_session() so that
> > the field can be used as flag to tell whether auth session is active
> > or not.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v6.10+
> > Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - No changes.
> > v4:
> > - Change to bug.
> > v3:
> > - No changes.
> > v2:
> > - A new patch.
> > ---
> > =C2=A0drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++--------=
---
> > --
> > =C2=A01 file changed, 25 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm2-sessions.c
> > b/drivers/char/tpm/tpm2-sessions.c
> > index 1aef5b1f9c90..a8d3d5d52178 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -484,7 +484,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char
> > *str, u8 *pt_u, u8 *pt_v,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sha256_final(&sctx, out=
);
> > =C2=A0}
> > =C2=A0
> > -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip
> > *chip)
> > +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip
> > *chip,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm2_auth *auth)
>
> This addition of auth as an argument is a bit unnecessary.  You can set
> chip->auth before calling this and it will all function.  Since there's
> no error leg in tpm2_start_auth_session unless the session creation
> itself fails and the guarantee of the ops lock is single threading this
> chip->auth can be nulled again in that error leg.
>
> If you want to keep the flow proposed in the patch, the change from how
> it works now to how it works with this patch needs documenting in the
> change log

OK, I don't want to overgrow the diff so +1 for this.

>
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct crypto_kpp *kpp;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct kpp_request *req=
;
> > @@ -543,7 +544,7 @@ static void tpm_buf_append_salt(struct tpm_buf
> > *buf, struct tpm_chip *chip)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sg_set_buf(&s[0], chip-=
>null_ec_key_x, EC_PT_SZ);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sg_set_buf(&s[1], chip-=
>null_ec_key_y, EC_PT_SZ);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kpp_request_set_input(r=
eq, s, EC_PT_SZ*2);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sg_init_one(d, chip->auth->s=
alt, EC_PT_SZ);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sg_init_one(d, auth->salt, E=
C_PT_SZ);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kpp_request_set_output(=
req, d, EC_PT_SZ);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0crypto_kpp_compute_shar=
ed_secret(req);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kpp_request_free(req);
> > @@ -554,8 +555,7 @@ static void tpm_buf_append_salt(struct tpm_buf
> > *buf, struct tpm_chip *chip)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This works because K=
DFe fully consumes the secret before
> > it
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * writes the salt
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_KDFe(chip->auth->salt, =
"SECRET", x, chip->null_ec_key_x,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip->auth->salt);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_KDFe(auth->salt, "SECRE=
T", x, chip->null_ec_key_x, auth-
> > >salt);
> > =C2=A0
> > =C2=A0 out:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0crypto_free_kpp(kpp);
> > @@ -854,6 +854,8 @@ int tpm_buf_check_hmac_response(struct tpm_chip
> > *chip, struct tpm_buf *buf,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
/* manually close the session if it wasn't
> > consumed */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
tpm2_flush_context(chip, auth->handle);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0memzero_explicit(auth, sizeof(*auth));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0kfree(auth);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chip->auth =3D NULL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/* reset for next use=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0auth->session =3D TPM_HEADER_SIZE;
> > @@ -882,6 +884,8 @@ void tpm2_end_auth_session(struct tpm_chip *chip)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm2_flush_context(chip=
, auth->handle);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memzero_explicit(auth, =
sizeof(*auth));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(auth);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip->auth =3D NULL;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(tpm2_end_auth_session);
> > =C2=A0
> > @@ -970,25 +974,29 @@ static int tpm2_load_null(struct tpm_chip
> > *chip, u32 *null_key)
> > =C2=A0 */
> > =C2=A0int tpm2_start_auth_session(struct tpm_chip *chip)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm2_auth *auth;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm_buf buf;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm2_auth *auth =3D c=
hip->auth;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 null_key;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!auth) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_warn_once(&chip->dev, "auth session is not
> > active\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->auth) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_warn_once(&chip->dev, "auth session is
> > active\n");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0auth =3D kzalloc(sizeof(*aut=
h), GFP_KERNEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!auth)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm2_load_null(c=
hip, &null_key);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0auth->session =3D TPM_H=
EADER_SIZE;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm_buf_init(&bu=
f, TPM2_ST_NO_SESSIONS,
> > TPM2_CC_START_AUTH_SESS);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* salt key handle */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u32(&buf=
, null_key);
> > @@ -1000,7 +1008,7 @@ int tpm2_start_auth_session(struct tpm_chip
> > *chip)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append(&buf, au=
th->our_nonce, sizeof(auth-
> > >our_nonce));
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* append encrypted sal=
t and squirrel away unencrypted in
> > auth */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_salt(&buf, ch=
ip);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_salt(&buf, ch=
ip, auth);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* session type (HMAC, =
audit or policy) */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_append_u8(&buf,=
 TPM2_SE_HMAC);
> > =C2=A0
> > @@ -1021,10 +1029,13 @@ int tpm2_start_auth_session(struct tpm_chip
> > *chip)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_buf_destroy(&buf);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto out;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc =3D=3D TPM2_RC_SUCCES=
S) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0chip->auth =3D auth;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > - out:
> > +err:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(auth);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(tpm2_start_auth_session);
> > @@ -1371,10 +1382,6 @@ int tpm2_sessions_init(struct tpm_chip *chip)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chip->auth =3D kmalloc(sizeo=
f(*chip->auth), GFP_KERNEL);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip->auth)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > =C2=A0}
> > =C2=A0#endif /* CONFIG_TCG_TPM2_HMAC */
>
> Other than the comment above
>
> Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Just in case, I'll address the comment so please check also v6.

BR, Jarkko

