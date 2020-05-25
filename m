Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2231E0E22
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2020 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390470AbgEYMKa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 May 2020 08:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390450AbgEYMK3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 May 2020 08:10:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFB6C061A0E
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 05:10:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y5so2558041wmj.4
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2020 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hl6rYKWqUm/7GRxqy3lWiUdASrTU+laQ3IaMy3yViVU=;
        b=O94WIHSdPf5AmAtZ9dSscMQStIjb5iIJUHRucZqQMwLpEMpv9H/2ZX5Yy0BoU9JQ8m
         jK66pVRMLedoePLd8XY98+xo3nO1/uep5jfPUhMsqUIFJzT8e7YgIthzc8iJKrPte5lc
         ggvcoawUdavMXWqNFUumCs0h9fHzxbsyoQ9AHygorbPy0VjYR3ss2xntFcKBLYdq9uU3
         CfA9yT5FtzjRaob8Tjd40SwlsjGI0Emz1Fd/Hhp6dAc9rGvWTE9FHODNq14RKpuDXiTs
         lWTtNJsJQeIkalzwJiIv2jJ3VDEz6YoNkWZ3nMWKG24YHOCJ7K4nEgzwcgQu7JCVZM3c
         yg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hl6rYKWqUm/7GRxqy3lWiUdASrTU+laQ3IaMy3yViVU=;
        b=CYynhSIgjlH/PaDvw1Gk7dee3b4OSBmEa5BjXc33ogoyOGpmm3OdX1gF9Hd54n7Awo
         iZfTsL7wPPch6zGuF3acs++3ft8PcoORQ+olUctXrUlf4zuKEbUeGOo0DaGO2Wyk8hyx
         Cy/pvHwvK1BhNbqCyjsU4fpBEJmkWfeoEeZvLC/nrZjnGrW6Kfhnotrr3gN2S0O5e7b4
         dVYmzCiqikVusM5Aw5UgiZN06k1PDr6nSGnbItOwJBb2s62lkm0FLIdT6StxOslEiA0g
         jWx9W5uMl9t7FhQ5wGlh78eWhHwBlTsFSAD3jiblNyk8cuPpAhJWoy3s+oMKPwwUjRqy
         CJ4w==
X-Gm-Message-State: AOAM5330f0m8wzlnaFKmuNYO6mx/lmneY5jIRPlh53xi1MO8A5CRug5Y
        TCHdh0m6Pkh3S5t1EWzCdv+8mg==
X-Google-Smtp-Source: ABdhPJzYVQBgZJg06rhrOBIA8uy79S/hgyrFcLeou5/MTwusJ/Wd2NaF1gQiRO7UWy5KyU52Y6G9xg==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr23981266wmi.132.1590408627896;
        Mon, 25 May 2020 05:10:27 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:269:e210:80:e64c:847d:b568? ([2a01:e0a:269:e210:80:e64c:847d:b568])
        by smtp.gmail.com with ESMTPSA id z6sm3166325wrh.79.2020.05.25.05.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 05:10:26 -0700 (PDT)
Subject: Re: [Tee-dev] [PATCHv3 2/3] optee: use uuid for sysfs driver entry
To:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgg@ziepe.ca, arnd@linaro.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
 <20200525115235.5405-3-maxim.uvarov@linaro.org>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <7de3fea9-cd88-4dbf-aa27-3cb188fd6e85@forissier.org>
Date:   Mon, 25 May 2020 14:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525115235.5405-3-maxim.uvarov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/25/20 1:52 PM, Maxim Uvarov wrote:
> Optee device names for sysfs needed to be unique

s/Optee/OP-TEE/
s/needed/need/

> and it's better if they will mean something. UUID for name
> looks like good solution:
> /sys/bus/tee/devices/optee-clnt-<uuid>

How about mentioning it is the UUID of the Trusted Application on the
TEE side?

> 
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  drivers/tee/optee/device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks,
-- 
Jerome
