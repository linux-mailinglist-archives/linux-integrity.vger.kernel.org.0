Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA06678F3B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 05:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjAXE03 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 23:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAXE0Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 23:26:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E035031E25;
        Mon, 23 Jan 2023 20:26:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q9so10543584pgq.5;
        Mon, 23 Jan 2023 20:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikIw7tYX2YkOjJ1SBheZ8OfWLQDqLfvM0gBP+Ityw34=;
        b=YNlNht7gd21co35WmXhV01ktN9SoD09xYeIHaYwsev8FzKFhr5Ny+jRT+oSkqttK/a
         K/BJMen8KHFwmsjrqhGD/YRaWrS08UzGHW4YbOE7Hdr4uoSXXSJ0v0x6kqV+H5IdfQro
         iuuulzywBlLaGHcWPDFDf/MDUY5iB4M0EksWeVGBvP/2wRSg0ZU72fX0cZh2FSv2k90O
         ylcAuC/EP+v6pG+zsgwJN/AYFwQ1SGhGL9z3NCk5yqWONR4gjNKeZ5h1I6T3U/YG6N6y
         XJQzIemFQbtyoIl3vpdhO47cyRn/GQtjRDKa1uMSEfBpzmLyR9KBGCAQrb1C1cfDYn/B
         TLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ikIw7tYX2YkOjJ1SBheZ8OfWLQDqLfvM0gBP+Ityw34=;
        b=GKoECWMkjtSA8B1sKiHXbULZXRNTUTcT7yp8BcXv+7CjIetWA3gsW2C9sEiHNgNj5q
         cuzdJOCNC39oyDt92VSOGxOt1LvS6beHwpQxV2KtzwiCNUetMMraxsTp1r5Fsi6zD+D7
         KqpKqBTX+dwTZiSapc36bpsugeH9YYlOq78YRVjNhhP7DW1VGeOcF/wZESzczqaxVien
         5xi8CvoSl6Q3r7WZfnzE8kb1/xPduePF6BliNTkH9zwbCNU7P7t/7/P8EBUvbOUgowV1
         Lk5RftpV5rydiMmurvgz9LOZl8Lauu33H6cK7UGHeLpAo16iSthfA1001PcyknZD69Oc
         qB0w==
X-Gm-Message-State: AFqh2ko9xKQDISVRCpIfNpBUtbb2ubt09Wzquq51apf4jcRRxPxdNcpU
        oGMDZK7mr6a/WTpCOD6biJI=
X-Google-Smtp-Source: AMrXdXsLjmAMJ1SONTARwenlQNQ6MHRz8aPxQSqwXjj4XO+jhxTE8p6ynWlTQmYvGB+ZI66aMrWXxw==
X-Received: by 2002:a05:6a00:2354:b0:580:cf1a:f2b5 with SMTP id j20-20020a056a00235400b00580cf1af2b5mr39660928pfj.12.1674534384476;
        Mon, 23 Jan 2023 20:26:24 -0800 (PST)
Received: from localhost (121-44-64-35.tpgi.com.au. [121.44.64.35])
        by smtp.gmail.com with ESMTPSA id p35-20020a056a0026e300b005898fcb7c1bsm426882pfw.177.2023.01.23.20.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 20:26:23 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Jan 2023 14:26:16 +1000
Message-Id: <CQ04W8MPPQT5.KT3IQUOE2YPG@bobo>
Subject: Re: [PATCH v4 19/24] powerpc/pseries: Turn PSERIES_PLPKS into a
 hidden option
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>, <ruscur@russell.cc>,
        <gcwilson@linux.ibm.com>, <joel@jms.id.au>
X-Mailer: aerc 0.13.0
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-20-ajd@linux.ibm.com>
In-Reply-To: <20230120074306.1326298-20-ajd@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jan 20, 2023 at 5:43 PM AEST, Andrew Donnellan wrote:
> It seems a bit unnecessary for the PLPKS code to have a user-visible
> config option when it doesn't do anything on its own, and there's existin=
g
> options for enabling Secure Boot-related features.
>
> It should be enabled by PPC_SECURE_BOOT, which will eventually be what
> uses PLPKS to populate keyrings.
>
> However, we can't get of the separate option completely, because it will
> also be used for SED Opal purposes.
>
> Change PSERIES_PLPKS into a hidden option, which is selected by
> PPC_SECURE_BOOT.
>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
> ---
>
> v3: New patch
> ---
>  arch/powerpc/Kconfig                   |  1 +
>  arch/powerpc/platforms/pseries/Kconfig | 11 +----------
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b8c4ac56bddc..d4ed46101bec 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -1029,6 +1029,7 @@ config PPC_SECURE_BOOT
>  	depends on PPC_POWERNV || PPC_PSERIES
>  	depends on IMA_ARCH_POLICY
>  	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> +	select PSERIES_PLPKS if PPC_PSERIES
>  	help
>  	  Systems with firmware secure boot enabled need to define security
>  	  policies to extend secure boot to the OS. This config allows a user
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index a3b4d99567cb..82b6f993be0f 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -151,16 +151,7 @@ config IBMEBUS
> =20
>  config PSERIES_PLPKS
>  	depends on PPC_PSERIES
> -	bool "Support for the Platform Key Storage"
> -	help
> -	  PowerVM provides an isolated Platform Keystore(PKS) storage
> -	  allocation for each LPAR with individually managed access
> -	  controls to store sensitive information securely. It can be
> -	  used to store asymmetric public keys or secrets as required
> -	  by different usecases. Select this config to enable
> -	  operating system interface to hypervisor to access this space.

Not a big deal but you could turn this into a small Kconfig comment
instead (people got strangely angry when I tried to just use help text
in hidden options as comments). But if it's easy enough to grep for and
pretty straightforward then maybe it doesn't matter. I like know what
these things do at a glance.

Thanks,
Nick
