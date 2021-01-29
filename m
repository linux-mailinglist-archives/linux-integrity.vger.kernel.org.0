Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2983090A8
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 00:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhA2XdY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 18:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhA2XdW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 18:33:22 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4913EC061573;
        Fri, 29 Jan 2021 15:32:42 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n42so10267415ota.12;
        Fri, 29 Jan 2021 15:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zzcM2qUSkaqmQatz4yzSydth0oX/gZ+zfajHOGWvhjk=;
        b=ofBpm/Q2w3Om2A539T564qNWYq7LP7QQQRmO/LHEPWQEw5eoqeRgo2PLbzFpzj3fHE
         dbo4EGLLr5R+PbBMHgzU6CQ6J2ZPROfhzmRc/RCFy5EK8cxrUEJAdnovCmjgslML2Ogq
         EstiXSKTRkYebco2IsYwT2Rw9h5HWK4HhpCqvqiGQPVNl+4rFD0KlZ6sEFoNn+mc9l0G
         WoPxfD8B1ZflOqmGpTyH5C2SmAQwowW46fcI0c8K0nR5D4zmJX7cO70HcSLNEf/usPKT
         kvv2UM4AYQcMtS1N/WDHB8bEO7cDn5SXywbb8DFlfbfSWh7EoxR0CAm8d7KHxS7MPnR9
         Fu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zzcM2qUSkaqmQatz4yzSydth0oX/gZ+zfajHOGWvhjk=;
        b=qJRmBJHPjkRhSWCXQgKJiIcHawPvIJ1u864iNsc9tpaBYsui0WPgTNdqrowJ4EHj0L
         z40lY57NHm8cqwuMuzGRdJiaNmwo01m20FkY4ST3IjO1gpIbwUtaWhqR7dYWTtcdWV6h
         6GRZDM1nNDal7jIsOrWTmabSangv7tl78KOY+eVPzy3YHFXswSY/yYB1oFjaPMrFiken
         +1xqf8Fc0xKu74fuOHrFycXEfcTz+aj+4FYQcq9DTx7+gQXB2cHRAYOk4/RNeZFTkuzA
         /jQT9jO8YFaMj8R4anjubdAUqfKdeOVLNZJbwWIKOsY18CpPeuizUWp4+DTfW6uc/5+0
         /y6Q==
X-Gm-Message-State: AOAM532tM+o1a3hZEubum7ZRoj5NCFTu8dEQkSC1PgH3apVoQ9mU7eeD
        l0XJ4WS5/qmJbEnuHmW25qo=
X-Google-Smtp-Source: ABdhPJy2LbFvqtCihbSaaXYS2d3PdR/BnlrjtAB9ex/N5PSeTtK1QhRUvFp223QgYqIeNjMRQFMFRw==
X-Received: by 2002:a05:6830:2414:: with SMTP id j20mr4374824ots.326.1611963161688;
        Fri, 29 Jan 2021 15:32:41 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10sm2705326ooy.11.2021.01.29.15.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 15:32:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Lukasz Majczak <lma@semihalf.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net> <YBSRFsTNjadQMndD@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b287e2b7-08de-6fc8-4003-4609b1ba9378@roeck-us.net>
Date:   Fri, 29 Jan 2021 15:32:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBSRFsTNjadQMndD@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/29/21 2:49 PM, Jarkko Sakkinen wrote:
> On Mon, Jan 25, 2021 at 09:18:46AM -0800, Guenter Roeck wrote:
>> Hi Lukasz,
>>
>> On Sat, Jan 23, 2021 at 02:42:47AM +0100, Lukasz Majczak wrote:
>>> There is a missing call to start_tpm_chip before the call to
>>> the tpm_get_timeouts() and tpm_tis_probe_irq_single(). As the current
>>> approach maight work for tpm2, it fails for tpm1.x - in that case
>>> call to tpm_get_timeouts() or tpm_tis_probe_irq_single() tries to
>>> transmit TPM commands on a disabled chip what what doesn't succeed
>>
>> s/what what/what/
> 
> s/maight/might/
> 
> Also, would be nice to have the capatalization of acronyms correct
> and consistent. E.g. tpm1.x should be rather written as "TPM 1.x
> chips".
> 
> It's also incorrect to state that something fails for TPM 1.x chips,
> unless you can somehow make a sense that every single TPM 1.x at wild
> fails, which probably is not true.
> 
>>> and in turn causes tpm_tis_core_init() to fail.
>>> Tested on Samsung Chromebook Pro (Caroline).
> 
> Anyone can tell me what does Caroline mean anyway?
> 

"Caroline" is the code name for Samsung Chromebook Pro. The term
"Samsung Chromebook Pro (Caroline)" is quite widely used for this
system. Or, alternatively, "Caroline (Samsung Chromebook Pro)".

Guenter
