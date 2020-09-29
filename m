Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5E27BC2A
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 06:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgI2Eq4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 00:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI2Eq4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 00:46:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB32DC061755
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 21:46:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so2835283pgm.11
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 21:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+XOxfFb5eI7MYCnB9LtiXkhNjGJVz97VDA/UwjJ+neo=;
        b=VhtczTvCJXGDEAXHQaNTv9GaHASdx8fojnot4MnRUiFSL64rMd3rTpXN2VphNN9eUN
         mms4mouMAI3hD69gWNmwoi3KqeIokpNZQrCjy1Oz7E+fk1R0ueUhxPOrUwXlC8ykMScu
         oYzNhqEMm5BQGik4dslJyS+ei0zpH8p6jY1ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+XOxfFb5eI7MYCnB9LtiXkhNjGJVz97VDA/UwjJ+neo=;
        b=gc1W6F5qc0SrUCWWN8HV159CTonhVqw0SPLZVSHHpW9zQd+TfOoTDZSt2jogiXtrF5
         kVUrQlKAmoEBBLiG1w6aYeOIdDlAFwtDK+nJIJZ295QVewpN+d9PuKDCYC94t8oQjGhx
         41TLkTRNviOAWfsWVWvepTUwttTPBkZDvb3vwcZLDN1tb7UacltlueNaOWz2NbOFwgnj
         VfnqYjG38IQ2uZ9ZNAi73nqTr9jX6SDp04fay+oxTSWdW5LsLAv9G7mwuMqK+CLKvymF
         KyJzVHZnB8AJe9S35dCe4V38deLonNmLmU7iVHTsQFcp07rgYyTrK5BnVcLAI53boNsm
         Nxgw==
X-Gm-Message-State: AOAM53308r3wBi4kP0z0UxQS6LvFu+BClMbZxrF18q02KV4GLaz3XY+t
        F+7kQLwSoidKF69aQnE+4XmWBw==
X-Google-Smtp-Source: ABdhPJwrRYf9TaoMHN+GWMgL41Ci/bGw3kHKDxl3d/77kKlimON9A8ZkNg35Pl8xcZnsiAz0p9qzsw==
X-Received: by 2002:a63:1c18:: with SMTP id c24mr1919754pgc.30.1601354815020;
        Mon, 28 Sep 2020 21:46:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:5808:e111:eba3:c439? ([2601:647:4200:3be0:5808:e111:eba3:c439])
        by smtp.gmail.com with ESMTPSA id i8sm2890033pjv.43.2020.09.28.21.46.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 21:46:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
Date:   Mon, 28 Sep 2020 21:46:53 -0700
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, nayna@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <05D52607-8CE1-4B73-A8AD-3DBB3DFF7998@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
 <0c896ca8eb0e30d6e75843cfbf2aa627ddc63feb.camel@HansenPartnership.com>
 <246A111F-C72C-4CA2-B439-A6BBE0E85087@rubrik.com>
 <ceb230ea03858f5f6c7d77cfd7adea6e9f864699.camel@HansenPartnership.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Sep 28, 2020, at 3:11 PM, James Bottomley =
<James.Bottomley@hansenpartnership.com> wrote:
>=20
> On Sun, 2020-09-27 at 22:59 -0700, Hao Wu wrote:
> [...]
>>> However, there is another possibility: it's something to do with
>>> the byte read; I notice you don't require the same slowdown for the
>>> burst count read, which actually reads the status register and
>>> burst count as a read32.  If that really is the case, for the atmel
>>> would substituting a read32 and just throwing the upper bytes away
>>> in tpm_tis_status() allow us to keep the current timings?  I can
>>> actually try doing this and see if it fixes my nuvoton.
>>=20
>> If would be helpful if you can find the solution without reducing
>> performance. I think it is a separate problem to address though.
>> Maybe not worth to mix them in the same fix.
>=20
> Well, if it works, no other fix is needed.
>=20
> This is what I'm currently trying out on my nuvoton with the timings
> reverted to being those in the vanilla kernel.  So far it hasn't
> crashed, but I haven't run it for long enough to be sure yet.
>=20
> James
>=20
> ---
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
> index 6b884badabe7..c4dbac8edc9b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -233,9 +233,9 @@ static u8 tpm_tis_status(struct tpm_chip *chip)
> {
> 	struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
> 	int rc;
> -	u8 status;
> +	u32 status;
>=20
> -	rc =3D tpm_tis_read8(priv, TPM_STS(priv->locality), &status);
> +	rc =3D tpm_tis_read32(priv, TPM_STS(priv->locality), &status);
> 	if (rc < 0)
> 		return 0;
>=20
>=20

Thanks James for the quick patch.=20
I will apply it this week any see whether it helps or not.

Hao=
