Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9693C3A323A
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 19:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFJRir (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 13:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhFJRip (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 13:38:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FF8F613E3;
        Thu, 10 Jun 2021 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623346609;
        bh=+1tQiZNU1Tg3J55mdurPHSzDLywKLAqj1M7ZvWOMWW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NgbdJ2PCaAkYmUyRYacUziIM2IrTA9t8bd/XmiCEO+Y5NaUAXYKkqkxsUJk0CJryD
         3SdKcS+wXHVBzh55rx+kbX8etXC+MJKskaFFY4ODkhdUVt7FdyslYXEfyox1tRQSml
         1dbjw0JNm2PFExuTvraBx6jzLB9p+L7VtMbAwPy6Og+dEXnCfRoQjebVCgtWNQB9q5
         da1f7VDjkxiCaogNlp+Tqtv4v6rncR8uWAhLHIUhX6xkaKceRmwGQYluoTFt80nWoD
         ZURNZ2OGjY6Ef269I/7yT7lsqwcayKDCkFJuatt5LrO7erG5IOgzxqnJexxzwwcHUX
         Cbs5vYrzwOQCg==
Received: by mail-ej1-f50.google.com with SMTP id c10so415658eja.11;
        Thu, 10 Jun 2021 10:36:49 -0700 (PDT)
X-Gm-Message-State: AOAM530l/qYTs9Xqh1VhFDWXoDqJWhdY+jFQBAV5yX/GT8ffikkQzUuk
        eQP5RJN+HW6GfKPAFun0HGZA1DSroathzPTJ+A==
X-Google-Smtp-Source: ABdhPJw5xYt6nIlAJ9D3ldJz2gtoC3Qim5TbJjSdIdpLtzj9Synmb5ERXvf35DBcxSTzLLyfRZrk8Cm1MnVZObrIxN4=
X-Received: by 2002:a17:906:e2d3:: with SMTP id gr19mr650526ejb.525.1623346608045;
 Thu, 10 Jun 2021 10:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210610171553.3806-1-nramas@linux.microsoft.com> <20210610171553.3806-2-nramas@linux.microsoft.com>
In-Reply-To: <20210610171553.3806-2-nramas@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Jun 2021 12:36:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8R6M0oWgM_+i46_g5in9URRPuc3p7SvDMiXHOXVMs+w@mail.gmail.com>
Message-ID: <CAL_JsqK8R6M0oWgM_+i46_g5in9URRPuc3p7SvDMiXHOXVMs+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ima: Fix warning: no previous prototype for function 'ima_post_key_create_or_update'
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        tusharsu@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 10, 2021 at 12:16 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> The function prototype for ima_post_key_create_or_update() is present
> in 'linux/ima.h'.  But this header file is not included in
> ima_asymmetric_keys.c where the function is implemented.  This results
> in the following compiler warning when "-Wmissing-prototypes" flag
> is turned on:
>
>   security/integrity/ima/ima_asymmetric_keys.c:29:6: warning: no previous
>   prototype for 'ima_post_key_create_or_update' [-Wmissing-prototypes]
>
> Include the header file 'linux/ima.h' in ima_asymmetric_keys.c to
> fix the compiler warning.
>
> Fixes: 88e70da170e8 (IMA: Define an IMA hook to measure keys)
> Cc: stable@vger.kernel.org
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_asymmetric_keys.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
