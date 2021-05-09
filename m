Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687F43775B0
	for <lists+linux-integrity@lfdr.de>; Sun,  9 May 2021 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhEIGcV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 9 May 2021 02:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIGcV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 May 2021 02:32:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE5C061573
        for <linux-integrity@vger.kernel.org>; Sat,  8 May 2021 23:31:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so8527864pjb.2
        for <linux-integrity@vger.kernel.org>; Sat, 08 May 2021 23:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o8u+q+TiZQm2LpUtmiBBMuWuvl8sbNL9x/FR+CJdsAo=;
        b=QLxysjdq45g8g5umqn+hlNEurd+aWBK/I6eqdI2V9HnFQ8/3f5uVW2D9kCGIAs7YLl
         0lqJph8m3RlCYJmhsLluBYV5kaRhwIxrEN9b6rbDJQrk47q3+VWCe7oI67hwBPT4SX7L
         r6y0eBg4XUqXZETqlIhRHnYNuo+JRv8x2LSMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o8u+q+TiZQm2LpUtmiBBMuWuvl8sbNL9x/FR+CJdsAo=;
        b=nunS17Q2WYWNMsGSC7y7YyEMjDQJKjXOut4Qu60dxSS0AJiF6CHo0cM2ZutGAYCvaq
         Gc0NwKla5XXTyna6UCd4r1kjIox0dkYerBxLyeU8W5Pn0hQkAjHKQPHjopm6XGwznS8c
         DipmOETy+s/eaOi+suiEZRDRmwxRISdMUZIq39t3HutYhktFPriTyAofsDIInGPs2OsA
         N35rkzd4aPbI3EPBSA+08E2yJtb6jcNodhBumo/cAqAAWzcxXJtuMltPTwPFpFsTdDNd
         Hpw6PtBEj/xyScapYNF/r+drcRPWTYGrqrjESgkBkrRBniaGCVRPGwt9h5HPcxUbZ1Av
         uzuA==
X-Gm-Message-State: AOAM533BuvQNBxl+vrgsCen0D/xdw0FWwl5O2f/Oa7EOAeBMN9I3I15x
        lrvFvNEUd97VaRnlO1z5DGTeSg==
X-Google-Smtp-Source: ABdhPJzF/VVus2rcaM+S+8shto1ZJQM+/8dRHznZjf2a4WmIzB0bJqAboQRnD2Oa1L2JipGw5pFgyg==
X-Received: by 2002:a17:90a:a61:: with SMTP id o88mr20894039pjo.8.1620541876839;
        Sat, 08 May 2021 23:31:16 -0700 (PDT)
Received: from [10.0.0.7] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id z27sm8483346pfr.46.2021.05.08.23.31.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 May 2021 23:31:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <B55FCFAC-BFBD-4568-AB2F-45DD7BE10D6D@rubrik.com>
Date:   Sat, 8 May 2021 23:31:06 -0700
Cc:     Nayna <nayna@linux.vnet.ibm.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org, Hamza Attak <hamza@hpe.com>,
        why2jjj.linux@gmail.com, zohar@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <12157F1B-93CC-4991-813D-B78A608D1C4F@rubrik.com>
References: <6e7b54c268d25a86f8f969bcc01729eaadef6530.camel@HansenPartnership.com>
 <20201001015051.GA5971@linux.intel.com>
 <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
 <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
 <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
 <20201001230426.GA26517@linux.intel.com>
 <FCA90A49-CCE3-4DDF-A876-230C42744D2A@rubrik.com>
 <20201018050951.GL68722@linux.intel.com>
 <53B75B06-FD89-4B00-BC3F-46C5B28DC201@rubrik.com>
 <9E249567-4901-4FA4-BA89-EF6DE51F7E7A@rubrik.com>
 <20201118211134.GA5034@linux.intel.com>
 <B55FCFAC-BFBD-4568-AB2F-45DD7BE10D6D@rubrik.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On May 8, 2021, at 11:18 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
