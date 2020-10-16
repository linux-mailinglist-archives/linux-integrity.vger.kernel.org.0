Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A02903CB
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Oct 2020 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405819AbgJPLIr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Oct 2020 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405520AbgJPLIq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Oct 2020 07:08:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3BC061755;
        Fri, 16 Oct 2020 04:08:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q5so2431646wmq.0;
        Fri, 16 Oct 2020 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CyeE9c0ri8DZaaJLpCbNjK0I2LZVtdcSzMHiFicWZdQ=;
        b=X6u4qcB72ME23V2/FUOiamq7z/NUlDIk9siaYb4yQeu183E0AYAD79gTOahyb3XkLq
         dtWMPZLVEZp1xhxx2Kp7Vgm+3DK94FTKMJL9wuO7LJE2yjr9LLSns6WuP5pyDbYpgqfU
         h7+GvDuI/Z+i6Vz8aZb/oul5WqRJUlHWdj7Q5hcZTVZ4iWMUE7saW5Rdj3W+GwIgGwYl
         bUPD3Y5BvsuvSJjcK9dQKgfJdrYhh0kDgvjj5JmPsUhrkfR77QWwAueiTKco2/Lbgf5g
         kLUBruYnZGa9Lq5j8fpDqW4ww1hgyeSu8MtjSlfmR7bjAc66jhPRbQd1FuqvaIr2KLEf
         NsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CyeE9c0ri8DZaaJLpCbNjK0I2LZVtdcSzMHiFicWZdQ=;
        b=p8PjmeW7r1H/XkmpB2sdPRCh4lNESnti6M834HHZPuB6VcqjS1gCJTuMpxaPH3IqqR
         X1lTowhK4yjZeccCQYIu/+xbO+qqmeM3IdLW4rArilPW6ZrM6fKZ6Qy/NgqdQ0yMsGlm
         vEQMT1F6jeYtbAmi5OKg7SXJf8LhlqjrHw9o+F7eOcX6GYqEndea6oVhzvpIdV3HhkOY
         XK6O5G6jjHOOyWRgyhDOANGx2KBkGpQoldGocjHADcQsg6mQlucD9kF0JlLz67MGFlJy
         EdpV2st01uUOTKDSEGN1NCF6ZXp3siR9bLWyOWmLmDhhYmH+xJTDYQlbMMBaD+YKfw7M
         axww==
X-Gm-Message-State: AOAM533lfEKSFdi6V/uKoDUydBk4aAZeGVt9yXnfxprX37sIMhF3AZZU
        9WMZSvEAJFJ1rG9BITKqz9U=
X-Google-Smtp-Source: ABdhPJyfD9ox0U8gcAU/f81G3qwY/85pZvnmT/4SOWBtl2/6lDsOXRSJQZEux9BYof6GQDQf5Y8aJw==
X-Received: by 2002:a1c:6488:: with SMTP id y130mr3213167wmb.94.1602846525351;
        Fri, 16 Oct 2020 04:08:45 -0700 (PDT)
Received: from [192.168.2.27] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id 67sm2365255wmb.31.2020.10.16.04.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 04:08:44 -0700 (PDT)
Subject: Re: [PATCH v2] dm verity: Add support for signature verification with
 2nd keyring
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20201015150504.1319098-1-mic@digikod.net>
 <20201015165229.GA5513@redhat.com>
 <022e949e-00c4-d98a-b536-1c5f9e05c09c@digikod.net>
 <b7ba2ff9-5f5f-8c1e-dfaa-33da56d3d8de@digikod.net>
From:   Milan Broz <gmazyland@gmail.com>
Message-ID: <b7ccaa01-0398-f108-a70d-c67753d9fa6d@gmail.com>
Date:   Fri, 16 Oct 2020 13:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <b7ba2ff9-5f5f-8c1e-dfaa-33da56d3d8de@digikod.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 16/10/2020 10:49, Mickaël Salaün wrote:
> On 16/10/2020 10:29, Mickaël Salaün wrote:
>>
>> On 15/10/2020 18:52, Mike Snitzer wrote:
>>> Can you please explain why you've decided to make this a Kconfig CONFIG
>>> knob?  Why not either add: a dm-verity table argument? A dm-verity
>>> kernel module parameter? or both (to allow a particular default but then
>>> per-device override)?
>>
>> The purpose of signed dm-verity images is to authenticate files, or said
>> in another way, to enable the kernel to trust disk images in a flexible
>> way (i.e. thanks to certificate's chain of trust). Being able to update
>> such chain at run time requires to use the second trusted keyring. This
>> keyring automatically includes the certificate authorities from the
>> builtin trusted keyring, which are required to dynamically populate the
>> secondary trusted keyring with certificates signed by an already trusted
>> authority. The roots of trust must then be included at build time in the
>> builtin trusted keyring.
>>
>> To be meaningful, using dm-verity signatures implies to have a
>> restricted user space, i.e. even the root user has limited power over
>> the kernel and the rest of the system. Blindly trusting data provided by
>> user space (e.g. dm-verity table argument, kernel module parameter)
>> defeat the purpose of (mandatory) authenticated images.
>>
>>>
>>> Otherwise, _all_ DM verity devices will be configured to use secondary
>>> keyring fallback.  Is that really desirable?
>>
>> That is already the current state (on purpose).
> 
> I meant that when DM_VERITY_VERIFY_ROOTHASH_SIG is set, dm-verity
> signature becomes mandatory. This new configuration
> DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING extend this trust to the
> secondary trusted keyring, which contains certificates signed (directly
> or indirectly) by CA from the builtin trusted keyring.
> 
> So yes, this new (optional) configuration *extends* the source of trust
> for all dm-verity devices, and yes, it is desirable. I think it should
> have been this way from the beginning (as for other authentication
> mechanisms) but it wasn't necessary at that time.

Well, I understand why you need a config option here.
And using the secondary keyring actually makes much more sense to me than
the original approach.

But please do not forget that dm-verity is sometimes used in different
contexts where such strict in-kernel certificate trust is unnecessary.
With your configure options set, you deliberately remove the possibility
to configure such devices.
I understand that it is needed for "trusted" systems, but we should be clear
in the documentation.
Maybe also add note to /Documentation/admin-guide/device-mapper/verity.rst ?
We already mention DM_VERITY_VERIFY_ROOTHASH_SIG there.

The current userspace configuration through veritysetup does not need
any patches for your patch, correct?

Thanks,
Milan

