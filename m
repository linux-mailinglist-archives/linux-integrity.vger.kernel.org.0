Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D095A2678C9
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 10:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgILIOD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 04:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgILIOB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 04:14:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB7DC061573
        for <linux-integrity@vger.kernel.org>; Sat, 12 Sep 2020 01:14:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so2859453pjg.1
        for <linux-integrity@vger.kernel.org>; Sat, 12 Sep 2020 01:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UnUe6wm44cuDmbaTpH1dsadpsHdWGmyvOhIlCmyKBtg=;
        b=SeMCntynxQV2AlHy7U5gtsC0Y6dcwPiq3mgzTyPDt+J2IR8WWN97NzKtDlj4PyB2T0
         oM3i6eLCeUwbNPfie+ZvB2IbaQTSu83UtgN2RReBPhvzVkHAmQhe8+GA3JoSBpgdi02r
         htGKTrt37urgiZ9I/cDFMyqnimuQrAiiLRiSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=UnUe6wm44cuDmbaTpH1dsadpsHdWGmyvOhIlCmyKBtg=;
        b=X4sg2Zjm6csLwI6suY/eUL1uC2q2YGVcIskxh3vdtPoo1MBR9k29KSObV4KCypt5WW
         CqCkFcSA40zaay2XFYKY/qfYumsfcEeEI694wzz0FM/RfHBMBM6YRM3eC4HIhW/JFIaQ
         tN1KpeZ90rOUC8nbRFNLaAPnezrq9oT+aEF8Z+q+0zlEcaaP774wwwVmh55pXCAZP4Uq
         xBgE1TKzggNjU1v0WsuC6O7MC1jMZAfBUTbUQOio8tRpnWyt4kB0SAwh4BUjIQUtmVZI
         MUmo3ds6mbwRrIBU1uU2JpyMWYF8SiDPvcJ35Rmvj6hma0IbN9LB69q/m/FUaxXT/3SW
         fgRg==
X-Gm-Message-State: AOAM532QN0hQ6L2m/tR1T0Zu9P9UNGU+r75vktg/EWy01mNZ3EFcoX48
        /855ryTuljpsuHiO39MjqY8R6Q==
X-Google-Smtp-Source: ABdhPJwH5Ic2sPUYmF9gXawtHoG5t7BTzNwH9PN23ZtweDX+3M1qmRInfdlKVfKT0zLodAoHB7Sn2A==
X-Received: by 2002:a17:90a:ac2:: with SMTP id r2mr5712202pje.71.1599898440745;
        Sat, 12 Sep 2020 01:14:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:4841:de4e:dcc7:1e1c? ([2601:647:4200:3be0:4841:de4e:dcc7:1e1c])
        by smtp.gmail.com with ESMTPSA id a15sm3867892pgi.69.2020.09.12.01.13.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 01:14:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Bug Report] Kernel 4.14+ TPM Driver Bug for Atmel TPM Chip
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <d9fc244f-f8ac-64cf-2b8f-0b13685fe6be@molgen.mpg.de>
Date:   Sat, 12 Sep 2020 01:13:59 -0700
Cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Hamza Attak <hamza@hpe.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51A869F9-1860-4250-9E27-7312A03CA303@rubrik.com>
References: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
 <20200911041800.GA541925@kroah.com>
 <5518aa6e-a10f-9e07-e885-2ab43a0906e9@linux.ibm.com>
 <d9fc244f-f8ac-64cf-2b8f-0b13685fe6be@molgen.mpg.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Resend following email with plaintext
-----

Hi Paul and Ken,

Thanks for quick responses over this report.=20

> Hao, I wouldn=E2=80=99t expect a longer timeout causing the TPM to be =
queried less frequently, but I do not know the code well.
=46rom our understanding, the TPM queries might be retried due to some =
reason, increase timeout 3x would lower the query frequency to 1/3. The =
explanation might be wrong, but the fact looks like the timeout matters. =
 Unfortunately, engineers from Rubrik are not experts over the TPM =
driver code neither :(

>> Be careful about making this a global change.  It could reduce the =
TPM performance by 3x. We don't want to affect all TPMs to fix a bug in =
an old TPM 1.2 chip from one vendor.
>=20
> Linux has a no regression policy, so the performance penalty =
wouldn=E2=80=99t matter. Unfortunately, the regression was only noticed =
several years after being introduced in Linux v4.14-rc2.
So does that mean we are good to apply the global change ? Or we need to =
discuss about the actual fix further ?

Thanks
Hao

> On Sep 12, 2020, at 12:37 AM, Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>=20
> Dear Ken,
>=20
>=20
> Any reason you stripped the CC list? Adding back Hao Wu and adding the =
patch author.
>=20
> Am 11.09.20 um 21:35 schrieb Ken Goldman:
>> On 9/11/2020 12:18 AM, Greg KH wrote:
>>> Thus the TPM get queried more frequently than before, which is =
likely the root cause of the atmel chip crash. We fix it by bumping up =
the TPM_TIMEOUT to 15ms.
>>>=20
>>>=20
>>> Rubrik Patch
>>> ```
>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>> index 72d3ce4..9b8f3f8 100644
>>> --- a/drivers/char/tpm/tpm.h
>>> +++ b/drivers/char/tpm/tpm.h
>>> @@ -49,7 +49,15 @@ enum tpm_const {
>>>   };
>>>=20
>>>   enum tpm_timeout {
>>> -       TPM_TIMEOUT =3D 5,        /* msecs */
>>> +       TPM_TIMEOUT =3D 15,       /* msecs */
>>>          TPM_TIMEOUT_RETRY =3D 100, /* msecs */
>>>          TPM_TIMEOUT_RANGE_US =3D 300      /* usecs */
>>>   };
>>> ```
>>> With the patch, the atmel TPM chip crash is fixed.
>>>=20
>>> Proposal
>>> We want the kernel upstream to adopt the fix or have a better fix =
for the atmel chip while not bring performance regression for other TPM =
chips. We understand that =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3
>>> was intended to shorten the TPM
>> Is this the poll time, which was reduced at one point?  If so ...
>=20
> The commit summary is: tpm: replace msleep() with  usleep_range() in =
TPM 1.2/2.0 generic drivers.
>=20
>> Be careful about making this a global change.  It could reduce the =
TPM performance by 3x. We don't want to affect all TPMs to fix a bug in =
an old TPM 1.2 chip from one vendor.
>=20
> Linux has a no regression policy, so the performance penalty =
wouldn=E2=80=99t matter. Unfortunately, the regression was only noticed =
several years after being introduced in Linux v4.14-rc2.
>=20
> Hao, I wouldn=E2=80=99t expect a longer timeout causing the TPM to be =
queried less frequently, but I do not know the code well.
>=20
>=20
> Kind regards,
>=20
> Paul