>> On Nov 18, 2020, at 1:11 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>=20
>> On Fri, Nov 13, 2020 at 08:39:28PM -0800, Hao Wu wrote:
>>>> On Oct 17, 2020, at 10:20 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>>>>=20
>>>>> On Oct 17, 2020, at 10:09 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>>>=20
>>>>> On Fri, Oct 16, 2020 at 11:11:37PM -0700, Hao Wu wrote:
>>>>>>> On Oct 1, 2020, at 4:04 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>>>>>=20
>>>>>>> On Thu, Oct 01, 2020 at 11:32:59AM -0700, James Bottomley wrote:
>>>>>>>> On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
>>>>>>>>> On 10/1/20 12:53 AM, James Bottomley wrote:
>>>>>>>>>> On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
>>>>>>>>>>> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley =
wrote:
>>>>>>>>>>>> On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
>>>>>>>> [...]
>>>>>>>>>>>>> I also wonder if we could adjust the frequency =
dynamically.
>>>>>>>>>>>>> I.e. start with optimistic value and lower it until =
finding
>>>>>>>>>>>>> the sweet spot.
>>>>>>>>>>>>=20
>>>>>>>>>>>> The problem is the way this crashes: the TPM seems to be
>>>>>>>>>>>> unrecoverable. If it were recoverable without a hard reset =
of
>>>>>>>>>>>> the entire machine, we could certainly play around with it. =
 I
