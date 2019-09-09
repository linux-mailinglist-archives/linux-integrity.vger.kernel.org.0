Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23F9AD82C
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbfIILpB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 07:45:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:44706 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbfIILpA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 07:45:00 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x89BiilT010794;
        Mon, 9 Sep 2019 20:44:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x89BiilT010794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568029485;
        bh=I3CsomKgu9imQxkvjbyNpxE/dZyao6xzfj9/GBFFAeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JnJGdpWX656H/7JUXEDl6GjrR8XxkO/uv90E/8WhpSNDAQlPRfhHyfpe4QxQ4VL8G
         aEZ+DGxuzXyCefb059uPDNngUiOoBPYaZHoYri9J/QM/wdbaYMCy7IZjqxfLWDXu/4
         8yhLceDcRouc1pKQum5E1mbBxNuNJ9Be5TDeP8wRoXbP1BWNYJM5rnjLzKB+Ccjj8T
         aeRO15Fqv0qP/AhHcbi4UJSbHKMRflU+KigBR47OdnNS04UCtopoo+NKNJXuWRA2j5
         T4GJ45qVOw0WXu0XagbLXPvKopOScIxcVoqvr9fdLdb9pkvXEgQUbIYknVYYsmr5GI
         5o3G/bKd/wrBw==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id 82so2622132vkf.11;
        Mon, 09 Sep 2019 04:44:45 -0700 (PDT)
X-Gm-Message-State: APjAAAWzPA6iwnbR2PfkUvqSgu8LeaI0hVnqszguD5uZJTVPccy8Jjq8
        OUGjsub8tiQGXcbnoH8hsq9FS01P3NNXsZjNARo=
X-Google-Smtp-Source: APXvYqx6xE3Ak7n9uhq+LlGdwoa0XIG2mkHcWi624WGm18rnlIfGcU/3qQByUAHVhIiDsRFOUb28reEwcs4bOx4373k=
X-Received: by 2002:a1f:998f:: with SMTP id b137mr10651098vke.0.1568029484310;
 Mon, 09 Sep 2019 04:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190726021058.4212-1-yamada.masahiro@socionext.com> <20190726021058.4212-3-yamada.masahiro@socionext.com>
In-Reply-To: <20190726021058.4212-3-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 9 Sep 2019 20:44:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdBGk+xQDe3Q+MhE++unwfiRcuVEhNsmMffY7AMwf7Pw@mail.gmail.com>
Message-ID: <CAK7LNASdBGk+xQDe3Q+MhE++unwfiRcuVEhNsmMffY7AMwf7Pw@mail.gmail.com>
Subject: Re: [PATCH 2/5] integrity: remove pointless subdir-$(CONFIG_...)
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Dave Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 26, 2019 at 11:12 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The ima/ and evm/ sub-directories contain built-in objects, so
> obj-$(CONFIG_...) is the correct way to descend into them.
>
> subdir-$(CONFIG_...) is redundant.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Ping.


>
>  security/integrity/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index b6d6273a4176..35e6ca773734 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -14,7 +14,5 @@ integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
>                                         platform_certs/load_uefi.o
>  integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
>
> -subdir-$(CONFIG_IMA)                   += ima
>  obj-$(CONFIG_IMA)                      += ima/
> -subdir-$(CONFIG_EVM)                   += evm
>  obj-$(CONFIG_EVM)                      += evm/
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
