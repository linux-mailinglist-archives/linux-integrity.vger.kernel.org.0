Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3127B399
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgI1Rt7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1Rt7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 13:49:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4721DC061755
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 10:49:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so1498073pgl.10
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jm3K0D+qRM9jfq8TwEnl7bzeWquXyGtqvlVDZ7exO18=;
        b=NCwwfD+OKwX6fYhKhdCp4k6avHdzDlhIXBzxmbi33cjvzJMbBiDy4JtS/fxs+q+FCP
         Yra9kqtQbkdR1KKtCIkL5qFfm9xuwKk4rR8idkHsZxzj/I7Ko70xfB4LXsEDlyjRpfSO
         N9jm1IQiFqq4F5kRMu8lMxn/y0XCrHlx8QlAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Jm3K0D+qRM9jfq8TwEnl7bzeWquXyGtqvlVDZ7exO18=;
        b=NWER/Y4dk+NHsjIgXsjgnARogU+83hWQk9hGaPVX/ee5mqdB/PP8iJDQWX3vaFUI9/
         p0u2uSBZ5uOBsMcTUtNSUTyMTARRRKq890gmuiL/W/tnpIO7p7k69hPFArckMYu9c6yc
         eIEJbTxVG8X41hI2MfLhXqqJY4EIRGCIlwBQt557yQnEhLZuOGhQ67Hb4lDQPwejc4gQ
         O+FslYAxs7RnijNq0GpUa85FLp2rvfqy48fgZNJxCkRZgLdzlvR5L4bDybUAAQ5VmIZ6
         unmMnJzMp+aTmGdDIwjcoOTAXO9DvqT7HLuSnXlhATTcN8OrJ/63ArVs/uTB22wEoJTI
         No0w==
X-Gm-Message-State: AOAM532SSsyleXt5SKiZSbYRXVf2q6jfYO74PsTc9bl5FPEMnnr7fCX3
        sDjD3bRtLbCKWpnfxof1In4RjQ==
X-Google-Smtp-Source: ABdhPJwLIhh2HjBlwazkvf7aoKR4yTe+rGJ0Qpua/thRZp0LmvmQxynYSbkDBn6yR/9Q0evXxPg77w==
X-Received: by 2002:a05:6a00:23cc:b029:142:2501:35cf with SMTP id g12-20020a056a0023ccb0290142250135cfmr468860pfc.47.1601315398545;
        Mon, 28 Sep 2020 10:49:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:5808:e111:eba3:c439? ([2601:647:4200:3be0:5808:e111:eba3:c439])
        by smtp.gmail.com with ESMTPSA id m188sm2376973pfd.56.2020.09.28.10.49.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2020 10:49:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20200928141613.GB70098@linux.intel.com>
Date:   Mon, 28 Sep 2020 10:49:56 -0700
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0629B0C-E49F-4FA1-8DBA-E8CB1EDEFD1A@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <20200928010835.GD6704@linux.intel.com>
 <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
 <20200928141613.GB70098@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

=
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3=20
Is the one introducing the issue since 4.14. Then the other three =
commits
changed the relevant code a bit. Probably you can check the timestamp / =
release version
on each commit to understand the relationship.

I think the original patch commit message can help you understand the =
root cause.
Attaching the commit here for your convenience.

Thanks
Hao

-----

Since kernel 4.14, we fixed the TPM sleep logic
from msleep to usleep_range, so that the TPM
sleeps exactly with TPM_TIMEOUT (=3D5ms) afterward.
Before that fix, msleep(5) actually sleeps for
around 15ms.
The fix is =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3

That fix uncovered that the TPM_TIMEOUT was not properly
set previously. We recently found the TPM driver in kernel 4.14+
(including 5.9-rc4) crashes Atmel TPM chips with
too frequent TPM queries.

