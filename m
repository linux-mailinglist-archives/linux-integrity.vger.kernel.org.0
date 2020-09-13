Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF5F267E2F
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Sep 2020 08:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgIMGjG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Sep 2020 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgIMGjC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Sep 2020 02:39:02 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFA0C061573
        for <linux-integrity@vger.kernel.org>; Sat, 12 Sep 2020 23:39:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s65so8058336pgb.0
        for <linux-integrity@vger.kernel.org>; Sat, 12 Sep 2020 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CIzyPOg64CTtfG+qm4TuHv+K77pjWAmLv5Lx0/I+XQQ=;
        b=E49/vJZLLQKUhYrZiodeOLpXogM8dBpR3gcJg/x3PvF4dMLxb0+osrJI8FDDtc7yMm
         EKQzrUH7r+9utPMDs+dU0f8ID9IWrFK35VxU6tRlE93r5etqL7A+xiPof9j7pq3Wy3p7
         0uTX540S9Sc0xKBXVAdpWj4u1b8k7bQEDUAMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CIzyPOg64CTtfG+qm4TuHv+K77pjWAmLv5Lx0/I+XQQ=;
        b=OxtMJyW0LTy9eBg6zx0rrCOLkKUqZ34HL8DNfJlWELmqweGk0twmGYw5StoO/9ryFa
         GqG95moapo8irVr3jItOQGXjgykJjIlMB1ZFYNbpaduEkCSCsWdT35G5nWn3AqorVZsJ
         /EbnPPBEK4bjj0GO864MTsoBVvRtiLS1K9PATzD4k57u+f70YzF5hw3ByjuV21zr30Gw
         PAXQB/YtW+2M38XxAaRVIqGvyGe7d46/VbQA4Y5X0cpiUE+nd98krFl1HFJQmWPV1bpd
         sJIwQQIUIGnlEPRJGVOxpQd60a60/9egDbi4oYA38JVXwfeZserGZJBO4lZ+lDOLo6DF
         9j8w==
X-Gm-Message-State: AOAM532hOlGg8iVYj3f+iYsHXHUrF6QW5eyYj8TIK+CvKLIkmnA1+0pK
        NujCzwttzCDMnxJS7C4AGCU+yA==
X-Google-Smtp-Source: ABdhPJySTRpXodpuWTyroStIyWJoQQ9eQWCIiCZ9xgLYMRL2TEx81S+3EfQMKx+AfVkGUzszhcDI7w==
X-Received: by 2002:a63:63c7:: with SMTP id x190mr6932329pgb.90.1599979140154;
        Sat, 12 Sep 2020 23:39:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:e90c:6654:7f88:72c0? ([2601:647:4200:3be0:e90c:6654:7f88:72c0])
        by smtp.gmail.com with ESMTPSA id ep4sm5581334pjb.39.2020.09.12.23.38.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 23:38:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Bug Report] Kernel 4.14+ TPM Driver Bug for Atmel TPM Chip
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <E4B2AA8B-1694-44D0-B444-1284E02612CA@rubrik.com>
Date:   Sat, 12 Sep 2020 23:38:57 -0700
Cc:     linux-integrity@vger.kernel.org,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A125545-8482-4833-A89F-1DF4166DD500@rubrik.com>
References: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
 <20200911041800.GA541925@kroah.com>
 <5518aa6e-a10f-9e07-e885-2ab43a0906e9@linux.ibm.com>
 <d9fc244f-f8ac-64cf-2b8f-0b13685fe6be@molgen.mpg.de>
 <B003F2A9-2DF5-4633-91C4-FD6B8A3353ED@rubrik.com>
 <5a62669c-59e2-861a-f851-bd28e5e84e36@molgen.mpg.de>
 <2DUJGQ.3X1TLM389WIN@hpe.com>
 <E4B2AA8B-1694-44D0-B444-1284E02612CA@rubrik.com>
To:     Hamza Attak <hamza@hpe.com>, Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Hamza, Paul, and Ken,

I just took a look at the TPM driver code and specifically =
tpm_infineon.c, but it looks like it is not that straightforward to =
override TPM_TIMEOUT by TPM chip today. I may not have good expertise to =
make that done shortly.=20

Could we checkin the global fix first to address the regression? Or =
someone with more TPM driver expertise can help work on the TPM-chip =
specific fix?

Thanks
Hao

