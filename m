Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440ED34F637
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 03:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCaB0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 21:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbhCaB0l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 21:26:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8AC061574;
        Tue, 30 Mar 2021 18:26:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bt4so8661835pjb.5;
        Tue, 30 Mar 2021 18:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=NSV/+CS6YGslJ2oJsKJuX7elEnvGpPwMdP7U2Hnwjgc=;
        b=Ppbva4FacNJfFIZP/pCIzmKMJsjTdYTa/5hj1kH+snSyJ0IQ4T5AuMNffvrhAfVN/+
         lP9WsVd26h211YrDvZoOuzzjPQUR4LW6rec9pCaBt96S5JSEo076legQgtLwuUCerE0I
         15Sn1YnxB4f4J6Hu8MVhZAnrO+yW+KFBm37ZnCCvBz1HVwswNMJq3OEjdiGst2J3o/QE
         JNf2kN1ptV8ZZ/OWBkW7tdGhpQhhxYb2Xg2a4jVshfxgtvpGYFXOC6qYG65wuSWxwtTl
         Zcu0XtkR7Kpx4d6vh2lLpEZkWw7Ac+KEDiq6KinbHyBb8cXZKAssz7maksmr/6GZWmyi
         rhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=NSV/+CS6YGslJ2oJsKJuX7elEnvGpPwMdP7U2Hnwjgc=;
        b=eETdqfUihjYg8vr7a/Oj1vnCTjzr1s5Px3v3gZaqK5OIEOVkgLaVlYW5lbRGa7Fndf
         nr64b2WzeX8Yxn95pAMyS4aq5zVgXzRQoKEly/IVquAyeDpnKv7Oyjs8IQqhwyoIg7XT
         WzrVmBjGM9CpyhUNMC2CHB8MgDuAaK92Wcsm2J5iSlXoXxNbwZPJmLBGzx1VG8/bWkc2
         fl5igmH+yNUd0l2HtTSBz+s7Wvx+x8M/elWuCiDPlwpaGCfMF1IpDqqBQk724Zsf8BYO
         I21AeFt9rIYTvDk0LQA5JNHNsw8Y0QyB/AmGo5i+guN/Mx7N29OGOzq8YYO9YhNW3Qwg
         VBDQ==
X-Gm-Message-State: AOAM533y8rCjlU72A1aozUz8p4Vv4owo715mRTlZwj9UKC8HE3owGE77
        ol1IoiJdX4qAV1NaCxL7PVoRCH97YXhhzg==
X-Google-Smtp-Source: ABdhPJzNGeOAT08gJ63Cvz7QpVgBtWDUNyl6oqzcvFyvomhX+8fMq/2C9ljrAfdsH2gIb62EPNRRNA==
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr1031877pjn.147.1617154000848;
        Tue, 30 Mar 2021 18:26:40 -0700 (PDT)
Received: from [10.43.90.134] ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id mp1sm291979pjb.48.2021.03.30.18.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 18:26:40 -0700 (PDT)
Subject: Re: [PATCH] ima: Fix function name error in comment.
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jiele zhao <unclexiaole@gmail.com>
References: <20210323091905.317885-1-unclexiaole@gmail.com>
From:   Jiele Zhao <unclexiaole@gmail.com>
Message-ID: <0a2d133a-9f12-4e18-cd61-c5d19113dc78@gmail.com>
Date:   Wed, 31 Mar 2021 09:25:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210323091905.317885-1-unclexiaole@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Ping.

On 2021/3/23 17:19, Jiele Zhao wrote:
> Function "ima_file_check" is written as "ima_path_check" in
> the comment. Fix this error to prevent misunderstanding.
>
> Signed-off-by: Jiele Zhao <unclexiaole@gmail.com>
> ---
>   security/integrity/ima/ima_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
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
