Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE67B291006
	for <lists+linux-integrity@lfdr.de>; Sat, 17 Oct 2020 08:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436915AbgJQGLm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 17 Oct 2020 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436909AbgJQGLm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Oct 2020 02:11:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A6FC061755
        for <linux-integrity@vger.kernel.org>; Fri, 16 Oct 2020 23:11:40 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d6so2361024plo.13
        for <linux-integrity@vger.kernel.org>; Fri, 16 Oct 2020 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nP8mvxSV7tw8PInk+K2wHf63EDLZs/W6OS8vvfe9ySI=;
        b=G0JSKB8X8YnWHdvS17ZWAEts6oGr+ojJH7IKaDn/lSz8rJBJjktPWUpWyBLBMsTZpM
         YWZZBAhWl8Ox7jSoHVgDBEbYVVISSYdHowf5pHiBQNSiYF2UVJNYcMuxAPmx8al8teCs
         e4398HSM6YXrKK+R5LIo6vvvedlEoHExetFQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nP8mvxSV7tw8PInk+K2wHf63EDLZs/W6OS8vvfe9ySI=;
        b=AccclZleYIL7VzDClII2stuHWqF1+H45W1g04o+HaI5H3PP/PRAilkexmQifUUthFg
         iXbCtrlvrGHJJaKFHwjJrSazFBMFZSbP0MH26aZPLzzO/phRvEiZjjdYkQH8Z1+NXG3N
         bkP9pBFdyxJ1wWqif2+V476Ev1P4vOsGk+WjUNwX492ZuL8SdRvgo2VYpiu9+TWzjEu4
         Xf0/PKFALL2wr0jsYZ9ra14L/TnsPpdweBWiMjaNrNocEffAXFCEyFbTw7wdDNzOkdHE
         rEFIldk+7384EfZxQcvBSsjy15CnpqBnK8GhzB1b1YxoUwqYVYDBZKuEMgG80kU2nQrk
         o5RA==
X-Gm-Message-State: AOAM5309YRXO94OGh4hFGvwTifyZfpiKfBeE26Jw5oVUi6QZn4aAz357
        9E5teh8ImlfhbQNnVjxp4CdRHbPhUUufP/Eyaqk=
X-Google-Smtp-Source: ABdhPJyi5wILk6mKaQ4efSu/9l5pMR63I2aCmdA+oE22xyUTO+/FcPOY0qMT/V6unhYpPHNcS531KA==
X-Received: by 2002:a17:902:b113:b029:d3:c5c2:e667 with SMTP id q19-20020a170902b113b02900d3c5c2e667mr7556059plr.35.1602915100121;
        Fri, 16 Oct 2020 23:11:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4200:3be0:8182:c989:712f:b2aa? ([2601:647:4200:3be0:8182:c989:712f:b2aa])
        by smtp.gmail.com with ESMTPSA id y27sm4804221pfr.122.2020.10.16.23.11.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2020 23:11:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20201001230426.GA26517@linux.intel.com>
Date:   Fri, 16 Oct 2020 23:11:37 -0700
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
Message-Id: <FCA90A49-CCE3-4DDF-A876-230C42744D2A@rubrik.com>
References: <20200930021637.GF808399@linux.intel.com>
 <a97706be196e2e02ca815b3011d3731684905737.camel@HansenPartnership.com>
 <20200930153715.GC52739@linux.intel.com>
 <95aafaa1e3037cb7b99ae0e76c02a419d366a407.camel@HansenPartnership.com>
 <20200930210956.GC65339@linux.intel.com>
 <6e7b54c268d25a86f8f969bcc01729eaadef6530.camel@HansenPartnership.com>
 <20201001015051.GA5971@linux.intel.com>
 <1aed1b0734435959d5e53b8a4b3c18558243e6b8.camel@HansenPartnership.com>
 <19de5527-2d56-6a07-3ce7-ba216b208090@linux.vnet.ibm.com>
 <38e165055bae62d4e97f702c05e3a76ccdeeac0f.camel@HansenPartnership.com>
 <20201001230426.GA26517@linux.intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Oct 1, 2020, at 4:04 PM, Jarkko Sakkinen =
