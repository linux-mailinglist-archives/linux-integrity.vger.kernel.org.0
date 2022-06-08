Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36F542ADC
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiFHJKz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiFHJJm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 05:09:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B61E049E
        for <linux-integrity@vger.kernel.org>; Wed,  8 Jun 2022 01:30:07 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nyr4d-0002wQ-2V; Wed, 08 Jun 2022 10:29:55 +0200
Message-ID: <c9fdf487-c523-de3d-425c-e11d8f2f44bc@pengutronix.de>
Date:   Wed, 8 Jun 2022 10:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] security:trusted_tpm2: Fix memory leak in
 tpm2_key_encode()
Content-Language: en-US
To:     Jianglei Nie <niejianglei2021@163.com>, jejb@linux.ibm.com,
        jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220608025938.447908-1-niejianglei2021@163.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220608025938.447908-1-niejianglei2021@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jianglei,

On 08.06.22 04:59, Jianglei Nie wrote:
> tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
> but it is never freed, which leads to a memory leak. Free the memory
> chunk with kfree() in the return path.

Repeating my question in your implicit v1:
Are you sure, scratch need not be freed in the successful return case?
asn1_encode_sequence() copies bytes out of scratch into payload->blob,
so it looks like the buffer is unused after function return.

Cheers,
Ahmad

> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..dc9efd6c8b14 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -57,8 +57,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  		unsigned char bool[3], *w = bool;
>  		/* tag 0 is emptyAuth */
>  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> +			kfree(scratch);
>  			return PTR_ERR(w);
> +		}
>  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
>  	}
>  
> @@ -69,8 +71,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	 * trigger, so if it does there's something nefarious going on
>  	 */
>  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> -		 "BUG: scratch buffer is too small"))
> +		 "BUG: scratch buffer is too small")) {
> +		kfree(scratch);
>  		return -EINVAL;
> +	}
>  
>  	work = asn1_encode_integer(work, end_work, options->keyhandle);
>  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> @@ -79,8 +83,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  	work1 = payload->blob;
>  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
>  				     scratch, work - scratch);
> -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> +		kfree(scratch);
>  		return PTR_ERR(work1);
> +	}
>  
>  	return work1 - payload->blob;
>  }


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
