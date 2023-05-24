Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE179710132
	for <lists+linux-integrity@lfdr.de>; Thu, 25 May 2023 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjEXW5a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 18:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbjEXW53 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 18:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22FBB
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684969000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2n57YKfPVwMrQwNDuZqoWvbyKlduQB03Z0HHDFLgso=;
        b=EtCWe9dcMx+p8PKu62uHg655/GpfF1YBFy+ylbD6PJnGvhOWdHd6QiCSYJ66JnnTQmG5SR
        vH3a8oMk3It6Q8ucD/BnAhk7Duq0teVhbfLkVWKhaJao4pN+ySzMmruhyDtt2lB+OQm6lM
        ASAbeI9zRGz50wNpUY7ktm5QdjlwReU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-6dGw2HneMGifHPI3jgl68Q-1; Wed, 24 May 2023 18:56:39 -0400
X-MC-Unique: 6dGw2HneMGifHPI3jgl68Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f39c562996so3469511cf.1
        for <linux-integrity@vger.kernel.org>; Wed, 24 May 2023 15:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968999; x=1687560999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2n57YKfPVwMrQwNDuZqoWvbyKlduQB03Z0HHDFLgso=;
        b=TNvgKLayjbd5NeaJjpUZuAAwAu8vaZE5jn9nGXjMuFAPdP0Y64d+/Vz25WpahiJHAX
         NGZOLO2/DOjzMNYKBW1r5wXBNbXH6zhf3ucgghRixfe7K9nJKKDLxZ1mljbt5nhckmms
         vRRxRU3VwHG8f5JNHmF5h4QsA7e8qCLA791SVCf7/iSffPucCwGo8GAb/pX5mIwx0hm/
         +dgJOVzh11Peku4yVmubF4nW5abqghITG3gQzO3WkSaJslrahu22Tde513l1gU3FmvCH
         lOtljMeDoirLL8PL/Ldq2KcSxtpctHvIv47y/lN4iC2X5FgQdMcp/YkJxyvwQsX08QQV
         SbSg==
X-Gm-Message-State: AC+VfDxzgaYFXj8Cz7maiZ84qvLyqJIVrqlYTq8/L0zu3xQ/1Rj9LNEd
        br9QYzYMFMVS02v7BsquRIUhz8m633fNXC8GP76wwJHtgihj/DzuLBFl++caclu16C5WoPR7CSQ
        sqwvhWRUFCnXg6AQLoAX6ESKoGp6/
X-Received: by 2002:a05:622a:1812:b0:3f7:f9c6:d33a with SMTP id t18-20020a05622a181200b003f7f9c6d33amr655996qtc.51.1684968999138;
        Wed, 24 May 2023 15:56:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CObucFQQ/UXbQ4sJujExv1d1biF4QFEW+6FEL2jpcT2X+WZhsbL2VOihUuYm6dAlnu94vPg==
X-Received: by 2002:a05:622a:1812:b0:3f7:f9c6:d33a with SMTP id t18-20020a05622a181200b003f7f9c6d33amr655981qtc.51.1684968998843;
        Wed, 24 May 2023 15:56:38 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w1-20020ac84d01000000b003f6b58b986fsm2303178qtv.41.2023.05.24.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:56:38 -0700 (PDT)
Date:   Wed, 24 May 2023 15:56:37 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
Message-ID: <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418134409.177485-3-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
> Simplify tpm_read_log_of() by moving reusable parts of the code into
> an inline function that makes it commonly available so it can be
> used also for kexec support. Call the new of_tpm_get_sml_parameters()
> function from the TPM Open Firmware driver.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> Tested-by: Coiby Xu <coxu@redhat.com>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> v9:
>  - Rebased on 6.3-rc7; call tpm_read_log_memory_region if -ENODEV returned
> 
> v7:
>  - Added original comment back into inlined function
> 
> v4:
>  - converted to inline function
> ---
>  drivers/char/tpm/eventlog/of.c | 30 +++++-----------------------
>  include/linux/tpm.h            | 36 ++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index 930fe43d5daf..41688d9cbd3b 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -51,11 +51,10 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
>  int tpm_read_log_of(struct tpm_chip *chip)
>  {
>  	struct device_node *np;
> -	const u32 *sizep;
> -	const u64 *basep;
>  	struct tpm_bios_log *log;
>  	u32 size;
>  	u64 base;
> +	int ret;
>  
>  	log = &chip->log;
>  	if (chip->dev.parent && chip->dev.parent->of_node)
> @@ -66,30 +65,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
>  	if (of_property_read_bool(np, "powered-while-suspended"))
>  		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
>  
> -	sizep = of_get_property(np, "linux,sml-size", NULL);
> -	basep = of_get_property(np, "linux,sml-base", NULL);
> -	if (sizep == NULL && basep == NULL)
> +	ret = of_tpm_get_sml_parameters(np, &base, &size);
> +	if (ret == -ENODEV)
>  		return tpm_read_log_memory_region(chip);
> -	if (sizep == NULL || basep == NULL)
> -		return -EIO;
> -
> -	/*
> -	 * For both vtpm/tpm, firmware has log addr and log size in big
> -	 * endian format. But in case of vtpm, there is a method called
> -	 * sml-handover which is run during kernel init even before
> -	 * device tree is setup. This sml-handover function takes care
> -	 * of endianness and writes to sml-base and sml-size in little
> -	 * endian format. For this reason, vtpm doesn't need conversion
> -	 * but physical tpm needs the conversion.
> -	 */
> -	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> -	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> -		size = be32_to_cpup((__force __be32 *)sizep);
> -		base = be64_to_cpup((__force __be64 *)basep);
> -	} else {
> -		size = *sizep;
> -		base = *basep;
> -	}
> +	if (ret < 0)
> +		return ret;
>  
>  	if (size == 0) {
>  		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4dc97b9f65fb..dd9a376a1dbb 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -461,4 +461,40 @@ static inline struct tpm_chip *tpm_default_chip(void)
>  	return NULL;
>  }
>  #endif
> +
> +#ifdef CONFIG_OF
> +static inline int of_tpm_get_sml_parameters(struct device_node *np,
> +					    u64 *base, u32 *size)
> +{
> +	const u32 *sizep;
> +	const u64 *basep;
> +
> +	sizep = of_get_property(np, "linux,sml-size", NULL);
> +	basep = of_get_property(np, "linux,sml-base", NULL);
> +	if (sizep == NULL && basep == NULL)
> +		return -ENODEV;
> +	if (sizep == NULL || basep == NULL)
> +		return -EIO;
> +
> +	/*
> +	 * For both vtpm/tpm, firmware has log addr and log size in big
> +	 * endian format. But in case of vtpm, there is a method called
> +	 * sml-handover which is run during kernel init even before
> +	 * device tree is setup. This sml-handover function takes care
> +	 * of endianness and writes to sml-base and sml-size in little
> +	 * endian format. For this reason, vtpm doesn't need conversion
> +	 * but physical tpm needs the conversion.
> +	 */
> +	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> +	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> +		*size = be32_to_cpup((__force __be32 *)sizep);
> +		*base = be64_to_cpup((__force __be64 *)basep);
> +	} else {
> +		*size = *sizep;
> +		*base = *basep;
> +	}
> +	return 0;
> +}
> +#endif
> +
>  #endif
> -- 
> 2.38.1
> 