<jarkko.sakkinen@linux.intel.com> wrote:
>=20
> On Thu, Oct 01, 2020 at 11:32:59AM -0700, James Bottomley wrote:
>> On Thu, 2020-10-01 at 14:15 -0400, Nayna wrote:
>>> On 10/1/20 12:53 AM, James Bottomley wrote:
>>>> On Thu, 2020-10-01 at 04:50 +0300, Jarkko Sakkinen wrote:
>>>>> On Wed, Sep 30, 2020 at 03:31:20PM -0700, James Bottomley wrote:
>>>>>> On Thu, 2020-10-01 at 00:09 +0300, Jarkko Sakkinen wrote:
>> [...]
>>>>>>> I also wonder if we could adjust the frequency dynamically.
>>>>>>> I.e. start with optimistic value and lower it until finding
>>>>>>> the sweet spot.
>>>>>>=20
>>>>>> The problem is the way this crashes: the TPM seems to be
>>>>>> unrecoverable. If it were recoverable without a hard reset of
>>>>>> the entire machine, we could certainly play around with it.  I
>>>>>> can try alternative mechanisms to see if anything's viable, but
>>>>>> to all intents and purposes, it looks like my TPM simply stops
>>>>>> responding to the TIS interface.
>>>>>=20
>>>>> A quickly scraped idea probably with some holes in it but I was
>>>>> thinking something like
>>>>>=20
>>>>> 1. Initially set slow value for latency, this could be the
>>>>> original 15 ms.
>>>>> 2. Use this to read TPM_PT_VENDOR_STRING_*.
>>>>> 3. Lookup based vendor string from a fixup table a latency that
>>>>> works
>>>>>    (the fallback latency could be the existing latency).
>>>>=20
>>>> Well, yes, that was sort of what I was thinking of doing for the
>>>> Atmel ... except I was thinking of using the TIS VID (16 byte
>>>> assigned vendor ID) which means we can get the information to set
>>>> the timeout before we have to do any TPM operations.
>>>=20
>>> I wonder if the timeout issue exists for all TPM commands for the
>>> same manufacturer.  For example, does the ATMEL TPM also crash when=20=

>>> extending  PCRs ?
>>>=20
>>> In addition to defining a per TPM vendor based lookup table for
>>> timeout, would it be a good idea to also define a Kconfig/boot param
>>> option to allow timeout setting.  This will enable to set the =
timeout
>>> based on the specific use.
>>=20
>> I don't think we need go that far (yet).  The timing change has been =
in
>> upstream since:
>>=20
>> commit 424eaf910c329ab06ad03a527ef45dcf6a328f00
>> Author: Nayna Jain <nayna@linux.vnet.ibm.com>
>> Date:   Wed May 16 01:51:25 2018 -0400
>>=20
>>    tpm: reduce polling time to usecs for even finer granularity
>>=20
>> Which was in the released kernel 4.18: over two years ago.  In all =
that
>> time we've discovered two problems: mine which looks to be an =
artifact
>> of an experimental upgrade process in a new nuvoton and the Atmel.=20
>> That means pretty much every other TPM simply works with the existing
>> timings
>>=20
>>> I was also thinking how will we decide the lookup table values for
>>> each vendor ?
>>=20
>> I wasn't thinking we would.  I was thinking I'd do a simple exception
>> for the Atmel and nothing else.  I don't think my Nuvoton is in any =
way
>> characteristic.  Indeed my pluggable TPM rainbow bridge system works
>> just fine with a Nuvoton and the current timings.
>>=20
>> We can add additional exceptions if they actually turn up.
>=20
> I'd add a table and fallback.
>=20

Hi folks,

I want to follow up this a bit and check whether we reached a consensus=20=

on how to fix the timeout issue for Atmel chip.

Should we revert the changes or introduce the lookup table for chips.

Is there anything I can help from Rubrik side.

Thanks
Hao
=20

