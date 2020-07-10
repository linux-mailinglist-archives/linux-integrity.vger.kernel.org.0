Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8962E21C031
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jul 2020 00:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGJW7J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 18:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGJW7J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 18:59:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1AC08C5DC
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 15:59:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so2835674plm.10
        for <linux-integrity@vger.kernel.org>; Fri, 10 Jul 2020 15:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zaGr1Nu6GQQp1jxSDJ4yzfhjg6UJvh2w5gtwh4d61xs=;
        b=E9qYFGE0+l0YCV9UzR+G2McYBQmSQeFznqZAlltk8CGMkkJZfD2cqjwZprvjTv0RQj
         I4DWrNInpJ8TPQIe7Lu+ifSs3wKZd/lr+U50wrtRKZ7u36Knv6AfL+1+S3qzkkCXXL0Z
         at6s+kS03qv/c4IAS0rytCM6vNJLQUWIP6MNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zaGr1Nu6GQQp1jxSDJ4yzfhjg6UJvh2w5gtwh4d61xs=;
        b=IW4jYab9d8CGN9zQqYosiq17SMFYlDcRvf1esKy5Ru41lHtje6OP/G8+ECxjpU2M7j
         lNufMYz1Lh0qFY2+7EOhdwMR69oFUrFkEa5GVwPG0636qBpf+5pde08v0nV75Yk7sXlA
         /UTPrmuPzMSmvqbvJ6fZkT0c0i2zQEY527AbQOHMfWvTREzHe9zrJWUrOA1/yqtctVKf
         7fLEVVALJT8sUQ13FNpE6cHOZqOqX8eC6j5ETdL7dFE9WHAOnmlcLakztzsxMsxDrHv4
         VScb1G+87QfB1Tqegk3piLu8MQuBkJSfln7PvGspPL58NMWLqJk1H2VBAq9yYrV2ZMnw
         RzsA==
X-Gm-Message-State: AOAM5322oTrXyUqAQ35lsoTPOIsvBRdvmhTXGGLy8TdzfwtXIbV7XAxT
        DBhH6Oqm5LdrSDccS0linbz3jQ==
X-Google-Smtp-Source: ABdhPJxVXjjKeIdD8z8whwzZhkDi/N2YGshqCq7LJeYrNXGgmvDQGyRf1YocX3/vACrswhoSIMiJpA==
X-Received: by 2002:a17:90a:3aaa:: with SMTP id b39mr3160671pjc.73.1594421948367;
        Fri, 10 Jul 2020 15:59:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b14sm6861545pfb.186.2020.07.10.15.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:59:07 -0700 (PDT)
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
 <20200710220411.GR12769@casper.infradead.org>
 <128120ca-7465-e041-7481-4c5d53f639dd@broadcom.com>
 <202007101543.912633AA73@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <989a7560-29bb-a5ea-a03e-e2018c983829@broadcom.com>
Date:   Fri, 10 Jul 2020 15:58:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007101543.912633AA73@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Kees,

On 2020-07-10 3:44 p.m., Kees Cook wrote:
> On Fri, Jul 10, 2020 at 03:10:25PM -0700, Scott Branden wrote:
>>
>> On 2020-07-10 3:04 p.m., Matthew Wilcox wrote:
>>> On Fri, Jul 10, 2020 at 02:00:32PM -0700, Scott Branden wrote:
>>>>> @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
>>>>>     		goto out;
>>>>>     	}
>>>>> -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
>>>>> -		*buf = vmalloc(i_size);
>>>>> +	if (!*buf)
>>>> The assumption that *buf is always NULL when id !=
>>>> READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
>>>> I get unhandled page faults due to this change on boot.
>>> Did it give you a stack backtrace?
>> Yes, but there's no requirement that *buf need to be NULL when calling this
>> function.
>> To fix my particular crash I added the following locally:
>>
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -3989,7 +3989,7 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char
>> __user *, uargs, int, flags)
>>   {
>>       struct load_info info = { };
>>       loff_t size;
>> -    void *hdr;
>> +    void *hdr = NULL;
>>       int err;
>>
>>       err = may_init_module();
> Thanks for the diagnosis and fix! I haven't had time to cycle back
> around to this series yet. Hopefully soon. :)
I don't consider this a complete fix as there may be other callers which 
do not initialize
the *buf param to NULL before calling kernel_read_file.

But, it does boot my system.  Also, I was able to make modifications for my
pread changes that pass (and the IMA works with IMA patch in my series 
is dropped completely with your changes in place).

So your changes work for me other than the hack needed above.
>

