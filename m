Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26D5AE8F5
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiIFNBu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiIFNBt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 09:01:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD9E3DF27;
        Tue,  6 Sep 2022 06:01:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5580C5C00FE;
        Tue,  6 Sep 2022 09:01:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Sep 2022 09:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1662469307; x=
        1662555707; bh=+bq++KlIipu0cdQS5ncn1+iq48chMWWv5/BsxA4EuyY=; b=e
        ZHBaXvwrU7Qb+wVVz6h82IsGpPuMjGK4oVRZkbqDrqRH5Xqu8Z94xtqRzGrQzalu
        lgRlIWfR5F7bXvhU7fKGZzbS7G/ULfzIizpxfaED/cXFfMNTCIg+DO5U8MCcVUZ3
        4nr0jwCc8wBX/NnZgxczbLmbhkguw+xGcpU0a8o16bjfABiedK2zxwExvyY6G9+o
        lzi6Ar8UcB9OhVs8queeR34E68sS+xxB3AH2miJ8Fhn/NKEBj9fpA8jWEqSQO1YP
        jsqkBpRdSCVOWL0/70lbebo4jl1Deogssz+BxBmX+3DDWlXh9hGZv7sGfDpEjf85
        iaRHm0gCQ3HNQ1N8Kecww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662469307; x=
        1662555707; bh=+bq++KlIipu0cdQS5ncn1+iq48chMWWv5/BsxA4EuyY=; b=H
        fDdED3Fd7nmtuxNbPXWYEj78M14rnfF1byIh3oLg1m5SOo7s6AUFWXVgesB3hWbi
        9zuishL8C6r5C5vvi5if3T5Y2OALzqwR4j8f8lf2+VuPtvbpETTQHj4kfWk796jY
        jPaLLh+uL5EXksGyVYUw3f1KFaMtTlR+1bXE34w+jI6B/XKNyOyWznccRgcLLm6G
        rnO6EH8U7sL6E9LQV7uuIw2J9k1zeQO87VU4dOrIg1xxyATRYqNsJNPj74ATGqtG
        kwHB9HA9C9ZJs+djfqLQB0EQRYeuUZYYZfsA5Q4IKkTtpmk/OqJkd0+B/2TvPNkN
        9DRcuXrt1MhbzCDAQoxIg==
X-ME-Sender: <xms:sUQXY1lQ63HIxSNKaZXoyf9m4KiL2lv4P3H7Q16NmUWBCf13cqGe1A>
    <xme:sUQXYw1IY3NZ7ZUO8ywLnAPBcsBa8FUTm15-d7DgOkSI7YQ78YUv0nZgjxDOo-T95
    uluvWTZE4YrNizwSXI>
X-ME-Received: <xmr:sUQXY7qzXf1exLjIPgtgBzznsLaklPZWzGz7AphzdFwS_czOGYdjRaDwpxbt_a1L8A5LRt-dhiBNdUh7Cc-tJCrYSGsgEalkHESi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelkedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjfgesthekredttderjeenucfhrhhomhepuegv
    nhcuuehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrg
    htthgvrhhnpedukedvjeetueduffevfffhleefgfejhefffefhhfegieeiudevheefjeff
    teevfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:skQXY1kOulCrP5euAZWM95oTktHEffuVwXKAlb8n_74f_pCI0797yw>
    <xmx:skQXYz3WayxQmyeFVdEhcfad7bCsH6cbOjQiWecwPUxNvC8f6sqiPw>
    <xmx:skQXY0uih7NVUd2gf_J96ffdgqVekqTvQ0AumhNJgeabj1lZets_jQ>
    <xmx:u0QXY8e0pOe-C4-2jM3u81zHM8FtvCvASE8PAF425uR_XU3GvFp32Q>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Sep 2022 09:01:37 -0400 (EDT)
