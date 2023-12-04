Return-Path: <linux-integrity+bounces-329-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A22802A59
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 03:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E91B207E4
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 02:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973D642;
	Mon,  4 Dec 2023 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR8uiLKG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DA38A
	for <linux-integrity@vger.kernel.org>; Mon,  4 Dec 2023 02:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971D8C433C7;
	Mon,  4 Dec 2023 02:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701657376;
	bh=PYeF07rEgepH06KQnhf/cogiGP7iBaCv1QN0e6AXkSg=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=WR8uiLKGdRjtzzaL8yFDg1RHQwJt8ii46A4yFwPKj+OTZoKKa+rReBol14SaSly5u
	 uaa5MGVCWn1+hWtm9xOCqb8y9UZGa0Fm0g9oiw/ic0g/baiUSTpT+/gsMWNksa4zC9
	 3CBcGmu4Dq4u8+1Y/lV6hcUH3vSu20rwG0OM7yszs5kXd+aeTm/8YBX/qv+L/Xutek
	 wTSLCWmE9rn1TBKX5ABqYznVAInTD558IsCMjJvdqMsPWom/U6VepHmJHi1XrdcWKa
	 zw/Egq91urStUPTJ2FZEWxdoZCYQPboPFCa/GOuuvtOeu0iEIorfuh1IB77pwjZug1
	 Ipgxav/7NShsg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Dec 2023 04:36:13 +0200
Message-Id: <CXF771IUU5TC.2HU7I8Z27K1UF@suppilovahvero>
To: "Angga" <Hermin.Anggawijaya@alliedtelesis.co.nz>, "Stefan Berger"
 <stefanb@linux.ibm.com>, "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz> <85154bfe-6bd5-440a-acc1-f01497d59af5@linux.ibm.com> <b1d29d38-2d9c-4147-a53d-e240d8a436ae@alliedtelesis.co.nz>
In-Reply-To: <b1d29d38-2d9c-4147-a53d-e240d8a436ae@alliedtelesis.co.nz>

On Mon Nov 27, 2023 at 4:02 AM EET, Angga wrote:
> On 23/11/2023 1:34 am, Stefan Berger wrote:
> >
> >
> > On 11/22/23 01:55, Hermin Anggawijaya wrote:
> >> Before sending a command to attempt the self test, the TPM
> >> may need to be started, otherwise the self test returns
> >> TPM2_RC_INITIALIZE value causing a log as follows:
> >> "tpm tpm0: A TPM error (256) occurred attempting the self test".
> >>
> >> Signed-off-by: Hermin Anggawijaya=20
> >> <hermin.anggawijaya@alliedtelesis.co.nz>
> >> ---
> >> =C2=A0 drivers/char/tpm/tpm2-cmd.c | 8 ++++----
> >> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> >> index 93545be190a5..0530f3b5f86a 100644
> >> --- a/drivers/char/tpm/tpm2-cmd.c
> >> +++ b/drivers/char/tpm/tpm2-cmd.c
> >> @@ -737,15 +737,15 @@ int tpm2_auto_startup(struct tpm_chip *chip)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >> =C2=A0 +=C2=A0=C2=A0=C2=A0 rc =3D tpm2_startup(chip);
> >> +=C2=A0=C2=A0=C2=A0 if (rc && rc !=3D TPM2_RC_INITIALIZE)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >> +
> >
> > Most platforms should have firmware initialize the TPM 2 these days.=20
> > Therefore, a selftest should work and in case it doesn't work you fall=
=20
> > back to the tpm2_startup below and if you get an error message in the=
=20
> > log you at least know that you firmware is not up-to-date.
> >
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D tpm2_do_selftest(chip);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc && rc !=3D TPM2_RC_INITIALIZE)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc =3D=3D TPM2_RC_INITIALIZE=
) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D tpm2_startup(chip);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out;
> >> -
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D tpm2_do_=
selftest(chip);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out;
>
> Hello Stefan
>
> Thank you for your comments.
>
> Unfortunately our platforms (custom hardware design) are the ones which=
=20
> do not initialize/start the TPM2 from boot loader yet, and because of=20
> that the
> self test in tpm2_auto_startup always produce a log error message on the=
=20
> platform start up.
>
> While I understand your point about the log being useful for "pointing=20
> out not up-to-date firmware", but it might also generate unnecessary supp=
ort
> queries from some users on such platforms ? And maybe the kernel being=20
> able to deal with TPM being started more than once is better ?
>
> If wanted, I have the second version of the patch which consist of code=
=20
> changes as in v1, plus ability for tpm2_transmit_cmd to handle multiple
> attempts to start up the TPM silently, for example, once by the firmware=
=20
> and another by the kernel during tpm2 auto-startup.

To save your time: no.

Mainline kernel is not modified based hardware prototypes.

You have freedom to maintain your own kernel tree for whatever changes
you need but this is totally wrong place for these type of patches.

>
> Kind regards
>
> Hermin Anggawijaya

BR, Jarkko

