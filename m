Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33DB3A3226
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 19:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFJRg3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 13:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhFJRg3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 13:36:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15CA461285;
        Thu, 10 Jun 2021 17:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623346473;
        bh=dNIHjRvGznZO34knj/aULyfJ8MaOoBksZw/TOT4vmBk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hZHxlhunmubpXxnzITD1WT+WW/7FL+S03kOloC/WsTBkIsDiktc+o820NgALZuvBH
         wXDo+x67sqK9Hu4FWHnfHaY9RIV66hOPRctN629ZJ6r3w5zDqGiZd2yoWV8mABlyhU
         21VEJPfaEeAr+moc2ixuFXIYwYQapxsUbBUeiYAaU2kRPxHwoBIf+XL1Kqq3lZRQSV
         oL9IM9hnE3s2+CJWkiXT5jvzzHYkfpgt4ipDwCImapVQBUvkCvEeeQ3GC0rdGQwR5B
         SdoWA25x8qrt0od0LMb7CBvhZhLdPQo3QISg9AgQThL/EcfCXQE8JU/gv7gVkCLGde
         +Qj8rd3uqyfkA==
Received: by mail-ed1-f43.google.com with SMTP id t3so34003538edc.7;
        Thu, 10 Jun 2021 10:34:32 -0700 (PDT)
X-Gm-Message-State: AOAM530kzuVD68tnVuayv9NUXPUTwZR1ZlYzbdrrD09ZPMaFxRA2NlUq
        4KV6G5KnimOdpCTCTnmyXnRTm4UekwLc+rzCqw==
X-Google-Smtp-Source: ABdhPJxvAiWbQxsci2/cGowEWilAUwTx4zI1gjdCQ8Q8q4UuiIYX7d3rx9jzpfMb73r+94D5ZN9+2BcHTGq4hy8P+S0=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr641483edt.194.1623346471674;
 Thu, 10 Jun 2021 10:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210610171553.3806-1-nramas@linux.microsoft.com>
In-Reply-To: <20210610171553.3806-1-nramas@linux.microsoft.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Jun 2021 12:34:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcypxO+6X3MgjGGvBYELcOi34TjoscMMrkB4PApquuQQ@mail.gmail.com>
Message-ID: <CAL_JsqKcypxO+6X3MgjGGvBYELcOi34TjoscMMrkB4PApquuQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ima: Fix warning: no previous prototype for function 'ima_add_kexec_buffer'
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
> The function prototype for ima_add_kexec_buffer() is present
> in 'linux/ima.h'.  But this header file is not included in
> ima_kexec.c where the function is implemented.  This results
> in the following compiler warning when "-Wmissing-prototypes" flag
> is turned on:
>
>   security/integrity/ima/ima_kexec.c:81:6: warning: no previous prototype
>   for function 'ima_add_kexec_buffer' [-Wmissing-prototypes]
>
> Include the header file 'linux/ima.h' in ima_kexec.c to fix
> the compiler warning.
>
> Fixes: dce92f6b11c3 (arm64: Enable passing IMA log to next kernel on kexec)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
