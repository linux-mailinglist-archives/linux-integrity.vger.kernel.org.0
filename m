Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CD4359162
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhDIBYy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 21:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhDIBYw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 21:24:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A75C061761;
        Thu,  8 Apr 2021 18:24:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w10so2659480pgh.5;
        Thu, 08 Apr 2021 18:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=V4nRcD3hjDMC12ZIm/yS1mQ2MbVA8+EsozsRdRPo14E=;
        b=tWfnjXJPya1rmZ+p7F9B9NXxESBP/tTLqT7f3ci3KJSrT3qiHGZQTbTcRlDxdAttZ6
         ZoDm1ITIuz+kNhXVhfjGzL9sIz8sinVu3FUh2unEpj0dc7d7J/iGEX3XMEggY9uE7Tju
         itl2tjN8vjDLkd2iv95zHBNaVFmGxAzyBOb2bWqKKfxRKsNzfcplCfrglgxrdwdt+Q5G
         y0cXCQUJxjlJsLytgK0EgaRJIbYmb3cCERnDOFB3v26QVScmuI12PlHO2xkghm9fVMQ3
         GAmaAWWM4Hqtz+xuaVw6lMCZeyCwahZjxTJEryjZm1parWSFhcik5/UA6da8oaBX62ac
         rSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=V4nRcD3hjDMC12ZIm/yS1mQ2MbVA8+EsozsRdRPo14E=;
        b=Kp7M3T4BGckASgQlCuVajAfwdNNDMQOaM/Cdz/nZMlLbWhuwBWsG4yWkE8iGvSDaVf
         uUtW5iNyXFlm/iDa+n89i57jEm9PZv1GO9Pjp0kiiAkKRdmmjmqcCRfHw+8ClMDtQ/P0
         SuIYvDR9Yxoh+Mb323WlX9XvSiWv9zV41fu61GgfyzHPwe4Tptl1hHUYsbdgGrXj75rx
         yo/1s9TH6Y8qbEkG4oM/MI8dequsajmtht69K26JS5U0YpsbZI1h0NMx7cbCN5eweAy5
         CcG14byeUY0w6GjZHfNKahm0xfMBAxz10N5s1FmZT8IV1jH/3l7tMXhJnJb34mWgbK2t
         6p+Q==
X-Gm-Message-State: AOAM530lb2Jnx+y4Br33TXKUnr01a9lAfQfgr7AK/nUbVp8JgGjn3liZ
        95WQiYXynyx5Gg5RTMPtiNr707N1H54=
X-Google-Smtp-Source: ABdhPJwL2S8E9hhU8fHuAfC+x1JSTWxST9gc2Z6els+66bOCXSS6DVLEDlQWuCZlVJR4ksCtqpd80w==
X-Received: by 2002:a63:5f54:: with SMTP id t81mr10493972pgb.283.1617931479636;
        Thu, 08 Apr 2021 18:24:39 -0700 (PDT)
Received: from [10.43.90.134] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id fs9sm500411pjb.40.2021.04.08.18.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 18:24:39 -0700 (PDT)
Subject: Re: [PATCH v2] integrity: Add declarations to init_once void
 arguments.
To:     zohar@linux.ibm.com
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <20210407014438.39516-1-unclexiaole@gmail.com>
From:   Jiele Zhao <unclexiaole@gmail.com>
Message-ID: <4a41b0e9-a1cd-deaf-8b22-a4ca33968496@gmail.com>
Date:   Fri, 9 Apr 2021 09:24:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210407014438.39516-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

And this is another patch that has been modified.

On 2021/4/7 9:44, Jiele Zhao wrote:
> init_once is a callback to kmem_cache_create. The parameter
> type of this function is void *, so it's better to give a
> explicit cast here.
>
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
> ---
>   security/integrity/iint.c         | 2 +-
>   security/integrity/ima/ima_main.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 0ba01847e836..fca8a9409e4a 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -160,7 +160,7 @@ void integrity_inode_free(struct inode *inode)
>   
>   static void init_once(void *foo)
>   {
> -	struct integrity_iint_cache *iint = foo;
> +	struct integrity_iint_cache *iint = (struct integrity_iint_cache *) foo;
>   
>   	memset(iint, 0, sizeof(*iint));
>   	iint->ima_file_status = INTEGRITY_UNKNOWN;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9ef748ea829f..03bef720ab44 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -482,7 +482,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   }
>   
>   /**
> - * ima_path_check - based on policy, collect/store measurement.
> + * ima_file_check - based on policy, collect/store measurement.
>    * @file: pointer to the file to be measured
>    * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
>    *
