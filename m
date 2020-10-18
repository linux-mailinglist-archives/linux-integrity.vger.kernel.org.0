Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35262915FF
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Oct 2020 07:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgJRFUX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 18 Oct 2020 01:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgJRFUX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 18 Oct 2020 01:20:23 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8BC061755
        for <linux-integrity@vger.kernel.org>; Sat, 17 Oct 2020 22:20:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d23so3338426pll.7
        for <linux-integrity@vger.kernel.org>; Sat, 17 Oct 2020 22:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zhsQWT1z5HaER8SZuguyfeErof3sFlaWxr4qjsdufAk=;
        b=G8Pik2u6O6ehxWdjTioFN0PN6eWFynE4juC2K4sZ91Y3+26GKQhI83yS1GATLo2n0i
         HzxN74RWqnW4JP2iMrfWKPZMa1LcqSU1Jh/9F6ZNgXUkSPligNeMVFP+BVO+Z4R2NgTU
         +jY9dD2CdtODSTJW0pbIbvIK1g6ANb0G/c4lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zhsQWT1z5HaER8SZuguyfeErof3sFlaWxr4qjsdufAk=;
        b=gq36bOzUOFm2k5sUm5yqku0n8IwTj9OsinrhGq9cSMhYxJAMpnG8ID3/1C/55lJFS7
         SAmx1QYxvyXGgCrU5qYeAg6iIl/XWpc7uH0vp2faQ8r/VpGURRGUSK4Irolh55w+8gD6
         ticQqd62mzWqC5lGOgklqQBcDwfNuV5bLepScAA9qeHYD7up1cx34gCkkxBcYUo5TGye
         sBWqy1jn/Je8kefHumfUZ72/UbZx9ZG5zH7q4Wqxq7cEGe0bNYvx5fDJPaU1JrhLqTxQ
         eo6jjDp9+9F+o90XJs5hN/caaiB1/Ls3w/xxQkuPH6v5bSNXC50X5QaCsNB18nZbNP+C
         Ua8g==
X-Gm-Message-State: AOAM532gK4A6bG1H1C9IucMwyDddZKg4RrRu8XjsjKNTtmJ+m6hrMw+O
        /tFvFQAAxa8T2Xl14CPGp8lyT8wamwBIIemWcTQ=
X-Google-Smtp-Source: ABdhPJyykGhkMVOt9YPxmn0Cs2F9PQMB0bgqzT1cTHlguABXi4YLK2cCe7dAR4onLcjWKZsRaEDCKQ==
X-Received: by 2002:a17:90b:4a10:: with SMTP id kk16mr12033269pjb.77.1602998421146;
        Sat, 17 Oct 2020 22:20:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:8182:c989:712f:b2aa? ([2601:647:4200:3be0:8182:c989:712f:b2aa])
        by smtp.gmail.com with ESMTPSA id 9sm7747207pfx.138.2020.10.17.22.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Oct 2020 22:20:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20201018050951.GL68722@linux.intel.com>
Date:   Sat, 17 Oct 2020 22:20:18 -0700
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nayna <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <53B75B06-FD89-4B00-BC3F-46C5B28DC201@rubrik.com>
References: <20200930153715.GC52739@linux.intel.com>
 <95aafaa1e3037cb7b99ae0e76c02a419d366a407.camel@HansenPartnership.com>
 <20200930210956.GC65339@linux.intel.com>
 <6e7b54c268d25a86f8f969bcc01729eaadef6530.camel@HansenPartnership.com>
 <20201001015051.GA5971@linux.intel.com>
 <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
 <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
 <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
 <20201001230426.GA26517@linux.intel.com>
 <FCA90A49-CCE3-4DDF-A876-230C42744D2A@rubrik.com>
 <20201018050951.GL68722@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Oct 17, 2020, at 10:09 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Fri, Oct 16, 2020 at 11:11:37PM -0700, Hao Wu wrote:
