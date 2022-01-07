Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2244870C7
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 03:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345596AbiAGCvo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jan 2022 21:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbiAGCvn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jan 2022 21:51:43 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153E0C061212
        for <linux-integrity@vger.kernel.org>; Thu,  6 Jan 2022 18:51:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p37so4046500pfh.4
        for <linux-integrity@vger.kernel.org>; Thu, 06 Jan 2022 18:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=cPcCRIX7tHQEplt2lUi0Y51MSkEipcGHYjn3QIumPhE=;
        b=pYXFsiWa4vQwjvrPQMRGCmNY/uilPyoBovOsGE74CDPK8VencstsmrK9Ikq/hlHprk
         ZRCOVUesXqs7pI2Ht4SqeXLlG78LxDWWwn7p4ERUt4VqqRXJIKzOn8gCt6NQh95gSgRk
         sICeSxQnrL6TjJjnO9jwzj4O3soyvsncLKUtlEXx2X0tR4d/nMo65zGCTrjIbw7kVBOk
         B2wUP0602ZyvfRYfN/4Ar+qKBPWxXSCF15e+4rQoIQfBnuWegguB92jNwsP+7F1thzw0
         D6BYaXVqioXRqTI93T22IOSyHA7Pvnjm+kHRcpZN7ksIFC7tHov8B1orjD8MEqofqYx9
         yvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=cPcCRIX7tHQEplt2lUi0Y51MSkEipcGHYjn3QIumPhE=;
        b=qWT1II12pdgA08l4AcVT0II2e1d9rjTIIoXEuaRmKfSBkIiZJ0wN2s2mzh+y2H4X2j
         xjoGpx5+z981pKS4rEETL2UuD4uqnqKFae+6WG2mcqi5C74MxH8UXBLVyKmEULllGrco
         ALN7pg5+0+ARghEgEQDj/y0nvNBU3TpXZsMm/2bY1zUu4qpbpGfeCfqQP1WYEXCWhFnQ
         hzU5umWZ49nCx6NKeVcj1jX6mJxfZC7LXaUZ90MUB7dUdw3rnelkKUQJ0J6nwh0BdBQ3
         V4e9YfPHo/qM6iYRYjtTHZv/097nw0qPHLrV0daFz6xO8CX+ihBdyOBjumtoxqfNVZ4s
         q2+w==
X-Gm-Message-State: AOAM531yl3A+LyQKPie1briNVHzZpUBdfgZ8dRaWDL+JJHuAZxPGfbMs
        ohhSMdnIqfL/qAhJDrzo5o2eYA==
X-Google-Smtp-Source: ABdhPJwMczFSW3d5J7keE+dDS5YoHi7AndSjmC3HuQ+yyclWI3jvtms8Lllan7azHUEjaeV+MqHlpw==
X-Received: by 2002:a63:d2:: with SMTP id 201mr55368315pga.56.1641523902522;
        Thu, 06 Jan 2022 18:51:42 -0800 (PST)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id l191sm3012998pgd.8.2022.01.06.18.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 18:51:42 -0800 (PST)
Message-ID: <5d6ebe64-df5b-9cc5-be08-a550dec296f8@linaro.org>
Date:   Thu, 6 Jan 2022 18:51:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Tadeusz Struk <tstruk@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211229050655.2030-1-tstruk@gmail.com>
 <883e4ac1a10dc192824dff3eb6489d027417d1d4.camel@kernel.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH v2 1/2] tpm: Fix error handling in async work
In-Reply-To: <883e4ac1a10dc192824dff3eb6489d027417d1d4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/5/22 12:05, Jarkko Sakkinen wrote:
>> until the user_read_timer wakes it up after 120 sec.
>> Make sure that error conditions also contribute to the poll mask
>> so that a correct error code could passed back to the caller.
> I'm not sure what "making sure" means.



> 
>>          tpm_put_ops(priv->chip);
>> -       if (ret > 0) {
>> +       if (ret != 0) {
> What if ret < 0?
> 
> You should explain this change in the commit message. Also, consider
> adding an inline comment.

As the commit message says tpm_dev_transmit() returns -EINVAL when
the given handle doesn't exist, and the tmprm can not find it.
This is not handled properly and the application gets stuck.
I will add a comment here send a new version.

-- 
Thanks,
Tadeusz