> On Sep 12, 2020, at 9:51 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
> Sorry again and resend following email in plaintext
> -------
>=20
> Hi Hamza and everyone,
>=20
> Thanks Hamza for the response on this issue.=20
>=20
>> The first aim of the patch you mentioned is not to shorten TPM =
timings, as no
>> timing is changed at all on this patch, but to count time more =
accurately.
> It is true that the code was not intended to do so explicitly, however =
the fact is that counting time more accurately in this context is =
shortening the TPM timings.
>=20
>> If your TPM needs more time to perform a specific operation, it has =
nothing to
>> do with this patch, but rather with its specified timings in the =
kernel. The
>> timings for your Atmel TPM were certainly wrong before 4.14 to begin =
with, they
>> were not counted accurately and your TPM working was potentially a =
"positive"
>> side effect of the imprecise time counting (ie non-specified delays =
were added
>> every time msleep was used instead of usleep_range).
>> TPM polling should not be affected because we use a different way to =
count
>> timings in the kernel.
> As our experiments show, the msleep is not inaccurate specifically to =
atmel TPM, but inaccurate in general in the kernel (or linux). Before =
the patch, it is likely all TPM timings are around 15ms instead of 5ms. =
(Which is why  =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3 says =E2=80=9Cwe see results going from 1m57s unpatched to 40s")=20=

>=20
>> If you see issues with your Atmel TPM, I'd suggest to make the =
changes in the
>> tpm_atmel code only (tpm_infineon would be a suitable example to look =
at) and
>> discuss the timing values with Atmel TPMs experts, but reverting this =
patch and
>> affecting all the other TPMs seems like a misunderstanding.
> I understand that the patch =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3 makes the timing more accurate, that surfaced the issue. I am =
not sure how the original 5ms timeout came up at very beginning. If =
there is already a TPM standard with the 5ms, I agree that TPM hardware =
manufacturers should follow that. If the 5ms in the driver code was =
defined based on the tests on which hardwares, then it is likely that =
the inaccurate msleep mislead the original author. But in either way, we =
probably need a fix in driver code instead of hardware fix or firmware =
fix to resolve the breakage.
>=20
> It is not only observed in the Atmel TPM in Rubrik=E2=80=99s =
inventory, but also has been observed in multiple our customers=E2=80=99 =
machines. Thus I think it has wide impact on Atmel TPM chips, and code =
fix is required.   =20
>=20
> =46rom this issue, it looks like the timeout value could be different =
across TPM chip manufacturers, probably the QA on such change is better =
to be required for all TPM chip manufacturers in the future ? It looks =
like =
https://github.com/torvalds/linux/commit/9f3fc7bcddcb51234e23494531f93ab60=
475e1c3  has only tested IFX and STM, which potentially is the root =
cause of the issue. I am not familiar with the QA process of linux =
kernel, so correct me if I am wrong.
>=20
> Regarding of the final fix in the master, I agree that Atmel-specific =
fix is probably better than global fix. I can take a further look in =
this path, if folks all agree on that. Let me know your thoughts.
>=20
> Thanks
> Hao
>=20
>> On Sep 12, 2020, at 7:17 AM, hamza@hpe.com wrote:
>>=20
>> Hello everyone,
>>=20
>> Dear Hao,
>>=20
>> The first aim of the patch you mentioned is not to shorten TPM =
timings, as no
>> timing is changed at all on this patch, but to count time more =
accurately.
>>=20
>> If your TPM needs more time to perform a specific operation, it has =
nothing to
>> do with this patch, but rather with its specified timings in the =
kernel. The
>> timings for your Atmel TPM were certainly wrong before 4.14 to begin =
with, they
>> were not counted accurately and your TPM working was potentially a =
"positive"
>> side effect of the imprecise time counting (ie non-specified delays =
were added
>> every time msleep was used instead of usleep_range).
>> TPM polling should not be affected because we use a different way to =
count
>> timings in the kernel.
>>=20
>> If you see issues with your Atmel TPM, I'd suggest to make the =
changes in the
>> tpm_atmel code only (tpm_infineon would be a suitable example to look =
at) and
>> discuss the timing values with Atmel TPMs experts, but reverting this =
patch and
>> affecting all the other TPMs seems like a misunderstanding.
>>=20
>> Thanks,
>> Hamza ATTAK.
>>=20
>> On Sat, Sep 12, 2020 at 10:14, Paul Menzel <pmenzel@molgen.mpg.de> =
wrote:
>>> Dear Hao,
>>> Thank you for the reply.
>>> Am 12.09.20 um 10:10 schrieb Hao Wu:
>>>> Thanks for quick responses over this report.
>>> Thank you for the quick follow-up.
>>>>> Hao, I wouldn=C2=B4t expect a longer timeout causing the TPM to be
>>>>> queried less frequently, but I do not know the code well.
>>>> =46rom our understanding, the TPM queries might be retried due to =
some
>>>> reason, increase timeout 3x would lower the query frequency to 1/3.
>>>> The explanation might be wrong, but the fact looks like the timeout
>>>> matters.  Unfortunately, engineers from Rubrik are not experts over
>>>> the TPM driver code neither :(
>>>>>> Be careful about making this a global change.  It could reduce
>>>>>> the TPM performance by 3x. We don't want to affect all TPMs to
>>>>>> fix a bug in an old TPM 1.2 chip from one vendor.
>>>>> Linux has a no regression policy, so the performance penalty
>>>>> wouldn=C2=B4t matter. Unfortunately, the regression was only =
noticed
>>>>> several years after being introduced in Linux v4.14-rc2.
>>>> So does that mean we are good to apply the global change ? Or we =
need
>>>> to discuss about the actual fix further?
>>> To get a fix into the stable series, it first needs to be applied to =
the master branch. I guess you tested also with Linux master, right?
>>> Please add the explanation from your email to Greg into the git =
commit message, format the patch with `git format-patch -1 -o outgoing` =
and send it with `git send-email outgoing/*` to the addresses listed for =
the subsystem in `MAINTAINERS` and the people listed in the commit =
introducing the regression.
>>> Then it can be properly reviewed and discussed.
>>> Kind regards,
>>> Paul
>>=20
>>=20
>=20

