Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547023F8C10
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbhHZQZv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 12:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243134AbhHZQZt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 12:25:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E93D36117A;
        Thu, 26 Aug 2021 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629995101;
        bh=WFOB8ZbcfFOrvWDFgxMCAlLOPSPiDY5MPZjBnfzf4XA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Nvjmxvnfnbyx1EXbqzKHYg0vsrLqmMug4bL1H2n3C/lkOv0FKNdevzhc32mVHUCX9
         eH6mHuqLofDPzkvPVxk6JDfkieYLO8F/4b3BasV+tqBtOAjrZtM9C9F0D2GTD+4+Th
         THJSyEsn++ZqFbtYIwD8WikZ9ps6Fc0CnMqlxB0Ze5PqhvvTFFxYg905FbXNdRQ4PG
         iG5TKBd+3Mr/iPpv6FNBnaKWnK7Baze2ER51Q6we4HZeUeTMeWuOUgG/wM+hQN+LOx
         RUCHJu5tDGO0Xk5+D/nc9x5y8hJHPYfvcju0cMJGMvNcj+gBNDeY98ocZ5UQ+dnnwq
         FKYBedCVgbc8g==
Message-ID: <bc1ba8557c3146f1b94647de6f2851d002a9b597.camel@kernel.org>
Subject: Re: [PATCH v4] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Han Seungyeop <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Date:   Thu, 26 Aug 2021 19:24:59 +0300
In-Reply-To: <B58587F6-AF3F-4224-B6F6-E3886EE80413@rubrik.com>
References: <20210711075122.30056-1-hao.wu@rubrik.com>
         <20210814222519.42476-1-hao.wu@rubrik.com>
         <B58587F6-AF3F-4224-B6F6-E3886EE80413@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-25 at 22:38 -0700, Hao Wu wrote:
> > On Aug 14, 2021, at 3:25 PM, Hao Wu <hao.wu@rubrik.com> wrote:
> >=20
> > The Atmel TPM 1.2 chips crash with error
> > `tpm_try_transmit: send(): error -62` since kernel 4.14.
> > It is observed from the kernel log after running `tpm_sealdata -z`.
> > The error thrown from the command is as follows
> > ```
> > $ tpm_sealdata -z
> > Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl,
> > code=3D0087 (135), I/O error
> > ```
> >=20
> > The issue was reproduced with the following Atmel TPM chip:
> > ```
> > $ tpm_version
> > T0  TPM 1.2 Version Info:
> >  Chip Version:        1.2.66.1
> >  Spec Level:          2
> >  Errata Revision:     3
> >  TPM Vendor ID:       ATML
> >  TPM Version:         01010000
> >  Manufacturer Info:   41544d4c
> > ```
> >=20
> > The root cause of the issue is due to the TPM calls to msleep()
> > were replaced with usleep_range() [1], which reduces
> > the actual timeout. Via experiments, it is observed that
> > the original msleep(5) actually sleeps for 15ms.
> > Because of a known timeout issue in Atmel TPM 1.2 chip,
> > the shorter timeout than 15ms can cause the error described above.
> >=20
> > A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
> > reduced the timeout to less than 1ms. With experiments,
> > the problematic timeout in the latest kernel is the one
> > for `wait_for_tpm_stat`.
> >=20
> > To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
> > to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
> > for Ateml TPM 2.0 chip, and chips from other vendors.
> > As explained above, the chosen 15ms timeout is
> > the actual timeout before this issue introduced,
> > thus the old value is used here.
> > Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
> > TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
> > the existing TPM_TIMEOUT_RANGE_US (300us).
> > The fixed has been tested in the system with the affected Atmel chip
> > with no issues observed after boot up.
> >=20
> > References:
> > [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
> > 1.2/2.0 generic drivers
> > [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
> > [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
> > [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
> > granularity
> >=20
> > Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM =
1.2/2.0 generic drivers")
> > Link: https://patchwork.kernel.org/project/linux-integrity/patch/202009=
26223150.109645-1-hao.wu@rubrik.com/
> > Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> > ---
> > v4:
> > - Move timeout constants to drivers/char/tpm/tpm_tis_core.h
> > - Cleanup unnecessary inline comment
> >=20
> > v3:
> > - removes unnecessary condition check in `wait_for_tpm_stat`
> >=20
> > v2:
> > - follow the existing way to define two timeouts (min and max)
> >  for ATMEL chip, thus keep the exact timeout logic for=20
> >  non-ATEML chips.
> > - limit the timeout increase to only ATMEL TPM 1.2 chips,
> >  because it is not an issue for TPM 2.0 chips yet.
> >=20
> > Test Plan:
> > - Run fixed kernel with ATMEL TPM chips and see crash
> > has been fixed.
> > - Run fixed kernel with non-ATMEL TPM chips, and confirm
> > the timeout has not been changed.
> >=20
> > drivers/char/tpm/tpm_tis_core.c | 13 +++++++++++--
> > drivers/char/tpm/tpm_tis_core.h |  2 ++
> > include/linux/tpm.h             |  3 +++
> > 3 files changed, 16 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
> > index 55b9d3965ae1..24605f100e96 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -80,8 +80,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u=
8 mask,
> > 		}
> > 	} else {
> > 		do {
> > -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> > -				     TPM_TIMEOUT_USECS_MAX);
> > +			usleep_range(chip->timeout_wait_stat_min,
> > +				     chip->timeout_wait_stat_max);
> > 			status =3D chip->ops->status(chip);
> > 			if ((status & mask) =3D=3D mask)
> > 				return 0;
> > @@ -934,6 +934,8 @@ int tpm_tis_core_init(struct device *dev, struct tp=
m_tis_data *priv, int irq,
> > 	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
> > 	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
> > 	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> > +	chip->timeout_wait_stat_min =3D TPM_TIMEOUT_USECS_MIN;
> > +	chip->timeout_wait_stat_max =3D TPM_TIMEOUT_USECS_MAX;
> > 	priv->phy_ops =3D phy_ops;
> > 	dev_set_drvdata(&chip->dev, priv);
> >=20
> > @@ -983,6 +985,13 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
> >=20
> > 	priv->manufacturer_id =3D vendor;
> >=20
> > +	if (priv->manufacturer_id =3D=3D TPM_VID_ATML &&
> > +		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> > +		/* If TPM chip is 1.2 ATMEL chip, timeout need to be relaxed*/
> > +		chip->timeout_wait_stat_min =3D TPM_ATML_TIMEOUT_WAIT_STAT_MIN;
> > +		chip->timeout_wait_stat_max =3D TPM_ATML_TIMEOUT_WAIT_STAT_MAX;
> > +	}
> > +
> > 	rc =3D tpm_tis_read8(priv, TPM_RID(0), &rid);
> > 	if (rc < 0)
> > 		goto out_err;
> > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
> > index 9b2d32a59f67..2e431beb44f7 100644
> > --- a/drivers/char/tpm/tpm_tis_core.h
> > +++ b/drivers/char/tpm/tpm_tis_core.h
> > @@ -54,6 +54,8 @@ enum tis_defaults {
> > 	TIS_MEM_LEN =3D 0x5000,
> > 	TIS_SHORT_TIMEOUT =3D 750,	/* ms */
> > 	TIS_LONG_TIMEOUT =3D 2000,	/* 2 sec */
> > +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN =3D 14700,	/* usecs */
> > +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX =3D 15000,	/* usecs */
> > };

I'd prefer TIS_TIMEOUT_{MIN, MAX}_ATML. I.e. no "WAIT_STAT" and without "TP=
M_"
to be consistent with other constants here.

> >=20
> > /* Some timeout values are needed before it is known whether the chip i=
s
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index aa11fe323c56..171b9102c976 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -150,6 +150,8 @@ struct tpm_chip {
> > 	bool timeout_adjusted;
> > 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
> > 	bool duration_adjusted;
> > +	unsigned int timeout_wait_stat_min; /* usecs */
> > +	unsigned int timeout_wait_stat_max; /* usecs */

Please rename as timeout_{min, max}.

And I think tpm_chip is wrong place to put them as they are TIS
specific, i.e. they should be in tpm_tis_data.

> >=20
> > 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
> >=20
> > @@ -269,6 +271,7 @@ enum tpm2_cc_attrs {
> > #define TPM_VID_INTEL    0x8086
> > #define TPM_VID_WINBOND  0x1050
> > #define TPM_VID_STM      0x104A
> > +#define TPM_VID_ATML     0x1114
> >=20
> > enum tpm_chip_flags {
> > 	TPM_CHIP_FLAG_TPM2		=3D BIT(1),
> > --=20
> > 2.29.0.vfs.0.0
> >=20
>=20
> Just kindly remind this code review in case it has been missed somehow

I'm sorry, my bad. I managed to somehow miss this. Might be because
I've been recently reorganizing my email accounts. And thanks for
pinging so that I spotted it.

> Thanks
> Hao

/Jarkko

