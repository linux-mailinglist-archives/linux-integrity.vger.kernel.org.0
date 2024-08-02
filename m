Return-Path: <linux-integrity+bounces-3245-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264894639E
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 21:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11BF282810
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE101ABEAE;
	Fri,  2 Aug 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwUcYcf5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059E15AC4;
	Fri,  2 Aug 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626145; cv=none; b=apIzhuxOTQ602bQdqT3+6viXqnNLgCn0OcIy5WGOwKJwTMb+Fia7TzlXGRQEE1fRlfFyPSVF4tz+gGA6/4/wupJ7Cpdoqn6WZa3oYbfJChOr6AXcRNP3h9bcqmOM7gaYty6i7roIWO/mpGOpa7FcOVQefwOAdr2udKJF9boKr3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626145; c=relaxed/simple;
	bh=DPcm9VpQDiXwdm+30uqoSz3rkdbNpnTdaG3j/y469E0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=QB/yOALynV2GYn8Z5ceJ/l1CCvvHQ8x5ec5mVW9/zNg4OaEyFDcBTNMeXBWuzv8cznBQvC1E4tCxtDSemjXIWIbZQ795V+5+UudCdhbm96q0rzlwDyatuzy0wGEuLefQLeKf0Kbyg4SccYBvVrO2fTfvm9wzOS8SK7jXDhpnpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwUcYcf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FADC32782;
	Fri,  2 Aug 2024 19:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722626144;
	bh=DPcm9VpQDiXwdm+30uqoSz3rkdbNpnTdaG3j/y469E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwUcYcf5vcPVAx6YCe2DGEDcMXm8ZNvo3kqZcRCYH+D952+5bQ0oHUr95Z9F+15IE
	 eCHyS+clmAp5aUUxA5Eq0I7sWAviKl94PbJdw6/WH6Hzz1m0t/FlKDoApikNt/4VfN
	 lObeO8Y730WjDeSl11h2qLXdhQ93BwIilkP2Jrsn5SNy2uUpRwHGRuIgO+tDXGO4UQ
	 1EXaOt2NnmPrtIgAuBRjhIXo7TwNZgam7nBfybnLhFQ76RnAKBz8f5ebIlEbU9jyRN
	 027qWO9Gy+x6yTHfD2dGhAfPDUKmeT4jsuF8numqWGIjCsGCkecm8BJd1PAaOqyAYu
	 1LLV+v9iwBvsA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Aug 2024 22:15:36 +0300
Message-Id: <D35O025XJT9S.CO2QK3K59QO9@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jett Rink" <jettrink@chromium.org>, "LKML"
 <linux-kernel@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Peter Huewe" <peterhuewe@gmx.de>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Add new device/vendor ID 0x50666666
X-Mailer: aerc 0.17.0
References: <20240718202359.127482-1-jettrink@chromium.org>
 <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>
In-Reply-To: <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>

On Fri Aug 2, 2024 at 6:19 PM EEST, Jett Rink wrote:
> Could I get some feedback on this patch please? Is there something I
> am not doing correctly?

Sorry, I just came from holidays.

>
> -Jett
>
> On Thu, Jul 18, 2024 at 2:24=E2=80=AFPM Jett Rink <jettrink@chromium.org>=
 wrote:
> >
> > Accept another DID:VID for the next generation Google TPM. This TPM
> > has the same Ti50 firmware and fulfills the same interface.
> >
> > Signed-off-by: Jett Rink <jettrink@chromium.org>
> > ---
> >
> > Changes in v2:
> > Patchset 2 applies cleanly
> >
> >  drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm=
_tis_i2c_cr50.c
> > index adf22992138e..b50005ccfc5e 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > @@ -31,7 +31,8 @@
> >  #define TPM_CR50_TIMEOUT_SHORT_MS      2               /* Short timeou=
t during transactions */
> >  #define TPM_CR50_TIMEOUT_NOIRQ_MS      20              /* Timeout for =
TPM ready without IRQ */
> >  #define TPM_CR50_I2C_DID_VID           0x00281ae0L     /* Device and v=
endor ID reg value */
> > -#define TPM_TI50_I2C_DID_VID           0x504a6666L     /* Device and v=
endor ID reg value */
> > +#define TPM_TI50_DT_I2C_DID_VID                0x504a6666L     /* Devi=
ce and vendor ID reg value */
> > +#define TPM_TI50_OT_I2C_DID_VID                0x50666666L     /* Devi=
ce and vendor ID reg value */
> >  #define TPM_CR50_I2C_MAX_RETRIES       3               /* Max retries =
due to I2C errors */
> >  #define TPM_CR50_I2C_RETRY_DELAY_LO    55              /* Min usecs be=
tween retries on I2C */
> >  #define TPM_CR50_I2C_RETRY_DELAY_HI    65              /* Max usecs be=
tween retries on I2C */
> > @@ -741,14 +742,18 @@ static int tpm_cr50_i2c_probe(struct i2c_client *=
client)
> >         }
> >
> >         vendor =3D le32_to_cpup((__le32 *)buf);
> > -       if (vendor !=3D TPM_CR50_I2C_DID_VID && vendor !=3D TPM_TI50_I2=
C_DID_VID) {
> > +       if (vendor !=3D TPM_CR50_I2C_DID_VID &&
> > +           vendor !=3D TPM_TI50_DT_I2C_DID_VID &&
> > +           vendor !=3D TPM_TI50_OT_I2C_DID_VID) {
> >                 dev_err(dev, "Vendor ID did not match! ID was %08x\n", =
vendor);
> >                 tpm_cr50_release_locality(chip, true);
> >                 return -ENODEV;
> >         }
> >
> >         dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > -                vendor =3D=3D TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
> > +                vendor =3D=3D TPM_CR50_I2C_DID_VID    ? "cr50" :
> > +                vendor =3D=3D TPM_TI50_DT_I2C_DID_VID ? "ti50 DT" :
> > +                                                    "ti50 OT",

Whenever possible ternary operator should be avoided, unless the use
case super trivial: this complexity brings us zero measurable benefit
and unnecessarily obfuscates code.

I'd suggest to simply add a helper:

/*
 * Maps VID to a name.
 */
const char *tpm_cr50_vid_to_name(u32 vendor)
{
	switch (vendor) {
	case TPM_CR50_I2C_DID_VID:
		return "cr50";
	case TPM_TI50_DT_I2C_DID_VID:
		return "ti50 DT";
	case TPM_TI50_OT_I2C_DID_VID:
		return "ti50 OT";
	default:=09
		break;
	}

	tpm_cr50_release_locality(chip, true);
	return NULL;
}

The code then transforms to:

	vendor =3D le32_to_cpup((__le32 *)buf);

	name =3D tpm2_cr50_vid_to_name(vendor);
	if (name =3D=3D NULL) {
		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
		return -ENODEV;
	}

	dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n", name.
		 client->addr, client->addr, client->irq, vendor >> 16);

[and add suggested-by]

> >                  client->addr, client->irq, vendor >> 16);
> >         return tpm_chip_register(chip);
> >  }
> > --
> > 2.45.2.1089.g2a221341d9-goog
> >


BR, Jarkko

