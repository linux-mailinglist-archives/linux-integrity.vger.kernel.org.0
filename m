Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15D71F920
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jun 2023 06:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjFBELC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jun 2023 00:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFBELB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jun 2023 00:11:01 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC4128;
        Thu,  1 Jun 2023 21:10:59 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-558565cc59bso1174074eaf.0;
        Thu, 01 Jun 2023 21:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685679059; x=1688271059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3vGr4MbPaoToAJSxQ1XgzEMr0Rv0l9r0UfL6JK0LX0=;
        b=O3izkDexVYpVytp697sLFBUaDAL3TQBgau0ZtAB2z38rzZvTd2IFvN6d0JK+GqBuey
         sC6j/Q/VCdxBz3Fq2/y8bpotHg0NxjTuCAEg8UJFJYFWfBuc5AmGwS534Rz4R48FunTq
         Ysg1q3SGJUilWu2N4VrDEoFLh7QT7ZU5o5KlP+8c+269LwKuvIuH1YskoATT3QCXPjok
         J2iOiZ19xqPONlSS0f05/2o2c7OWk5tdpMEYdmbGk+z60ZXYHNC5R5tgvpq+sqtXGqnR
         p4fBtVbg0Feaihk7Yf9aSXE2Q7x3Ko//Ir3VSCb1dKBLgx9w+CN46tUR5UB1KnO2iO5d
         2ILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685679059; x=1688271059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3vGr4MbPaoToAJSxQ1XgzEMr0Rv0l9r0UfL6JK0LX0=;
        b=gijtxuKIPXKqyGRZYta5Np+RG9bgsBhMlqSm+Nhg7Ie0BDsUThRtSPbmsZ6lXFcr1W
         QbLwCwjKQJg2dZqSCoxjNyVAQVm1nWJUg/C0PMFuXNJoAm2MZ7Daw0DbOh2LnHOY+5Kg
         OK0YqiRF8M5xrdxIjv1JDNBvYhfiAGlhZDhsGbikkbx+4RT0WE8visEmc89YfbvMiHp3
         ldzLr6FcCr8JPC49XfF0Q/6ghl8hQWYTbHNHqE4e68bllWWlUgNi6RM+dOLYMDzKJncb
         ud1YxtJPw+TJ+Irprq6Nk7g9Mf2I/OCewziGlYrhjthooSF6/1MxE1opdOCUaIYKAnWL
         RvYw==
X-Gm-Message-State: AC+VfDz3uiRDJa9OEdnD0RhqwsnaPXU3lCds/pYRhcc4ENhJLaQ/TY2N
        Y0dxm//qu04jj4Aoskj3ConJVD7zrkuJ5w==
X-Google-Smtp-Source: ACHHUZ7mLqQADDAStnoyYcPCXJCgP9RkieHihEgYSRjgKP1T2VHn9UZXYlPhaJPWE6mLiAWcff0yjg==
X-Received: by 2002:a05:6358:3106:b0:125:68c4:572f with SMTP id c6-20020a056358310600b0012568c4572fmr9964351rwe.6.1685679058953;
        Thu, 01 Jun 2023 21:10:58 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id fa2-20020a17090af0c200b00256353eb8f2sm2205846pjb.5.2023.06.01.21.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 21:10:58 -0700 (PDT)
