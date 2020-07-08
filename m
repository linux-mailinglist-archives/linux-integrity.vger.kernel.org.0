Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A35218688
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 13:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgGHL65 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 07:58:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728864AbgGHL64 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 07:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594209534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QkevNhBGyNEaCjar4U2+U0onC84LFT4MZtwJK+TdKxE=;
        b=ffD/zdjqMg3bfhcDz62RK+h0rhyd91r/55vYGWVYF+JDJ5Qeg1dCX8NwKjIQ+8NCPR0gML
        BAzmWvw6r6xG6d9o7ZlI3/i8LJNVs6f00stihGI2djFFlwKH0rGzze8DXUaKfuUEF/b4k6
        JbARrwXfeXRQ+LbEsjIy5PEfQHKFjsc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-gkq-Fzy6NVmgSF68svG-hw-1; Wed, 08 Jul 2020 07:58:50 -0400
X-MC-Unique: gkq-Fzy6NVmgSF68svG-hw-1
Received: by mail-ed1-f72.google.com with SMTP id m12so57657846edv.3
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jul 2020 04:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QkevNhBGyNEaCjar4U2+U0onC84LFT4MZtwJK+TdKxE=;
        b=uLXRs6rRXI2hduri9THPkaC9cXdTpI2bU6vIhoNr+qHpjh1D5TK7zND+o7QhJ+7Vi/
         H5uOrhdY96rMfm88cbEY1w1KlUKVdce/KEq3G1taM0B1K+eRfD5EbahON9ypkjs71x7T
         EifvrvKbvpBU8lfkv5OMs5cUCbuJw7CRwBG8mXzYqil+GKOOmYODjtaCHdv/tdya5yL8
         L8xicMp4mKxuLC64+5HUebGXvTL0p38xDqUXFmbHUA8k3Z+oD+Ez6JS6EUw4AHy85lqn
         R+7Eo4EstySErcbQkD0JtrPKB55YugkqvJcH1xtnaotWECMAXk0fh9cLAu0eaLMXAqcs
         a2iQ==
X-Gm-Message-State: AOAM532R2xgAjx3kWymeAH46ulwzHI2fXlfRBiXqgjxXJCmflkESeZiu
        UufQvz0HcM72LIiP03IWdqtvc6v0qoFm2ReZHfFXD8s712m1kdGA2whjdLGi+MAY+kKd5eQSAoK
        4CzNw6cfGL8JtOUE0DMJoEdSMVGw3
X-Received: by 2002:a17:906:12cd:: with SMTP id l13mr52498665ejb.96.1594209529420;
        Wed, 08 Jul 2020 04:58:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOaKMnLhyOtq9Iubps/WQ3eLjQjfBe1IKlNFBH5VgFaQrN+6p11ckWrUzF75y/UxOFmva1gw==
X-Received: by 2002:a17:906:12cd:: with SMTP id l13mr52498652ejb.96.1594209529173;
        Wed, 08 Jul 2020 04:58:49 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u2sm28953481edq.29.2020.07.08.04.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:58:48 -0700 (PDT)
Subject: Re: [PATCH 0/4] Fix misused kernel_read_file() enums
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <3c01073b-c422-dd97-0677-c16fe1158907@redhat.com>
 <f5e65f73-2c94-3614-2479-69b2bfda9775@redhat.com>
 <20200708115517.GF4332@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8766279d-0ebe-1f64-c590-4a71a733609b@redhat.com>
Date:   Wed, 8 Jul 2020 13:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708115517.GF4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 7/8/20 1:55 PM, Luis Chamberlain wrote:
> On Wed, Jul 08, 2020 at 01:37:41PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 7/8/20 1:01 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 7/7/20 10:19 AM, Kees Cook wrote:
>>>> Hi,
>>>>
>>>> In looking for closely at the additions that got made to the
>>>> kernel_read_file() enums, I noticed that FIRMWARE_PREALLOC_BUFFER
>>>> and FIRMWARE_EFI_EMBEDDED were added, but they are not appropriate
>>>> *kinds* of files for the LSM to reason about. They are a "how" and
>>>> "where", respectively. Remove these improper aliases and refactor the
>>>> code to adapt to the changes.
>>>>
>>>> Additionally adds in missing calls to security_kernel_post_read_file()
>>>> in the platform firmware fallback path (to match the sysfs firmware
>>>> fallback path) and in module loading. I considered entirely removing
>>>> security_kernel_post_read_file() hook since it is technically unused,
>>>> but IMA probably wants to be able to measure EFI-stored firmware images,
>>>> so I wired it up and matched it for modules, in case anyone wants to
>>>> move the module signature checks out of the module core and into an LSM
>>>> to avoid the current layering violations.
>>>>
>>>> This touches several trees, and I suspect it would be best to go through
>>>> James's LSM tree.
>>>>
>>>> Thanks!
>>>
>>>
>>> I've done some quick tests on this series to make sure that
>>> the efi embedded-firmware support did not regress.
>>> That still works fine, so this series is;
>>>
>>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>>
>> I made a mistake during testing I was not actually running the
>> kernel with the patches added.
>>
>> After fixing that I did find a problem, patch 4/4:
>> "module: Add hook for security_kernel_post_read_file()"
>>
>> Breaks module-loading for me. This is with the 4 patches
>> on top of 5.8.0-rc4, so this might just be because I'm
>> not using the right base.
>>
>> With patch 4/4 reverted things work fine for me.
>>
>> So, please only add my Tested-by to patches 1-3.
> 
> BTW is there any testing covered by the selftests for the firmware
> laoder which would have caputured this? If not can you extend
> it with something to capture this case you ran into?

This was not a firmware-loading issue. For me in my tests,
which were limited to 1 device, patch 4/4, which only touches
the module-loading code, stopped module loading from working.

Since my test device has / on an eMMC and the kernel config
I'm using has mmc-block as a module, things just hung in the
initrd since no modules could be loaded, so I did not debug
this any further. Dropping  patch 4/4 from my local tree
solved this.

Regards,

Hans

