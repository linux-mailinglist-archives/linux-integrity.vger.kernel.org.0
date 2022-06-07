Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0F54183A
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 23:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379216AbiFGVLw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379985AbiFGVLW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 17:11:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67542131F16
        for <linux-integrity@vger.kernel.org>; Tue,  7 Jun 2022 11:52:44 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nyeJf-0007KB-17; Tue, 07 Jun 2022 20:52:35 +0200
Message-ID: <0429fbb6-691d-1283-e364-209054bc38a7@pengutronix.de>
Date:   Tue, 7 Jun 2022 20:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] KEYS: trusted: tpm2: Fix migratable logic
Content-Language: en-US
To:     david.safford@gmail.com, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "SergeE.Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <141492344ae13c9842626e696685316ee340d717.camel@gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <141492344ae13c9842626e696685316ee340d717.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 07.06.22 20:07, david.safford@gmail.com wrote:
> When creating (sealing) a new trusted key, migratable
> trusted keys have the FIXED_TPM and FIXED_PARENT attributes
> set, and non-migratable keys don't. This is backwards, and
> also causes creation to fail when creating a migratable key
> under a migratable parent. (The TPM thinks you are trying to
> seal a non-migratable blob under a migratable parent.)
> 
> The following simple patch fixes the logic, and has been
> tested for all four combinations of migratable and non-migratable
> trusted keys and parent storage keys. With this logic, you will
> get a proper failure if you try to create a non-migratable
> trusted key under a migratable parent storage key, and all other
> combinations work correctly.
> 
> Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")
> Signed-off-by: David Safford <david.safford@gmail.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Thanks,
Ahmad

> ---
> Changelog:
>  * v2:
>    * added Signed-off-by, Fixes, proper Subject and distribution
> .
>  security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..2b2c8eb258d5 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -283,8 +283,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	/* key properties */
>  	flags = 0;
>  	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> -	flags |= payload->migratable ? (TPM2_OA_FIXED_TPM |
> -					TPM2_OA_FIXED_PARENT) : 0;
> +	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM |
> +					    TPM2_OA_FIXED_PARENT);
>  	tpm_buf_append_u32(&buf, flags);
> 
>  	/* policy */
> --
> 2.36.1
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
