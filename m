Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1903309C04
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 13:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhAaKhk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 05:37:40 -0500
Received: from services.gouders.net ([141.101.32.176]:33274 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhAaKR3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 05:17:29 -0500
X-Greylist: delayed 1124 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jan 2021 05:17:27 EST
Received: from localhost (ltea-047-066-000-239.pools.arcor-ip.net [47.66.0.239])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 10V9ifno020651
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 10:44:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1612086283; bh=vLKM33XF2MpuIYW7z8Tq/AxC1zWZT620ykbKLfQVP2s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=DY4M9cBcyaOrE5pu8gzsi6lLsDdG3KNHZCr1onc2+4iGjO4t/SPhWT5aD6yJ6x35K
         Rxk3J8YjjufGblbS5Dh7llbStZXiu+0U7frMJrAFcVxVoDWvcV7SEkkxdWrn9gc8sU
         2YvYGkT+tMQdTrGGAAWQWAnN6660vTjE+S0P8/m0=
From:   Dirk Gouders <dirk@gouders.net>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tj <ml.linux@elloe.vision>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH v2] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
In-Reply-To: <464454f440df67d3470e67ff0386bbc306d07dac.camel@kernel.org>
        (Jarkko Sakkinen's message of "Sat, 30 Jan 2021 22:40:40 +0200")
References: <20210123014247.989368-1-lma@semihalf.com>
        <20210128130753.1283534-1-lma@semihalf.com>
        <464454f440df67d3470e67ff0386bbc306d07dac.camel@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Sun, 31 Jan 2021 10:43:05 +0100
Message-ID: <ghwnvtwifq.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> writes:

> On Thu, 2021-01-28 at 14:07 +0100, Lukasz Majczak wrote:
>> There is a missing call to tpm_request_locality before the call to
>> the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
>> approach might work for tpm2, it fails for tpm1.x - in that case
>> call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
>> without locality fails and in turn causes tpm_tis_core_init() to fail.
>> Tested on Samsung Chromebook Pro (Caroline).
>>=20
>> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
>
> Is it possible that you test against linux-next and see if any
> problems still arise? I've applied the locality fixes from James.

I tested current linux-next and the warning still appears,
unfortunately.

I then incrementally applied further patches from James' series [1] and
after "[PATCH v2 4/5] tpm_tis: fix IRQ probing" the warning has gone:

# dmesg | grep tpm
[    7.220410] tpm_tis STM0125:00: 2.0 TPM (device-id 0x0, rev-id 78)
[    7.322564] Modules linked in: iwlmvm(+) btusb btrtl btbcm btintel mac80=
211 amdgpu(+) iwlwifi drm_ttm_helper tpm_crb sdhci_pci ttm cqhci gpu_sched =
sdhci ccp cfg80211 rng_core tpm_tis tpm_tis_core tpm thinkpad_acpi(+) wmi n=
vram pinctrl_amd

You might notice there is another warning but that is rtc related and I
still have to find out if that is something I should report.

Dirk

[1] https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bo=
ttomley@HansenPartnership.com/

>> ---
>> Jarkko, James, Guenter
>>=20
>> I=E2=80=99m aware about the other thread, but it seems to be dead for a =
few months.
>> Here is the small patch as fixing this specific issue
>> would allow us to unblock the ChromeOs development.=20
>> We want to upstream all of our patches,
>> so the ChromeOs will not diverge even more,
>> so I'm hoping this could be applied, if you see it neat enough.
>
> The usual approach is that you construct a series picking the pre-existing
> fixes and on top of that create your own, if any required.
>
>> Best regards,
>> Lukasz
>
> /Jarkko
>
>>=20
>> v1 -> v2:
>> =C2=A0- fixed typos
>> =C2=A0- as there is no need to enable clock, switched to
>> =C2=A0=C2=A0 use only tpm_request/relinquish_locality calls
>> =C2=A0- narrowed down boundaries of tpm_request/relinquish_locality calls
>> =C2=A0
>> =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
4 ++--
>> =C2=A0drivers/char/tpm/tpm-interface.c | 11 +++++++++--
>> =C2=A0drivers/char/tpm/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0drivers/char/tpm/tpm_tis_core.c=C2=A0 | 12 ++++++++++--
>> =C2=A04 files changed, 23 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index ddaeceb7e109..5351963a4b19 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -32,7 +32,7 @@ struct class *tpm_class;
>> =C2=A0struct class *tpmrm_class;
>> =C2=A0dev_t tpm_devt;
>> =C2=A0
>> -static int tpm_request_locality(struct tpm_chip *chip)
>> +int tpm_request_locality(struct tpm_chip *chip)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
>> =C2=A0
>> @@ -47,7 +47,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> =C2=A0}
>> =C2=A0
>> -static void tpm_relinquish_locality(struct tpm_chip *chip)
>> +void tpm_relinquish_locality(struct tpm_chip *chip)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc;
>> =C2=A0
>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-int=
erface.c
>> index 1621ce818705..69309b2bea6a 100644
>> --- a/drivers/char/tpm/tpm-interface.c
>> +++ b/drivers/char/tpm/tpm-interface.c
>> @@ -243,8 +243,15 @@ int tpm_get_timeouts(struct tpm_chip *chip)
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->flags & TPM_CH=
IP_FLAG_TPM2)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return tpm2_get_timeouts(chip);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return tpm1_get_timeouts(chip);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ssize_t ret =3D tpm_request_locality(chip);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D tpm1_get_timeouts(chip);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tpm_relinquish_locality(chip);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL_GPL(tpm_get_timeouts);
>> =C2=A0
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 947d1db0a5cc..8c13008437dd 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -193,6 +193,8 @@ static inline void tpm_msleep(unsigned int delay_mse=
c)
>> =C2=A0
>> =C2=A0int tpm_chip_start(struct tpm_chip *chip);
>> =C2=A0void tpm_chip_stop(struct tpm_chip *chip);
>> +int tpm_request_locality(struct tpm_chip *chip);
>> +void tpm_relinquish_locality(struct tpm_chip *chip);
>> =C2=A0struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>> =C2=A0__must_check int tpm_try_get_ops(struct tpm_chip *chip);
>> =C2=A0void tpm_put_ops(struct tpm_chip *chip);
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_=
core.c
>> index 92c51c6cfd1b..0ae675e8cf2f 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -754,9 +754,17 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *c=
hip)
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (chip->flags & TPM_CH=
IP_FLAG_TPM2)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &ca=
p, desc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ssize_t ret =3D tpm_request_locality(chip);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &c=
ap, desc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tpm_relinquish_locality(chip);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +
>> =C2=A0}
>> =C2=A0
>> =C2=A0/* Register the IRQ and issue a command that will cause an interru=
pt. If an