>>>>>>>>>>>> can try alternative mechanisms to see if anything's viable, =
but
>>>>>>>>>>>> to all intents and purposes, it looks like my TPM simply =
stops
>>>>>>>>>>>> responding to the TIS interface.
>>>>>>>>>>>=20
>>>>>>>>>>> A quickly scraped idea probably with some holes in it but I =
was
>>>>>>>>>>> thinking something like
>>>>>>>>>>>=20
>>>>>>>>>>> 1. Initially set slow value for latency, this could be the
>>>>>>>>>>> original 15 ms.
>>>>>>>>>>> 2. Use this to read TPM_PT_VENDOR_STRING_*.
>>>>>>>>>>> 3. Lookup based vendor string from a fixup table a latency =
that
>>>>>>>>>>> works
>>>>>>>>>>> (the fallback latency could be the existing latency).
>>>>>>>>>>=20
>>>>>>>>>> Well, yes, that was sort of what I was thinking of doing for =
the
>>>>>>>>>> Atmel ... except I was thinking of using the TIS VID (16 byte
>>>>>>>>>> assigned vendor ID) which means we can get the information to =
set
>>>>>>>>>> the timeout before we have to do any TPM operations.
>>>>>>>>>=20
>>>>>>>>> I wonder if the timeout issue exists for all TPM commands for =
the
>>>>>>>>> same manufacturer.  For example, does the ATMEL TPM also crash =
when=20
>>>>>>>>> extending  PCRs ?
>>>>>>>>>=20
>>>>>>>>> In addition to defining a per TPM vendor based lookup table =
for
>>>>>>>>> timeout, would it be a good idea to also define a Kconfig/boot =
param
>>>>>>>>> option to allow timeout setting.  This will enable to set the =
timeout
>>>>>>>>> based on the specific use.
>>>>>>>>=20
>>>>>>>> I don't think we need go that far (yet).  The timing change has =
been in
>>>>>>>> upstream since:
>>>>>>>>=20
>>>>>>>> commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
>>>>>>>> Author: Nayna Jain <nayna@linux.vnet.ibm.com>
>>>>>>>> Date:   Wed May 16 01:51:25 2018 -0400
>>>>>>>>=20
>>>>>>>> tpm: reduce polling time to usecs for even finer granularity
>>>>>>>>=20
>>>>>>>> Which was in the released kernel 4.18: over two years ago.  In =
all that
>>>>>>>> time we've discovered two problems: mine which looks to be an =
artifact
>>>>>>>> of an experimental upgrade process in a new nuvoton and the =
Atmel.=20
>>>>>>>> That means pretty much every other TPM simply works with the =
existing
>>>>>>>> timings
>>>>>>>>=20
>>>>>>>>> I was also thinking how will we decide the lookup table values =
for
>>>>>>>>> each vendor ?
>>>>>>>>=20
>>>>>>>> I wasn't thinking we would.  I was thinking I'd do a simple =
exception
>>>>>>>> for the Atmel and nothing else.  I don't think my Nuvoton is in =
any way
>>>>>>>> characteristic.  Indeed my pluggable TPM rainbow bridge system =
works
>>>>>>>> just fine with a Nuvoton and the current timings.
>>>>>>>>=20
>>>>>>>> We can add additional exceptions if they actually turn up.
>>>>>>>=20
>>>>>>> I'd add a table and fallback.
>>>>>>>=20
>>>>>>=20
>>>>>> Hi folks,
>>>>>>=20
>>>>>> I want to follow up this a bit and check whether we reached a =
consensus=20
>>>>>> on how to fix the timeout issue for Atmel chip.
>>>>>>=20
>>>>>> Should we revert the changes or introduce the lookup table for =
chips.
>>>>>>=20
>>>>>> Is there anything I can help from Rubrik side.
>>>>>>=20
>>>>>> Thanks
>>>>>> Hao
>>>>>=20
>>>>> There is nothing to revert as the previous was not applied but I'm
>>>>> of course ready to review any new attempts.
>>>>>=20
>>>>=20
>>>> Hi Jarkko,
>>>>=20
>>>> By =E2=80=9Crevert=E2=80=9D I meant we revert the timeout value =
changes by applying
>>>> the patch I proposed, as the timeout value discussed does cause =
issues.
>>>>=20
>>>> Why don=E2=80=99t we apply the patch and improve the perf in the =
way of not
>>>> breaking TPMs ?=20
>>>>=20
>>>> Hao
>>>=20
>>> Hi Jarkko and folks,
>>>=20
>>> It=E2=80=99s being a while since our last discussion. I want to push =
a fix in the upstream for ateml chip.=20
>>> It looks like we currently have following choices:
>>> 1.  generic fix for all vendors: have a lookup table for sleep time =
of wait_for_tpm_stat=20
>>> (i.e. TPM_TIMEOUT_WAIT_STAT in my proposed patch)=20
>>> 2.  quick fix for the regression: change the sleep time of =
wait_for_tpm_stat back to 15ms.
>>> It is the current proposed patch
>>> 3. Fix regression by making exception for ateml chip. =20
>>>=20
>>> Should we reach consensus on which one we want to pursue before dig
>>> into implementation of the patch? In my opinion, I prefer to fix the
>>> regression with 2, and then pursue 1 as long-term solution. 3 is
>>> hacky.
>>=20
>> What does option 1 fix for *all* vendors?
>>=20
>>> Let me know what do you guys think
>>>=20
>>> Hao
>>=20
>> /Jarkko
>=20
> Hi Jarkko and folks,
>=20
> It has been a while again. In my previous message I answered =
Jarkko=E2=80=99s question about the option 1.
> Jarkko, let me know if it is clear to you or you have further =
questions and suggestions on next to do.
> Somehow I couldn=E2=80=99t found the last message I sent but it is in=20=

> =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>=20
> In high-level, the option 1 is to add a timing lookup table for each =
manufacture, hence we can
> configure timing for each chip respectively. Then we don=E2=80=99t =
need to worry about fixing ATMEL
> timing may cause performance degradation for other chips.
>=20
> I do want to push the fix in TPM driver, which is likely to be hit =
going forward again when people are doing
> refactoring without testing chips from all manufacturing.
>=20
> Let me know how should I push this forward.
>=20
> Thanks
> Hao
>=20
It looks like Jarkko=E2=80=99s email address =
(jarkko.sakkinen@linux.intel.com) is unreachable now,
can other TPM maintainer / reviewer help make a call and unblock this ?=20=


Thanks
Hao=