The TPM crash signature is
```
$ tpm_sealdata -z
Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl, code=3D0087 (135), =
I/O error

$ sudo dmesg | grep tpm0
[59154.665549] tpm tpm0: tpm_try_transmit: send(): error -62
[59154.809532] tpm tpm0: tpm_try_transmit: send(): error -62
```

=46rom the error code "-62", it looks similar to another bug
https://patchwork.kernel.org/patch/10520247/
where the "TPM_TIMEOUT_USECS_MAX" and "TPM_TIMEOUT_USEC_MIN"
is too small, which causes TPM get queried too frequently,
and thus crashes.

We finally found the root cause is related to
the sleep timeout used in `wait_for_tpm_stat`

In the 4.16, commit
=
https://github.com/torvalds/linux/commit/cf151a9a44d52a63332e8e926234574fe=
5a5d784
uses `TPM_POLL_SLEEP` instead of TPM_TIMEOUT for `wait_for_tpm_stat`
and set `TPM_POLL_SLEEP` (1ms).

Since 4.18 commits
=
https://github.com/torvalds/linux/commit/59f5a6b07f6434efac0057dc2f303a96b=
871811b
=
https://github.com/torvalds/linux/commit/424eaf910c329ab06ad03a527ef45dcf6=
a328f00
further reduced the timeout in wait_for_tpm_stat to less than 1ms.

Our patch here defines a `TPM_TIMEOUT_WAIT_STAT` (15ms) just for
`wait_for_tpm_stat the` to fix the crash in Atmel chips,
but not introduce unnecessary performance regression
in other workflows.
15ms is the actual timeout TPM chips use before the 4.14 fix
from msleep to usleep_range. Thus fixed the crash.

Exploring smaller `TPM_TIMEOUT_WAIT_STAT` should be a separate
thing to revisit later. This patch meant to fix the regression
introduced since 4.14

Test Plan:
- Run fixed kernel on system with Atmel TPM chips
 and ensure crash does not happen
- Run fixed kernel on system with other TPM chips
 (IFX / WEC / STM) ensure not breakages from tpm-tool

Signed-off-by: Hao Wu <hao.wu@rubrik.com>
---
drivers/char/tpm/tpm.h          | 1 +
drivers/char/tpm/tpm_tis_core.c | 3 +--
2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..899097ae9756 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -41,6 +41,7 @@ enum tpm_timeout {
	TPM_TIMEOUT_RETRY =3D 100, /* msecs */
	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
+	TPM_TIMEOUT_WAIT_STAT =3D 15,      /* msecs */
	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
};
diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
index 65ab1b027949..8aa5eef10c28 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -80,8 +80,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 =
mask,
		}
	} else {
		do {
-			usleep_range(TPM_TIMEOUT_USECS_MIN,
-				     TPM_TIMEOUT_USECS_MAX);
+			tpm_msleep(TPM_TIMEOUT_WAIT_STAT);
			status =3D chip->ops->status(chip);
			if ((status & mask) =3D=3D mask)
				return 0;
--=20
2.17.1



> On Sep 28, 2020, at 7:16 AM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Sun, Sep 27, 2020 at 11:03:47PM -0700, Hao Wu wrote:
>> Hi Jarkko,
>>=20
>> Just to be clear it is not caused by that single commit, but a few =
accumulated commits
>> =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
>> =
https://github.com/torvalds/linux/commit/cf151a9a44d52a63332e8e926234574fe=
5a5d784
>> =
https://github.com/torvalds/linux/commit/59f5a6b07f6434efac0057dc2f303a96b=
871811b
>> =
https://github.com/torvalds/linux/commit/424eaf910c329ab06ad03a527ef45dcf6=
a328f00
>>=20
>> The easy way is probably just apply the patch I provided, and then =
revisit the value
>> for TPM_TIMEOUT_WAIT_STAT =20
>=20
> When you response, please quote properly, and do not top post.  The
> discussion is impossible to follow this way.
>=20
> I'm not sure if I buy that. Which one is the first failing commit?
>=20
> /Jarkko

