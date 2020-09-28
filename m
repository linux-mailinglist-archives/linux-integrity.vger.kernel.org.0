Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A3927A4B5
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 02:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgI1APy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 20:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI1APy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 20:15:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB12C0613CE
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 17:15:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d13so6769222pgl.6
        for <linux-integrity@vger.kernel.org>; Sun, 27 Sep 2020 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=s16mlRh0iGLzo32aI51prROSaGa24RFMZIzqEFIrhsw=;
        b=KTfH78alLOWOgWZHV0RRf6yCW/ZfOjuWCmMQZoKX7qiznm5dB3Bpthr5tC+IMHaK2m
         E+aYYDhX9TwgiAt/yAcJdGRZE3CrzXAoP3aa6vpP2EVyP37QFv/XiSrIJPaZCt91Nu24
         vNIEdJfACxc8bDE6CdxQxcqusbbxRnGT7CCOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=s16mlRh0iGLzo32aI51prROSaGa24RFMZIzqEFIrhsw=;
        b=j+gX0atCS5jUfPTf1+iGLjURqSymvuHJsjsqjJjhT/ifcLcg5xD5nWnrdUclsbaRRS
         cL4wbsya/8fvMAxjk71fK/1DZNoZoOCUGhpBCUt2GF0ewk8+gWhWduJkuVQUsrRCAol+
         pCWwCLoApwklMwDquIumq9aMSEuDo6WAyUDUO19F//Mg5DdZ9LUmPNpifW0/iXidNZs3
         Pd9hUti7q0uU+39+OqOSvE43CIVr+JYtCIhPaNGUhnPPcb76a49lb8g8+dGP1/S8rLyH
         1ZRlj5H7pz7Yag9YzLXilPBTB28aQioZ8m4cS6pUj9zgimBRDaua5VGsqGiSOaHtmm8p
         udpA==
X-Gm-Message-State: AOAM533lRrZhF3N054ItILCu3Q8bgQpQI4JIj7dElWRXIY/f1B0TDAnn
        wugTf7pCn7X4kvdLSNXV3ucwPA==
X-Google-Smtp-Source: ABdhPJwqdCuVOXEMH+Uc/RQNguP0HOfKQGHe6pcitUWTo4l6DNE5NLP4OgCvrPbmEaBkHTcEqkdCzQ==
X-Received: by 2002:a17:902:aa97:b029:d2:8cba:912b with SMTP id d23-20020a170902aa97b02900d28cba912bmr802562plr.65.1601252153452;
        Sun, 27 Sep 2020 17:15:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:5808:e111:eba3:c439? ([2601:647:4200:3be0:5808:e111:eba3:c439])
        by smtp.gmail.com with ESMTPSA id f18sm9930841pfe.153.2020.09.27.17.15.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2020 17:15:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
Date:   Sun, 27 Sep 2020 17:15:51 -0700
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
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
Message-Id: <3C374AD2-4591-4B5F-89AA-730F2CCBC05F@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
 <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
 <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
 <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
 <E6E3C07D-57F4-48F5-B4A9-50868B82E779@rubrik.com>
To:     Hao Wu <hao.wu@rubrik.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am attaching the original bug report to this thread for new reviewers =
to get better context

---

Hi TPM Driver Maintainers,

We are from Rubrik engineering team. We found a TPM driver update since =
kernel 4.14 causing atmel TPM chips crash. We have root caused it and =
have a patch on the kernel used by Rubrik products. Given the =E2=80=9Cbug=
=E2=80=9D has impact on not just Rubrik products, but all atmel TPM =
chips, we are asking to fix the issue in the kernel upstream.

The commit that introduced the bug since 4.14=20
=
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3

Effected platform / system:
- Cisco UCS C220 M5 with atmel TPM chip
	- Ubuntu 16.04
  	- Kernel 4.14 / 4.15 / 4.18 / 4.20 / 5.8 / 5.9-rc4
- Cisco UCS C240 M5 with atmel TPM chip
	- Ubuntu 16.04
  	- Kernel 4.14 / 4.15 / 4.18 / 4.20 / 5.8 / 5.9-rc4

```
# TPM chip used in the problematic platform
$ tpm_version
TPM 1.2 Version Info:
  Chip Version:        1.2.66.1
  Spec Level:          2
  Errata Revision:     3
  TPM Vendor ID:       ATML
  TPM Version:         01010000
  Manufacturer Info:   41544d4c
```

Not all Cisco server nodes are facing the crash, but there are a good =
amount of portion (around 50% from nodes in Rubrik) are persistently =
having the TPM crash issue.