Date:   Tue, 6 Sep 2022 09:01:36 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [RFC PATCH HBK: 1/8] keys-trusted: new cmd line option added
Message-ID: <YxdEsCmQIwi7VSuv@farprobe>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-2-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906065157.10662-2-pankaj.gupta@nxp.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 06, 2022 at 12:21:50 +0530, Pankaj Gupta wrote:
> Two changes are done:
> - new cmd line option "hw" needs to be suffix, to generate the
>   hw bound key.
>   for ex:
>    $:> keyctl add trusted <KEYNAME> 'new 32 hw' @s
>    $:> keyctl add trusted <KEYNAME> 'load $(cat <KEY_BLOB_FILE_NAME>) hw' @s
> 
> - For "new", generating the hw bounded trusted key, updating the input key
>   length as part of seal operation as well.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  include/keys/trusted-type.h               |  2 ++
>  security/keys/trusted-keys/trusted_caam.c |  6 ++++++
>  security/keys/trusted-keys/trusted_core.c | 14 ++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 4eb64548a74f..064266b936c7 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -22,6 +22,7 @@
>  #define MAX_BLOB_SIZE			512
>  #define MAX_PCRINFO_SIZE		64
>  #define MAX_DIGEST_SIZE			64
> +#define HW_BOUND_KEY                    1
>  
>  struct trusted_key_payload {
>  	struct rcu_head rcu;
> @@ -29,6 +30,7 @@ struct trusted_key_payload {
>  	unsigned int blob_len;
>  	unsigned char migratable;
>  	unsigned char old_format;
> +	unsigned char is_hw_bound;
>  	unsigned char key[MAX_KEY_SIZE + 1];
>  	unsigned char blob[MAX_BLOB_SIZE];
>  };
> diff --git a/security/keys/trusted-keys/trusted_caam.c b/security/keys/trusted-keys/trusted_caam.c
> index e3415c520c0a..fceb9a271c4d 100644
> --- a/security/keys/trusted-keys/trusted_caam.c
> +++ b/security/keys/trusted-keys/trusted_caam.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
> + * Copyright 2022 NXP, Pankaj Gupta <pankaj.gupta@nxp.com>
>   */
>  
>  #include <keys/trusted_caam.h>
> @@ -23,6 +24,7 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
>  		.input  = p->key,  .input_len   = p->key_len,
>  		.output = p->blob, .output_len  = MAX_BLOB_SIZE,
>  		.key_mod = KEYMOD, .key_mod_len = sizeof(KEYMOD) - 1,
> +		.is_hw_bound = p->is_hw_bound,
>  	};
>  
>  	ret = caam_encap_blob(blobifier, &info);
> @@ -30,6 +32,9 @@ static int trusted_caam_seal(struct trusted_key_payload *p, char *datablob)
>  		return ret;
>  
>  	p->blob_len = info.output_len;
> +	if (p->is_hw_bound)
> +		p->key_len = info.input_len;
> +
>  	return 0;
>  }
>  
> @@ -40,6 +45,7 @@ static int trusted_caam_unseal(struct trusted_key_payload *p, char *datablob)
>  		.input   = p->blob,  .input_len  = p->blob_len,
>  		.output  = p->key,   .output_len = MAX_KEY_SIZE,
>  		.key_mod = KEYMOD,  .key_mod_len = sizeof(KEYMOD) - 1,
> +		.is_hw_bound = p->is_hw_bound,
>  	};
>  
>  	ret = caam_decap_blob(blobifier, &info);
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index c6fc50d67214..7f7cc2551b92 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -79,6 +79,8 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
>  	int key_cmd;
>  	char *c;
>  
> +	p->is_hw_bound = !HW_BOUND_KEY;

This seems…backwards to me.

> @@ -94,6 +96,12 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
>  		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
>  			return -EINVAL;
>  		p->key_len = keylen;
> +		/* second argument is to determine if tied to HW */
> +		c = strsep(datablob, " \t");
> +		if (c) {
> +			if (strcmp(c, "hw") == 0)
> +				p->is_hw_bound = HW_BOUND_KEY;
> +		}

Userspace documentation is missing for this new field. Must it always be
second or is it "any following argument"? For example, let's say we have
another flag like this for "FIPS" (or whatever). It'd be nice if these
all worked:

    'new 32 fips hw'
    'new 32 fips'
    'new 32 hw fips'
    'new 32 hw'

> @@ -107,6 +115,12 @@ static int datablob_parse(char **datablob, struct trusted_key_payload *p)
>  		ret = hex2bin(p->blob, c, p->blob_len);
>  		if (ret < 0)
>  			return -EINVAL;
> +		/* second argument is to determine if tied to HW */
> +		c = strsep(datablob, " \t");
> +		if (c) {
> +			if (strcmp(c, "hw") == 0)
> +				p->is_hw_bound = HW_BOUND_KEY;
> +		}

Same here.

--Ben