>>> On Oct 1, 2020, at 4:04 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>=20
>>> On Thu, Oct 01, 2020 at 11:32:59AM -0700, James Bottomley wrote:
>>>> On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
>>>>> On 10/1/20 12:53 AM, James Bottomley wrote:
>>>>>> On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
>>>>>>> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
>>>>>>>> On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
>>>> [...]
>>>>>>>>> I also wonder if we could adjust the frequency dynamically.
>>>>>>>>> I.e. start with optimistic value and lower it until finding
>>>>>>>>> the sweet spot.
>>>>>>>>=20
>>>>>>>> The problem is the way this crashes: the TPM seems to be
>>>>>>>> unrecoverable. If it were recoverable without a hard reset of
>>>>>>>> the entire machine, we could certainly play around with it.  I
>>>>>>>> can try alternative mechanisms to see if anything's viable, but
>>>>>>>> to all intents and purposes, it looks like my TPM simply stops
>>>>>>>> responding to the TIS interface.
>>>>>>>=20
>>>>>>> A quickly scraped idea probably with some holes in it but I was
>>>>>>> thinking something like
>>>>>>>=20
>>>>>>> 1. Initially set slow value for latency, this could be the
>>>>>>> original 15 ms.
>>>>>>> 2. Use this to read TPM_PT_VENDOR_STRING_*.
>>>>>>> 3. Lookup based vendor string from a fixup table a latency that
>>>>>>> works
>>>>>>>   (the fallback latency could be the existing latency).
>>>>>>=20
>>>>>> Well, yes, that was sort of what I was thinking of doing for the
>>>>>> Atmel ... except I was thinking of using the TIS VID (16 byte
>>>>>> assigned vendor ID) which means we can get the information to set
>>>>>> the timeout before we have to do any TPM operations.
>>>>>=20
>>>>> I wonder if the timeout issue exists for all TPM commands for the
>>>>> same manufacturer.  For example, does the ATMEL TPM also crash =
when=20
>>>>> extending  PCRs ?
>>>>>=20
>>>>> In addition to defining a per TPM vendor based lookup table for
>>>>> timeout, would it be a good idea to also define a Kconfig/boot =
param
>>>>> option to allow timeout setting.  This will enable to set the =
timeout
>>>>> based on the specific use.
>>>>=20
>>>> I don't think we need go that far (yet).  The timing change has =
been in
>>>> upstream since:
>>>>=20
>>>> commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
>>>> Author: Nayna Jain <nayna@linux.vnet.ibm.com>
>>>> Date:   Wed May 16 01:51:25 2018 -0400
>>>>=20
>>>>   tpm: reduce polling time to usecs for even finer granularity
>>>>=20
>>>> Which was in the released kernel 4.18: over two years ago.  In all =
that
>>>> time we've discovered two problems: mine which looks to be an =
artifact
>>>> of an experimental upgrade process in a new nuvoton and the Atmel.=20=

>>>> That means pretty much every other TPM simply works with the =
existing
>>>> timings
>>>>=20
>>>>> I was also thinking how will we decide the lookup table values for
>>>>> each vendor ?
>>>>=20
>>>> I wasn't thinking we would.  I was thinking I'd do a simple =
exception
>>>> for the Atmel and nothing else.  I don't think my Nuvoton is in any =
way
>>>> characteristic.  Indeed my pluggable TPM rainbow bridge system =
works
>>>> just fine with a Nuvoton and the current timings.
>>>>=20
>>>> We can add additional exceptions if they actually turn up.
>>>=20
>>> I'd add a table and fallback.
>>>=20
>>=20
>> Hi folks,
>>=20
>> I want to follow up this a bit and check whether we reached a =
consensus=20
>> on how to fix the timeout issue for Atmel chip.
>>=20
>> Should we revert the changes or introduce the lookup table for chips.
>>=20
>> Is there anything I can help from Rubrik side.
>>=20
>> Thanks
>> Hao
>=20
> There is nothing to revert as the previous was not applied but I'm
> of course ready to review any new attempts.
>=20

Hi Jarkko,

By =E2=80=9Crevert=E2=80=9D I meant we revert the timeout value changes =
by applying
the patch I proposed, as the timeout value discussed does cause issues.

Why don=E2=80=99t we apply the patch and improve the perf in the way of =
not
breaking TPMs ?=20

Hao
=20