Our other platforms using TPM chips from other vendors do not have =
issue. These platform are running the same software as the problematic =
platforms run. Those TPM non-effected vendors are
- IFX
- STM
- WEC

TPM crash signature:
```
# error when running tpm tool
$ tpm_sealdata -z
Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl, code=3D0087 (135), =
I/O error

# tpm driver sends error
$ sudo dmesg | grep tpm0
[59154.665549] tpm tpm0: tpm_try_transmit: send(): error -62
[59154.809532] tpm tpm0: tpm_try_transmit: send(): error -62
```

Our Root Cause Analysis
=46rom the error code =E2=80=9C-62=E2=80=9D, it looks similar to another =
bug https://patchwork.kernel.org/patch/10520247/
where the =E2=80=9CTPM_TIMEOUT_USECS_MAX=E2=80=9D and =
=E2=80=9CTPM_TIMEOUT_USEC_MIN=E2=80=9D is too small, which causes TPM =
get queried too frequently, and thus crashes.

The issue for atmel TPM chip crash is similar the commit =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3 changed TPM sleep logic from using `msleep` to `tpm_msleep`, in =
which `usleep_range` is used.

As what =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3 intended to do, using usleep_range can make the sleep period =
shorter, because msleep actually sleeps longer when the sleep perioid is =
within 20ms, and usleep_range can make it more precise.

According to our experiments,
- usleep_range makes the TPM sleep precisely for TPM_TIMEOUT (i.e. 5ms =
https://github.com/torvalds/linux/blob/v4.14/drivers/char/tpm/tpm.h#L52)
- msleep(TPM_TIMEOUT) actually sleeps around 15ms   =20

Thus the TPM get queried more frequently than before, which is likely =
the root cause of the atmel chip crash. We fix it by bumping up the =
TPM_TIMEOUT to 15ms.


Rubrik Patch (patch only for 4.14)
```
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 72d3ce4..9b8f3f8 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -49,7 +49,15 @@ enum tpm_const {
 };

 enum tpm_timeout {
-       TPM_TIMEOUT =3D 5,        /* msecs */
+       TPM_TIMEOUT =3D 15,       /* msecs */
        TPM_TIMEOUT_RETRY =3D 100, /* msecs */
        TPM_TIMEOUT_RANGE_US =3D 300      /* usecs */
 };
```
With the patch, the atmel TPM chip crash is fixed. =20

Proposal
We want the kernel upstream to adopt the fix or have a better fix for =
the atmel chip while not bring performance regression for other TPM =
chips. We understand that =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3 was intended to shorten the TPM respond time, but it does not =
work well for atmel TPM chips. Probably we should override TPM_TIMEOUT =
value for atmel chips at least.

Thanks
Hao

> On Sep 27, 2020, at 5:11 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
> Hi James,
>=20
> Maybe there is a misunderstanding. Here I am using tpm_msleep, not =
msleep.
> tpm_msleep is using usleep underlaying. See
> =
https://github.com/torvalds/linux/blob/master/drivers/char/tpm/tpm.h#L188
>=20
> The reasons I choose 15ms, is because before=20
> =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
> (Where msleep is changed to tpm_msleep (which is essentially usleep)),
> The actual sleep time is 15ms, thus here we change this back to 15ms =
to fix
> regression.
>=20
> Thanks
> Hao=20
>=20
>> On Sep 27, 2020, at 11:25 AM, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>>=20
>> On Sat, 2020-09-26 at 16:10 -0700, Hao Wu wrote:
>>> Resending following email in plaintext.
>>>=20
>>> ----
>>>=20
>>> Hi James,
>>>=20
>>> Thanks for following up.
>>>=20
>>> We have actually tried change=20
>>> TPM_TIMEOUT_USECS_MIN / TPM_TIMEOUT_USECS_MAX=20
>>> according to https://patchwork.kernel.org/patch/10520247/
>>> It does not solve the problem for ATMEL chip. The chips facing crash
>>> is=20
>>> not experimental, but happens commonly in=20
>>> the production systems we and our customers are using.
>>> It is widely found in Cisco 220 / 240 systems which are using
>>> Ateml chips.
>>=20
>> Well, I came up with the values in that patch by trial and error ....
>> all I know is they work for my nuvoton. If they're not right for you,
>> see if you can find what values actually do work for your TPM.  The
>> difference between msleep and usleep_range is that the former can =
have
>> an indefinitely long timeout and the latter has a range bounded one.=20=

>> If you think msleep works for you, the chances are it doesn't and
>> you're relying on the large upper bound to make the bug infrequent
>> enough for you not to see it.  Playing with the values in usleep =
range
>> will help you find what the actual timeout is and eliminate the =
problem
>> for good.
>>=20
>> James
>=20

