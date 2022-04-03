Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626CF4F08B3
	for <lists+linux-integrity@lfdr.de>; Sun,  3 Apr 2022 12:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiDCKXu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 3 Apr 2022 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiDCKXt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 3 Apr 2022 06:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3843193D;
        Sun,  3 Apr 2022 03:21:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A834D61006;
        Sun,  3 Apr 2022 10:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DECC340ED;
        Sun,  3 Apr 2022 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648981315;
        bh=va2wdSIDhigU9l6racetCvNOSAZt+vprXlIct+i0T0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rutRab4n813Pxfl1QOm3oCQU5Xw0G5pZcmivt9D8npqu4IeZ4XLNRwF6dQRZdruRS
         dQsrnuWExDhYQBC0BY4fFx2WUvuUjn+/gNQyEufnl5Thr194LQyTDkIpvzdPXzVfe2
         Gv7YrSRhK2bJdYj8xSlipwAdkRUOFgih9P1B3sErpDmLLPVUZDBQ89UgGaDF3RV1RQ
         P772i3/NCOcdOFRMNPBpTmgXdzJeQfB0ykaj1GaNDLLhOlo5sNA9xIIMQJakuFFdAR
         fw6wsZpyDuioEbDdlPYXoUIcScjf+fI0xwqZYGjenu5uz91SR5iFuK/NlWI580+F20
         FUdDBek5lAsJw==
Date:   Sun, 3 Apr 2022 13:23:05 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] char: tpm: Prepare cleanup of powerpc's asm/prom.h
Message-ID: <Ykl1ibvVxJUBrhfK@kernel.org>
References: <7a522d9029737d7a1fb513529659321ed62d50d9.1648895070.git.christophe.leroy@csgroup.eu>
 <cfd3a718e147b39620dfa7c779a7ae1af2f6b575.1648895074.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd3a718e147b39620dfa7c779a7ae1af2f6b575.1648895074.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Apr 02, 2022 at 12:29:19PM +0200, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I don't understand this. It changes nothing as far as kernel is concerned.

> ---
>  drivers/char/tpm/tpm_atmel.h   | 2 --
>  drivers/char/tpm/tpm_ibmvtpm.c | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
> index ba37e77e8af3..959f7cce8301 100644
> --- a/drivers/char/tpm/tpm_atmel.h
> +++ b/drivers/char/tpm/tpm_atmel.h
> @@ -26,8 +26,6 @@ struct tpm_atmel_priv {
>  
>  #ifdef CONFIG_PPC64
>  
> -#include <asm/prom.h>
> -
>  #define atmel_getb(priv, offset) readb(priv->iobase + offset)
>  #define atmel_putb(val, priv, offset) writeb(val, priv->iobase + offset)
>  #define atmel_request_region request_mem_region
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 3af4c07a9342..1180cce7067a 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -20,7 +20,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
>  #include <linux/wait.h>
> -#include <asm/prom.h>
>  
>  #include "tpm.h"
>  #include "tpm_ibmvtpm.h"
> -- 
> 2.35.1
> 

BR, Jarkko
