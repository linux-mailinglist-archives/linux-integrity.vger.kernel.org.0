Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B364D59BF
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 05:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbiCKEp5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Mar 2022 23:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiCKEp4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Mar 2022 23:45:56 -0500
X-Greylist: delayed 191 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 20:44:52 PST
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DEE12BF4E;
        Thu, 10 Mar 2022 20:44:52 -0800 (PST)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-08.nifty.com with ESMTP id 22B4Za1E028698;
        Fri, 11 Mar 2022 13:35:36 +0900
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 22B4ZAqd019685;
        Fri, 11 Mar 2022 13:35:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 22B4ZAqd019685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646973311;
        bh=LjOGr0pIATee6R8ACoH57i1hpgApkEujUZuMS4lP7v8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rQcco8k5x7idvPaucbYhdy9OS4UGkaySWfHK/oPxSIKfKH9IkR/KCdlIbqE251Zjj
         GUkAxnyBE/fDd4IPzxWx8odoVNMtti0u8tAPyGNbPSJpe50baxLlv3VgrxQt+Kct7c
         thhiM2Z9tSZ4UZTWAkd12ToXtQcMlXWHdOc0beDnfR6n7flwGIeXMc+HpoJozxFkOJ
         KzOy+dbS3AD0wO/8QsE580tgztKblTGu5ZI4Cyz0x0zcvWXzA5NfUENNSHnhp8itMX
         z8okMuiUCokPndSTBRRkr3LKO9zQltOt+vrNB2iq8u6X30rXf8d0nnrumhnjPHFvM/
         5RcYnD0JrfFag==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id e2so6731238pls.10;
        Thu, 10 Mar 2022 20:35:10 -0800 (PST)
X-Gm-Message-State: AOAM533OJz2gN09FgpEXOn1Yg5EMosuB8EeL2yAOH3h2hfYyLrR0MXqD
        MYmu1+DOjnRXu6JxDFHnPAMXE/+KWFnruY+AYs4=
X-Google-Smtp-Source: ABdhPJyNCJkb3M7ukFi53zgoJUHhvSQ95COymbct3oUAAg6F4eHuljQlez2+7VK5S8Wkne54zlfb5/vEPBZyEYdE0jY=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr8764545plr.136.1646973309837; Thu, 10
 Mar 2022 20:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20220310214450.676505-1-nayna@linux.ibm.com> <20220310214450.676505-4-nayna@linux.ibm.com>
In-Reply-To: <20220310214450.676505-4-nayna@linux.ibm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 11 Mar 2022 13:34:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKqn1B=j2oeFb1r5oBrrcbJYrAQd0v2LqmqQT1F+1LLw@mail.gmail.com>
Message-ID: <CAK7LNAQKqn1B=j2oeFb1r5oBrrcbJYrAQd0v2LqmqQT1F+1LLw@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] certs: conditionally build extract-cert if
 platform keyring is enabled
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dimitri.ledkov@canonical.com, seth@forshee.me,
        rnsastry@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 11, 2022 at 6:45 AM Nayna Jain <nayna@linux.ibm.com> wrote:
>
> extract-cert is used outside certs/ by INTEGRITY_PLATFORM_KEYRING.
> Also build extract-cert if INTEGRITY_PLATFORM_KEYRING is enabled.

If really so, extract-cert should go back to scripts/ again.
(i.e. revert 340a02535ee785c64c62a9c45706597a0139e972)



>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  certs/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/certs/Makefile b/certs/Makefile
> index b92b6ff339d5..dfb48e043cfe 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -88,7 +88,11 @@ $(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) $(obj)/extract-cer
>
>  targets += x509_revocation_list
>
> +ifeq ($(CONFIG_INTEGRITY_PLATFORM_KEYRING),y)
> +hostprogs-always-y := extract-cert
> +else
>  hostprogs := extract-cert
> +endif
>
>  HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
>  HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> --
> 2.27.0
>


--
Best Regards
Masahiro Yamada
