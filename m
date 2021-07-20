Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAF83D01FD
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGTSSk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGTSSb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 14:18:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42BC061574;
        Tue, 20 Jul 2021 11:59:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b2so7323020plx.1;
        Tue, 20 Jul 2021 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IAhbRYwjMmEqu25LoPbZlAoP67lU12MvAIcvWLy3jNU=;
        b=pjU9fse7Cs6N7xm64l6i3UqU3PXkF0PDd8K7KKfftjfhl1E9Hp9iQDl0yWHTJ1llzf
         PomNS4XmRllC50yH5TSb76JdWvCBQhzCc3ej4Lop+CP00z0Hc5HTU65LWGxD6V/+WiNi
         gaaaqXI0NdL4g+RbqUzOM/ajTFR/FsJ6VI5L97Tv0GuzSdSjYexORn6yfAeN3dBHCvhS
         7/wscvBAQ4awUYv+cuii+4ONBc4FEVNj59B92coJfANU6ufPoB1Wit+UxoP96KLc5EH4
         i+MsJyqMKoYXHXmTG7fbGGNZYR7ncGSmpUAYg3/Q1mZ9m6un38iGfVY5gOLEEPEA1G2/
         ZyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IAhbRYwjMmEqu25LoPbZlAoP67lU12MvAIcvWLy3jNU=;
        b=PvjIKdqO1no3OMo8lNvvMV9LqCz9GxZ2uDVMoGJITwn8PU7gt4ZWJeBG74Jwq6EmKF
         Z3C/hFVsGVOPq2PVvSp4prOUsuMTFgJYPcgsI60YJ74NGoiyaW+Qbqz9No7EzO5S1IbM
         XHo7ORHw3FD9Op/AgZ/VJuXXRvR3PrSsHQv7TmZ0M8rfQmMjFSPKQLAMmd6K5pVPjwAO
         av6xgRoOx1dGypzCnvJc9S+VJYtwz0iix0pbjpu6TU6NsZzN/xN3OThloyCqGDl6obXV
         C+oOO0hvxTLcK1mP3luUt2eb7882QkvEoW3Qx1LIWVCDbkolaZp2iizPLhp00AnTAIpd
         qzhA==
X-Gm-Message-State: AOAM5315jYqmjaBB8lLTKBML6mizRWMaSwhsO/ktYxnfYSSyLJbAMSBd
        8UJ4T9kwkAlp9DGxZ2IqQujxJKJew6VuZQ==
X-Google-Smtp-Source: ABdhPJxAHOcEC2LyEECia9/kIZZivpfGTz+7IMZioqtyWrdCy9leyuIrUrLKKhjhl8+AQjH6Hgd6ig==
X-Received: by 2002:a17:90b:1294:: with SMTP id fw20mr37237488pjb.100.1626807543849;
        Tue, 20 Jul 2021 11:59:03 -0700 (PDT)
Received: from [10.67.49.104] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v15sm8758993pff.105.2021.07.20.11.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 11:59:03 -0700 (PDT)
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210716022332.GC3232@sequoia>
 <CAHLZf_t5U1bh1H8sULbJz7xrZ-r3Dcmxuw9MMmG2fehS3C72uQ@mail.gmail.com>
 <CAHUa44EetPuA_5+UQLW-c=-_OApiRoiq+YjeFs6TRPj6=AJfHw@mail.gmail.com>
 <903824a6-7a2b-1514-5b71-a2db634e9abf@gmail.com>
 <bc3f4bdd-b833-d58c-f7d7-6670bcbd8ef8@gmail.com>
 <20210720181517.GF3232@sequoia>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <22e55ae6-3ecb-4f54-b9e6-1b902d4d4e20@gmail.com>
Date:   Tue, 20 Jul 2021 11:59:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720181517.GF3232@sequoia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/20/21 11:15 AM, Tyler Hicks wrote:
> On 2021-07-20 10:57:18, Florian Fainelli wrote:
>>
>>
>> On 7/19/2021 7:32 PM, Florian Fainelli wrote:
>>>
>>>
>>> On 7/19/2021 3:49 AM, Jens Wiklander wrote:
>>>> Hi,
>>>>
>>>> On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta
>>>> <vikas.gupta@broadcom.com> wrote:
>>>>>
>>>>> Hi Allen/Tyler,
>>>>>   The patch looks good to me.
>>>>
>>>> Thanks.
>>>>
>>>> Rafal, is it OK if I include this patch together with the rest of the
>>>> patches in this patch set in a pull request to arm-soc?
>>>
>>> I can take those patches through the Broadcom ARM SoC pull request,
>>> Rafal would that work for you? We seem to have a bit of a maintainer
>>> coverage blind spot for that directory.
>>
>> Applied to drivers/fixes: https://github.com/Broadcom/stblinux/commit/4ecd797b7e16eb7f1b86fbfd7e4a7887b192535b
> 
> Thanks, Florian, but note that you won't be able to build that branch
> since the commit uses a new function (tee_shm_alloc_kernel_buf()) that's
> added earlier in the full series. It seems like it is going to be easier
> for this to all go through Jens.

I was grepping for the new functions added and could find all
references, though it looks like I missed tee_shm_alloc_kernel_buf()
somehow, so yes, having Jens merge that series all together would make
more sense here. If you need it:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
