Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82C335AA7A
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Apr 2021 05:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhDJDTt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJDTs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 23:19:48 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14CC061762;
        Fri,  9 Apr 2021 20:19:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m18so1439245plc.13;
        Fri, 09 Apr 2021 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FuDb4XqUMe9TU7/4yVIm0WIy1Jl3xWNbvk7QdIOf26Q=;
        b=k/ie8mfKXozaPOxCOdJJQ2mBuu/6dyJYHXrhscpGC0VIIna+olep/MXSJXii+SZDP+
         Rn314TLsda3nSrP8YrGr+LvtNHv4WHIt5OtR547J6IBtBECC2MazDiY3KGzsEuX7yvk1
         jKUN2ynCrlitLfF/4vUl8MaisEhglwFamz9CVwGRlFJRzY0BFpo4fXFKOHDbkl/FSZEE
         ynsFejZTR0kfgDuT4QPsDeql84d4ZEl3QbvBSWpqlhfNqJQGWS4DglvJyd0MMLBct9hg
         y5dMOvBnwQVxpqxeb2RehXQDfUtSCfYOrCxGQ+SP1vFmXjPm0mOvoqiMka700bmMp7RV
         SkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FuDb4XqUMe9TU7/4yVIm0WIy1Jl3xWNbvk7QdIOf26Q=;
        b=Ll1GZelE8pqc5T/xiwk1s4WFBwhUll9VFqDRoeB+C5r3C1qRDXxeSjoCOhOSLk9HQo
         lml2Ru6rK9dADTUmKddWJuKbGH3iN1n51TG7TNuPsIG5ifR4F+YQsLK4NvzGUs4aN5sq
         /+B7IBSU4BylRqaLrh59KXDqyU/v29RwGqVrCjUYUZGn3wbWnU9xqUckWjn0KdsrLU7l
         DDnuNSrfu2mWnlc1zeAjp9GPsBsa3sfJeYp130m2vz1Xq5cPtva86e3HCz55MshvpHm4
         58Eyl5YzeTJutWA1vXBCyUBZhvFsMUI0VmYCtvT5vE33RZ3MD7l2LONif0SK4RFJMaOC
         cHkw==
X-Gm-Message-State: AOAM533sM7yxpzB24jY9SjDFXQtKPxb2ssxclS/BcNjzfvTP19ZTgPjY
        unE953/YpOc+8Gp5Ape2d/xVxK5HtW33/g==
X-Google-Smtp-Source: ABdhPJwFAl99Oh5SmbbDo6TIxx9vPTPUoYlUfxcVE7x2YoPSJuIF+aCDO31zbZ/8E2WrbCuLiqLJZQ==
X-Received: by 2002:a17:90b:b09:: with SMTP id bf9mr16459246pjb.17.1618024774291;
        Fri, 09 Apr 2021 20:19:34 -0700 (PDT)
Received: from [10.43.90.134] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id s2sm3951482pjs.49.2021.04.09.20.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 20:19:33 -0700 (PDT)
Subject: Re: [PATCH v2] integrity: Add declarations to init_once void
 arguments.
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20210407014438.39516-1-unclexiaole@gmail.com>
 <cb640adf4fe93e054d7a8c148fea601048bfd562.camel@linux.ibm.com>
From:   Jiele Zhao <unclexiaole@gmail.com>
Message-ID: <48cf65b2-8dd8-4ceb-15a8-9aedecbcca75@gmail.com>
Date:   Sat, 10 Apr 2021 11:19:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <cb640adf4fe93e054d7a8c148fea601048bfd562.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Okay, thank you. I'll keep an eye on that !

On 2021/4/10 2:55, Mimi Zohar wrote:
> Hi Jiele,
>
> On Wed, 2021-04-07 at 01:44 +0000, Jiele Zhao wrote:
>> init_once is a callback to kmem_cache_create. The parameter
>> type of this function is void *, so it's better to give a
>> explicit cast here.
>>
>> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
>> ---
>>   security/integrity/iint.c         | 2 +-
>>   security/integrity/ima/ima_main.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>> index 0ba01847e836..fca8a9409e4a 100644
>> --- a/security/integrity/iint.c
>> +++ b/security/integrity/iint.c
>> @@ -160,7 +160,7 @@ void integrity_inode_free(struct inode *inode)
>>   
>>   static void init_once(void *foo)
>>   {
>> -	struct integrity_iint_cache *iint = foo;
>> +	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
>>   
>>   	memset(iint, 0, sizeof(*iint));
>>   	iint->ima_file_status = INTEGRITY_UNKNOWN;
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 9ef748ea829f..03bef720ab44 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -482,7 +482,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>>   }
>>   
>>   /**
>> - * ima_path_check - based on policy, collect/store measurement.
>> + * ima_file_check - based on policy, collect/store measurement.
>>    * @file: pointer to the file to be measured
>>    * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
>>    *
> This change was already posted as "ima: Fix function name error in
> comment".  I've dropped this hunk.  In the future, please review your
> patch line by line before posting.
>
> Applied to
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> next-integrity
>
> thanks,
>
> Mimi
>
