Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577132B2B54
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Nov 2020 05:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgKNEje (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Nov 2020 23:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKNEje (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Nov 2020 23:39:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A62C0613D1
        for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2020 20:39:32 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w6so9333203pfu.1
        for <linux-integrity@vger.kernel.org>; Fri, 13 Nov 2020 20:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h2SmTo2VVuPol42bbBljNT/XftAlZHcVhwYRAkkRSK8=;
        b=B8qSDtgYlompAYQbM0RzN4ucspR3V94OQH8jDaTInnwjcJ2rQzCn5ReFHM7W0EaDRr
         EOR8ILcfh8rSJAtqPqmt2FNNEPGQ1UqRYKbKI3hv+9omqC+8ou25dLYqhAKgZf4hsLR4
         Bb9SPCHbkDNMCJBuZylLbk3oreoqcWmewEKvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=h2SmTo2VVuPol42bbBljNT/XftAlZHcVhwYRAkkRSK8=;
        b=VLYmCQBX5pdU4Us3eW2lJDxqgdbExv+bG4PuFDwWIfawtEgHSN2yCrKCRup4FNcxv6
         Gc+XrBvQ356lVgpi6g42SSd+gHXO5g3q+mMM98/OGJYggHrCP76sc2U9LnrA5HLi2ghv
         VasowJ5AAe8vt6H24WwPt5n1OidUoPFfvouG31DgPL6pRVyW0PKR/Z53UPdnOfdI+p4j
         4ixqGaEyn2x+Fi47TAY1k907R5WXiFE7dSV3Ya7LZkeqObke1iCJIqU1OyaQ3FmTr9Ke
         NGNwH9DkwvgneH8sDpkTQW5/yleTa1yCxUT3qto/611QUs+thechUl5oyiCTU76ETeeV
         expw==
X-Gm-Message-State: AOAM533qhLO+m2Bu+xfp6A01ACwGecKB2cKDOGuowZVHXJ8ELVn9dCdb
        jVPaiJsNQ/9ms0ABV28ziz+jwA==
X-Google-Smtp-Source: ABdhPJyxjTV+jkVk86Fe8aMp4QbC9zycY8vsKuvFLejvT7wsa3+0ABOvg1RP+gdC0RWSwsa7/L4SNA==
X-Received: by 2002:a63:2cd4:: with SMTP id s203mr4507749pgs.54.1605328771651;
        Fri, 13 Nov 2020 20:39:31 -0800 (PST)
Received: from ?IPv6:2601:647:4200:3be0:1843:53b1:ef78:c159? ([2601:647:4200:3be0:1843:53b1:ef78:c159])
        by smtp.gmail.com with ESMTPSA id h9sm12864525pjs.26.2020.11.13.20.39.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 20:39:31 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <53B75B06-FD89-4B00-BC3F-46C5B28DC201@rubrik.com>
Date:   Fri, 13 Nov 2020 20:39:28 -0800
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
Message-Id: <9E249567-4901-4FA4-BA89-EF6DE51F7E7A@rubrik.com>
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
 <53B75B06-FD89-4B00-BC3F-46C5B28DC201@rubrik.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Oct 17, 2020, at 10:20 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
>> On Oct 17, 2020, at 10:09 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>=20
>> On Fri, Oct 16, 2020 at 11:11:37PM -0700, Hao Wu wrote:
>>>> On Oct 1, 2020, at 4:04 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>>>>=20
>>>> On Thu, Oct 01, 2020 at 11:32:59AM -0700, James Bottomley wrote:
>>>>> On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
>>>>>> On 10/1/20 12:53 AM, James Bottomley wrote:
>>>>>>> On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
>>>>>>>> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley =
wrote:
>>>>>>>>> On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
>>>>> [...]
>>>>>>>>>> I also wonder if we could adjust the frequency dynamically.
>>>>>>>>>> I.e. start with optimistic value and lower it until finding
>>>>>>>>>> the sweet spot.
>>>>>>>>>=20
>>>>>>>>> The problem is the way this crashes: the TPM seems to be
>>>>>>>>> unrecoverable. If it were recoverable without a hard reset of
>>>>>>>>> the entire machine, we could certainly play around with it.  I
>>>>>>>>> can try alternative mechanisms to see if anything's viable, =
but
>>>>>>>>> to all intents and purposes, it looks like my TPM simply stops
>>>>>>>>> responding to the TIS interface.
>>>>>>>>=20
>>>>>>>> A quickly scraped idea probably with some holes in it but I was
>>>>>>>> thinking something like
>>>>>>>>=20
>>>>>>>> 1. Initially set slow value for latency, this could be the
>>>>>>>> original 15 ms.
>>>>>>>> 2. Use this to read TPM_PT_VENDOR_STRING_*.
>>>>>>>> 3. Lookup based vendor string from a fixup table a latency that
>>>>>>>> works
>>>>>>>>  (the fallback latency could be the existing latency).
>>>>>>>=20
>>>>>>> Well, yes, that was sort of what I was thinking of doing for the
>>>>>>> Atmel ... except I was thinking of using the TIS VID (16 byte
>>>>>>> assigned vendor ID) which means we can get the information to =
set
>>>>>>> the timeout before we have to do any TPM operations.
>>>>>>=20
>>>>>> I wonder if the timeout issue exists for all TPM commands for the
>>>>>> same manufacturer.  For example, does the ATMEL TPM also crash =
when=20
>>>>>> extending  PCRs ?
>>>>>>=20
>>>>>> In addition to defining a per TPM vendor based lookup table for
>>>>>> timeout, would it be a good idea to also define a Kconfig/boot =
param
>>>>>> option to allow timeout setting.  This will enable to set the =
timeout
>>>>>> based on the specific use.
>>>>>=20
>>>>> I don't think we need go that far (yet).  The timing change has =
been in
>>>>> upstream since:
>>>>>=20
>>>>> commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
>>>>> Author: Nayna Jain <nayna@linux.vnet.ibm.com>
>>>>> Date:   Wed May 16 01:51:25 2018 -0400
>>>>>=20
>>>>>  tpm: reduce polling time to usecs for even finer granularity
>>>>>=20
>>>>> Which was in the released kernel 4.18: over two years ago.  In all =
that
>>>>> time we've discovered two problems: mine which looks to be an =
artifact
>>>>> of an experimental upgrade process in a new nuvoton and the Atmel.=20=

>>>>> That means pretty much every other TPM simply works with the =
existing
>>>>> timings
>>>>>=20
>>>>>> I was also thinking how will we decide the lookup table values =
for
>>>>>> each vendor ?
>>>>>=20
>>>>> I wasn't thinking we would.  I was thinking I'd do a simple =
exception
>>>>> for the Atmel and nothing else.  I don't think my Nuvoton is in =
any way
>>>>> characteristic.  Indeed my pluggable TPM rainbow bridge system =
works
>>>>> just fine with a Nuvoton and the current timings.
>>>>>=20
>>>>> We can add additional exceptions if they actually turn up.
>>>>=20
>>>> I'd add a table and fallback.
>>>>=20
>>>=20
>>> Hi folks,
>>>=20
>>> I want to follow up this a bit and check whether we reached a =
consensus=20
>>> on how to fix the timeout issue for Atmel chip.
>>>=20
>>> Should we revert the changes or introduce the lookup table for =
chips.
>>>=20
>>> Is there anything I can help from Rubrik side.
>>>=20
>>> Thanks
>>> Hao
>>=20
>> There is nothing to revert as the previous was not applied but I'm
>> of course ready to review any new attempts.
>>=20
>=20
> Hi Jarkko,
>=20
> By =E2=80=9Crevert=E2=80=9D I meant we revert the timeout value =
changes by applying
> the patch I proposed, as the timeout value discussed does cause =
issues.
>=20
> Why don=E2=80=99t we apply the patch and improve the perf in the way =
of not
> breaking TPMs ?=20
>=20
> Hao

Hi Jarkko and folks,

It=E2=80=99s being a while since our last discussion. I want to push a =
fix in the upstream for ateml chip.=20
It looks like we currently have following choices:
1.  generic fix for all vendors: have a lookup table for sleep time of =
wait_for_tpm_stat=20
  (i.e. TPM_TIMEOUT_WAIT_STAT in my proposed patch)=20
2.  quick fix for the regression: change the sleep time of =
wait_for_tpm_stat back to 15ms.
  It is the current proposed patch
3. Fix regression by making exception for ateml chip. =20

Should we reach consensus on which one we want to pursue before dig into =
implementation
of the patch? In my opinion, I prefer to fix the regression with 2, and =
then pursue 1 as long-term
solution. 3 is hacky.

Let me know what do you guys think

Hao
=20

