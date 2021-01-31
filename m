Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3A309A1A
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 04:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhAaDhW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 22:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhAaDhV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 22:37:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D3C061574;
        Sat, 30 Jan 2021 19:36:41 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id j25so14876097oii.0;
        Sat, 30 Jan 2021 19:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F27/alWbAdY5pzgWHW1aHA9zMjtd0JKL5T3JVsGe7ps=;
        b=HiqfjpkyA5cKm7HbwZmjvIfr2AwX/dvT/0wUFcgD282PnJPCXVEwY5HehNBJLYqa0f
         9kkRZVmBpNpKYbEpdM4nbf86Ms0DzGzwak/qgd0b8Uu8XdJJVLHdSgbbeVypiTy3oLm1
         8tvWkMU97dSMsc8GjOw9Fco+bJT56Tj4crs+ICQh0yOh0lOGiBIicCxg53oFokBVqE2T
         PjUNm4nilaym+JYjSjvhzcQNff2+9C6Z0DSDTIVrQDj/IbEEybYjiTXCpgHVSwePAuFG
         oowKKOH1LmuKV1X0NZuoX66nOtDqX77EsvYrQEwXM4fcMyJ/0XFQ6Y2XiMMPhnw9db+S
         TqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F27/alWbAdY5pzgWHW1aHA9zMjtd0JKL5T3JVsGe7ps=;
        b=hChHHLtYZEuHn9HlaChe+vWT4ZWXDkiqbUTbWbg/rTklAi3f2pRu7ggOwRJWFOCXkn
         1nr4fj2wbeWkuy+ALaJ1fhkdSYifNPZOYJMSGvkRNOIuoNihwdqbLtSXTieSNadAGyVf
         KVHf6mnpQXJOVJo7b+OGm0+ONNX5Ze3g821Ce7rZMzFUxfwcP4bcOZhieuv3cGlO5zPE
         joVoW2dJdUMZVIziWWiSY8kcvk9uLIYBDRj8CgudeFvcLqRuBAqNBJgsgDQMThG9d1Zx
         4dYIgMJhwCnvq1M5rniITydkQWW8qn+++QJ21FLJc49K+hfRfsohomjTnWtaNzW5aN6C
         2kxA==
X-Gm-Message-State: AOAM5316Ojw76DvVJtchqz8wYKFXb2sCj+BPcrZpV/fccJaB4mGzMNp1
        tN/Y8RGMyVosmjmqcJ5q4Zs=
X-Google-Smtp-Source: ABdhPJym97OZyBWlCCL/SszyzkXjt3f+86SFy7fchsLeziLRvhnFB7/y/NPNwvz3CVvOWeCUCmu9ww==
X-Received: by 2002:aca:d883:: with SMTP id p125mr7090228oig.114.1612064200745;
        Sat, 30 Jan 2021 19:36:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g13sm3108230otr.74.2021.01.30.19.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 19:36:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?=c5=81ukasz_Majczak?= <lma@semihalf.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
 <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
 <YBSTOrlgTPpzoblY@kernel.org>
 <7a702108-ec9e-b2e2-be89-3590437c0eb5@roeck-us.net>
 <bf4564a2f4f761a4c0a00857c7dc346fc43bcd92.camel@HansenPartnership.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <57e79e19-fe5c-7d41-ff30-40afbaa7a96d@roeck-us.net>
Date:   Sat, 30 Jan 2021 19:36:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bf4564a2f4f761a4c0a00857c7dc346fc43bcd92.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/30/21 4:41 PM, James Bottomley wrote:
> On Sat, 2021-01-30 at 15:49 -0800, Guenter Roeck wrote:
>> On 1/29/21 2:59 PM, Jarkko Sakkinen wrote:
>>> On Tue, Jan 26, 2021 at 04:46:07PM +0100, Łukasz Majczak wrote:
>>>> Hi Jarkko, Guenter
>>>>
>>>> Yes, here are the logs when failure occurs -
>>>> https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
>>>> Look for a phrase "TPM returned invalid status"
>>>>
>>>> Guenter - good suggestion - I will try to keep it as tight as
>>>> possible.
>>>>
>>>> Best regards,
>>>> Lukasz
>>>
>>> Is it possible for you try out with linux-next? Thanks. It's a
>>> known issue, which ought to be fixed by now.
>>>
>>> The log message is harmless, it'a warning not panic, and does not
>>> endanger system stability. WARN()'s always dump stack trace. No
>>> oops is happening.
>>>
>>
>> There is a note in the kernel documentation which states:
>>
>> Note that the WARN()-family should only be used for "expected to
>> be unreachable" situations. If you want to warn about "reachable
>> but undesirable" situations, please use the pr_warn()-family of
>> functions.
> 
> It fits the definition.  The warning only triggers if the access is in
> the wrong locality, which should be impossible, so the warning should
> be unreachable.
> 
Thanks a lot for the clarification. So a warning traceback in the kernel
doesn't necessarily suggest that there is a serious problem that should
be fixed; it only means that some code is executed which should not be
reachable (but is otherwise harmless).

That makes me wonder, though, if it would make sense to mark such harmless
tracebacks differently. The terms "warning" and "harmless" sound like
a bit of a contradiction to me (especially for systems where panic_on_warn
is set).

Thanks,
Guenter
