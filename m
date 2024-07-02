Return-Path: <linux-integrity+bounces-2963-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22991EBBD
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 02:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33A31F21FF5
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 00:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6F20E3;
	Tue,  2 Jul 2024 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="hgsDS1QC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB33D66;
	Tue,  2 Jul 2024 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879553; cv=none; b=GnAiuQunKw58d6/ENBnOxXKDIyAHR5JmIXSQFnWS3ncsxtS+wOihtdbf2bRM7hvoFyIdx2+cCwNf5s/U4tibpatxiteJWcwnD6yNPsAwjg2lvrcb9a3MqBARNcPK6xd+xzI7thHVBuZPv4xT/DCHE9as5qpLxjaz0YpT5oDib6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879553; c=relaxed/simple;
	bh=K9oeLGJQU+rgsK96dB9QMC+iN8/+4+J/PBYB7gUN7Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fy1PREH8+cQC6uVMSyCIXvyLIQN9ENo6rU91lOCoKL6UpQExW1FBuITNYtTToS2kWATItJ7GqK+/cpKMChZTxYeRgmGdI+iOngztDXxo5621fAtEyo4a/Bg6SKi953Jeait24J1XGyp2qnf3QexuIavzNC6TlOo3tvnaZd71fEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=hgsDS1QC; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719879545;
	bh=K9oeLGJQU+rgsK96dB9QMC+iN8/+4+J/PBYB7gUN7Zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hgsDS1QCjQdVgp1dT+k+xCgYKDv9+/NO7OuKPD5gSHHb2n8GHvpxBWICIUFcSQ/P/
	 zq5c3c4v6Qz0rYIbBLCIHsOOrOfmrz/rWjzlKveoQz2j0f/gb5DN/4DOOqGQmPtqs5
	 MRYrGg/V2soCvU5db/DmnXP/3dGLtMrrPQo0ZXYvGiLpnbWiW5WGoo5yut6MxTw+7S
	 LxrRj3oJZJy7PvTxv7E5koOZUTmk6IEYQZRksmLTRf2HRBEykDbUKgW08ebGdrpr38
	 eP2AiFpQlI9Vemdz1ACoQG6wJ6IeHZhuNuaTIhnWobz/8mQjdvdGE6EyUhcQV9Vkfe
	 YyN2U+C+GZWew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WCk6d19g7z4wcS;
	Tue,  2 Jul 2024 10:19:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com, Stefan Berger
 <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, jarkko@kernel.org
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
In-Reply-To: <4108938158d888cc6ec371bb151e7ac35d3b4cb0.camel@HansenPartnership.com>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
 <87pls1lwe0.fsf@mail.lhotse>
 <4108938158d888cc6ec371bb151e7ac35d3b4cb0.camel@HansenPartnership.com>
Date: Tue, 02 Jul 2024 10:19:04 +1000
Message-ID: <87y16kk5mv.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> On Fri, 2024-06-28 at 10:54 +1000, Michael Ellerman wrote:
>> Stefan Berger <stefanb@linux.ibm.com> writes:
>> > Fix the following type of error message caused by a missing call to
>> > tpm2_sessions_init() in the IBM vTPM driver:
>> >=20
>> > [=C2=A0=C2=A0=C2=A0 2.987131] tpm tpm0: tpm2_load_context: failed with=
 a TPM error
>> > 0x01C4
>> > [=C2=A0=C2=A0=C2=A0 2.987140] ima: Error Communicating to TPM chip, re=
sult: -14
>> >=20
>> > Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
>> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> > ---
>> > =C2=A0drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
>> > =C2=A01 file changed, 4 insertions(+)
>> >=20
>> > diff --git a/drivers/char/tpm/tpm_ibmvtpm.c
>> > b/drivers/char/tpm/tpm_ibmvtpm.c
>> > index d3989b257f42..1e5b107d1f3b 100644
>> > --- a/drivers/char/tpm/tpm_ibmvtpm.c
>> > +++ b/drivers/char/tpm/tpm_ibmvtpm.c
>> > @@ -698,6 +698,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev
>> > *vio_dev,
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D tpm2_get_cc_attrs_tbl(chip);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto init_irq_cleanup;
>> > +
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rc =3D tpm2_sessions_init(chip);
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (rc)
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0goto i=
nit_irq_cleanup;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> > =C2=A0
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return tpm_chip_regist=
er(chip);
>>=20
>> #regzbot ^introduced: d2add27cf2b8=20
>
> Could you please test out the patch I proposed for this:
>
> https://lore.kernel.org/linux-integrity/1302b413a2d7bf3b275133e7fdb04b44b=
fe2d5e3.camel@HansenPartnership.com/

Your patch does fix the issue on my PowerVM system, as does Stefan's.

cheers