Message-ID: <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
Date:   Fri, 2 Jun 2023 11:10:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/29/23 09:37, Chris Packham wrote:
> 
> On 29/05/23 14:04, Bagas Sanjaya wrote:
>> On Sun, May 28, 2023 at 11:42:50PM +0000, Chris Packham wrote:
>>> Hi,
>>>
>>> We have an embedded product with an Infineon SLM9670 TPM. After updating
>>> to a newer LTS kernel version we started seeing the following warning at
>>> boot.
>>>
>>> [    4.741025] ------------[ cut here ]------------
>>> [    4.749894] irq 38 handler tis_int_handler+0x0/0x154 enabled interrupts
>>> [    4.756555] WARNING: CPU: 0 PID: 0 at kernel/irq/handle.c:159
>>> __handle_irq_event_percpu+0xf4/0x180
>>> [    4.765557] Modules linked in:
>>> [    4.768626] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.113 #1
>>> [    4.774747] Hardware name: Allied Telesis x250-18XS (DT)
>>> [    4.780080] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
>>> BTYPE=--)
>>> [    4.787072] pc : __handle_irq_event_percpu+0xf4/0x180
>>> [    4.792146] lr : __handle_irq_event_percpu+0xf4/0x180
>>> [    4.797220] sp : ffff800008003e40
>>> [    4.800547] x29: ffff800008003e40 x28: ffff8000093951c0 x27:
>>> ffff80000902a9b8
>>> [    4.807716] x26: ffff800008fe8d28 x25: ffff8000094a62bd x24:
>>> ffff000001b92400
>>> [    4.814885] x23: 0000000000000026 x22: ffff800008003ec4 x21:
>>> 0000000000000000
>>> [    4.822053] x20: 0000000000000001 x19: ffff000002381200 x18:
>>> ffffffffffffffff
>>> [    4.829222] x17: ffff800076962000 x16: ffff800008000000 x15:
>>> ffff800088003b57
>>> [    4.836390] x14: 0000000000000000 x13: ffff8000093a5078 x12:
>>> 000000000000035d
>>> [    4.843558] x11: 000000000000011f x10: ffff8000093a5078 x9 :
>>> ffff8000093a5078
>>> [    4.850727] x8 : 00000000ffffefff x7 : ffff8000093fd078 x6 :
>>> ffff8000093fd078
>>> [    4.857895] x5 : 000000000000bff4 x4 : 0000000000000000 x3 :
>>> 0000000000000000
>>> [    4.865062] x2 : 0000000000000000 x1 : 0000000000000000 x0 :
>>> ffff8000093951c0
>>> [    4.872230] Call trace:
>>> [    4.874686]  __handle_irq_event_percpu+0xf4/0x180
>>> [    4.879411]  handle_irq_event+0x64/0xec
>>> [    4.883264]  handle_level_irq+0xc0/0x1b0
>>> [    4.887202]  generic_handle_irq+0x30/0x50
>>> [    4.891229]  mvebu_gpio_irq_handler+0x11c/0x2a0
>>> [    4.895780]  handle_domain_irq+0x60/0x90
>>> [    4.899720]  gic_handle_irq+0x4c/0xd0
>>> [    4.903398]  call_on_irq_stack+0x20/0x4c
>>> [    4.907338]  do_interrupt_handler+0x54/0x60
>>> [    4.911538]  el1_interrupt+0x30/0x80
>>> [    4.915130]  el1h_64_irq_handler+0x18/0x24
>>> [    4.919244]  el1h_64_irq+0x78/0x7c
>>> [    4.922659]  arch_cpu_idle+0x18/0x2c
>>> [    4.926249]  do_idle+0xc4/0x150
>>> [    4.929404]  cpu_startup_entry+0x28/0x60
>>> [    4.933343]  rest_init+0xe4/0xf4
>>> [    4.936584]  arch_call_rest_init+0x10/0x1c
>>> [    4.940699]  start_kernel+0x600/0x640
>>> [    4.944375]  __primary_switched+0xbc/0xc4
>>> [    4.948402] ---[ end trace 940193047b35b311 ]---
>>>
>>> Initially I dismissed this as a warning that would probably be cleaned
>>> up when we did more work on the TPM support for our product but we also
>>> seem to be getting some new i2c issues and possibly a kernel stack
>>> corruption that we've conflated with this TPM warning.
>> Can you reproduce this issue on mainline? Can you also bisect to find
>> the culprit?
> 
> No the error doesn't appear on a recent mainline kernel. I do still get
> 
> tpm_tis_spi spi1.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead
> tpm tpm0: A TPM error (256) occurred attempting the self test
> 
> but I think I was getting that on v5.15.110
> 
>>

I repeat: Can you bisect between v5.15 and v5.15.112?

-- 
An old man doll... just what I always wanted! - Clara

