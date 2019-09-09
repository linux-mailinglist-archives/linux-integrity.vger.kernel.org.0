Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEBBAD87B
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 14:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbfIIMF5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 08:05:57 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:23753 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387569AbfIIMF5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 08:05:57 -0400
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 08:05:55 EDT
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-10.nifty.com with ESMTP id x89BiGdp022438;
        Mon, 9 Sep 2019 20:44:16 +0900
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x89BiAUR018670;
        Mon, 9 Sep 2019 20:44:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x89BiAUR018670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568029451;
        bh=of2s0vFLHh9Xp+TAKb4j4quIC4aFs7+CQ9EVWEBoOXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FxXgmurF6mxeDS60G1oeYiUS9P/0FdqK3IuE6+pNylWWl0JC9YTccp3nDkDjoghYm
         HJRy8imvWFb9FJvmthHjPNCpObFu89E8cNKvpkvYdFaphQFN1ytFPKlOWTpFMq/REG
         UX6Sr1xQqj5P4F8OI0coJlWuZLV96XyNDDo9oTxoD2md5vA6vOvEliQhXVg8Q9oKMa
         6mS4RTZavsxHL4BatlyaahCO7qGmKODsNVBUQo5XLv0JP5vSiojJHL1BxHePZW+sML
         r5jUPN2YcalUSFF6lNt5xXr/ETxtUOrO35I3eHRXQStPPEKUAKzROuvnu2JjXEiYEf
         apYKZ+1vMUM7A==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id k12so4133631uan.13;
        Mon, 09 Sep 2019 04:44:10 -0700 (PDT)
X-Gm-Message-State: APjAAAXsONBP+ovDwCYZotbtyQIkyK/s3ka6wO8GbnGsz0ig47gHHn5t
        fRTwc4S8h9Wmo6xc7qMr/o1j0T2q6ezJfZu59U4=
X-Google-Smtp-Source: APXvYqyiuOyxhpYGNWsBUxwx3KfspUmCoygmqcgVBTNco1JFlWrzoMv8KeT07F5nk5pp3m3XjunIkVE3l/KQjpoLVjk=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr10805775uad.25.1568029449667;
 Mon, 09 Sep 2019 04:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190726021058.4212-1-yamada.masahiro@socionext.com> <20190726021058.4212-2-yamada.masahiro@socionext.com>
In-Reply-To: <20190726021058.4212-2-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 9 Sep 2019 20:43:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1KfUb5vkU7r=fUWqo+YoavzuirT050+8z9T4FpOYOQg@mail.gmail.com>
Message-ID: <CAK7LNAT1KfUb5vkU7r=fUWqo+YoavzuirT050+8z9T4FpOYOQg@mail.gmail.com>
Subject: Re: [PATCH 1/5] integrity: remove unneeded, broken attempt to add -fshort-wchar
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

On Fri, Jul 26, 2019 at 11:11 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I guess commit 15ea0e1e3e18 ("efi: Import certificates from UEFI Secure
> Boot") attempted to add -fshort-wchar for building load_uefi.o, but it
> has never worked as intended.
>
> load_uefi.o is created in the platform_certs/ sub-directory. If you
> really want to add -fshort-wchar, the correct code is:
>
>   $(obj)/platform_certs/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar
>
> or, in a more Kbuild-ish way:
>
>   CFLAGS_load_uefi.o := -fshort-wchar
>
> But, you do not need to fix it.
>
> Commit 8c97023cf051 ("Kbuild: use -fshort-wchar globally") had already
> added -fshort-wchar globally. This code was unneeded in the first place.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Ping.



>
>  security/integrity/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/security/integrity/Makefile b/security/integrity/Makefile
> index 19faace69644..b6d6273a4176 100644
> --- a/security/integrity/Makefile
> +++ b/security/integrity/Makefile
> @@ -13,7 +13,6 @@ integrity-$(CONFIG_INTEGRITY_PLATFORM_KEYRING) += platform_certs/platform_keyrin
>  integrity-$(CONFIG_LOAD_UEFI_KEYS) += platform_certs/efi_parser.o \
>                                         platform_certs/load_uefi.o
>  integrity-$(CONFIG_LOAD_IPL_KEYS) += platform_certs/load_ipl_s390.o
> -$(obj)/load_uefi.o: KBUILD_CFLAGS += -fshort-wchar
>
>  subdir-$(CONFIG_IMA)                   += ima
>  obj-$(CONFIG_IMA)                      += ima/
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
