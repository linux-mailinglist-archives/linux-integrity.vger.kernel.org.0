Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9D3B7DFE
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhF3H1G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbhF3H1F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 03:27:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C0C061766;
        Wed, 30 Jun 2021 00:24:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g4so1203772pjk.0;
        Wed, 30 Jun 2021 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zr28EiN6VTW0jAQmgor6rRPBvukZW16zav6uSZ93P58=;
        b=sEgaC4BLwiy3yFg8V7Dr/bWalMnVwBo7USwEiT8Gijwpggx3qwwlcPd8kMw8oyItuP
         XpRr9R6h9jzg82/eF9Qi9i15Wpo8++Wdv4d4ctpVQOkq/JgW+M+yUv1u2aiwaerW5XOa
         znqqETtPTFQGMsRWZOrvgSzsD3u/wgjat66ra6GaK/02P4HRrwZQQ8jCL38LBbDFdrXd
         4oOYejiNrJOdk5eAV5osPa9WdRL57bIrrTKaWth6f2vabex0A9Z7uYwwufhUJkud5EoS
         X6A/VUWPg+GbDvSpAsAYnIe5MW906XcYroqkgwK2GDyvf/N9ab0KS3cB4hWp/E1R5Lyy
         XqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zr28EiN6VTW0jAQmgor6rRPBvukZW16zav6uSZ93P58=;
        b=YkYhygIzKespZU8YYfplG3G3p+SKMXnWhEmWFwwWdrIpy4GnBcXKAQ0NssXHNvxxCz
         IduMtrTLwdny7l774Ey8ImZ9QZ74F9tXBlLG4iUotvcvIRXF4rlmmW9ynUhE5FjfEYOO
         ycntqK8iS0NM36Y/F6FG0wIQfb+tlGrbtCJoMjCn8ebgqJ5LTFtTsgpC2RSy3DFXSAoJ
         xqot7eDT9yYYFe30wSqzvuykR6coh6NtzpNdmuExMPuZqektTNqJMbWFHc58nv8Mroa7
         W/7LfniZzEnnP98Hpt+v0YP3q73+cdAw0ztOKKMASlLXCWRlaTZTceq+n1TfS9GLf+zj
         d7sw==
X-Gm-Message-State: AOAM533F0Aijy69+wjsxU49H8rWMjduZSkuHlcBnct28LtfcRBM/swHT
        DOK1VqI8eXkyRbPK9QwB8Lo=
X-Google-Smtp-Source: ABdhPJytYzBb9+z1b9aEN4qsdHsyEkthrIv5PCGbcvop4yE5z+/opRU4aIS9xcKvN7RiWK8y2vrypw==
X-Received: by 2002:a17:902:eccb:b029:127:9520:ac96 with SMTP id a11-20020a170902eccbb02901279520ac96mr30710868plh.70.1625037875840;
        Wed, 30 Jun 2021 00:24:35 -0700 (PDT)
Received: from [192.168.0.118] ([103.242.196.99])
        by smtp.gmail.com with ESMTPSA id s123sm20152132pfb.78.2021.06.30.00.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 00:24:35 -0700 (PDT)
Subject: Re: [PATCH] char: tpm: vtpm_proxy: Fix race in init
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        andrianov@ispras.ru
References: <20210623132226.140341-1-saubhik.mukherjee@gmail.com>
 <20210629172700.yxqnedbayumo5f24@kernel.org>
 <20210629210524.hze6yb23pps3flnv@kernel.org>
From:   Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
Message-ID: <2b7d8d44-791e-284a-a700-5465fbc2c100@gmail.com>
Date:   Wed, 30 Jun 2021 12:54:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629210524.hze6yb23pps3flnv@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/30/21 2:35 AM, Jarkko Sakkinen wrote:
> On Tue, Jun 29, 2021 at 08:27:00PM +0300, Jarkko Sakkinen wrote:
>> On Wed, Jun 23, 2021 at 06:52:26PM +0530, Saubhik Mukherjee wrote:
>>> vtpm_module_init calls vtpmx_init which calls misc_register. The file
>>> operations callbacks are registered. So, vtpmx_fops_ioctl can execute in
>>> parallel with rest of vtpm_module_init. vtpmx_fops_ioctl calls
>>> vtpmx_ioc_new_dev, which calls vtpm_proxy_create_device, which calls
>>> vtpm_proxy_work_start, which could read uninitialized workqueue.
>>>
>>> To avoid this, create workqueue before vtpmx init.
>>>
>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>
>>> Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>
>>> ---
>>>   drivers/char/tpm/tpm_vtpm_proxy.c | 19 +++++++++----------
>>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>>> index 91c772e38bb5..225dfa026a8f 100644
>>> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
>>> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>>> @@ -697,23 +697,22 @@ static int __init vtpm_module_init(void)
>>>   {
>>>   	int rc;
>>>   
>>> -	rc = vtpmx_init();
>>> -	if (rc) {
>>> -		pr_err("couldn't create vtpmx device\n");
>>> -		return rc;
>>> -	}
>>> -
>>>   	workqueue = create_workqueue("tpm-vtpm");
>>>   	if (!workqueue) {
>>>   		pr_err("couldn't create workqueue\n");
>>> -		rc = -ENOMEM;
>>> -		goto err_vtpmx_cleanup;
>>> +		return -ENOMEM;
>>> +	}
>>> +
>>> +	rc = vtpmx_init();
>>> +	if (rc) {
>>> +		pr_err("couldn't create vtpmx device\n");
>>> +		goto err_destroy_workqueue;
>>>   	}
>>>   
>>>   	return 0;
>>>   
>>> -err_vtpmx_cleanup:
>>> -	vtpmx_cleanup();
>>> +err_destroy_workqueue:
>>> +	destroy_workqueue(workqueue);
>>>   
>>>   	return rc;
>>>   }
>>> -- 
>>> 2.30.2
>>>
>>>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Taking reviewed-by back.
> 
> You're lacking fixes tag. Please re-send with one.
> 
> /Jarkko
> 

Thank you for noticing. I sent the patch containing the Fixes tag in 
reply to your last message. (https://lkml.org/lkml/2021/6/30/104)
