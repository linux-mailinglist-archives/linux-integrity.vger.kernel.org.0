Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5168362F6D3
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 15:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242103AbiKROJj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 09:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiKROJi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 09:09:38 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C811160
        for <linux-integrity@vger.kernel.org>; Fri, 18 Nov 2022 06:09:36 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s206so5453078oie.3
        for <linux-integrity@vger.kernel.org>; Fri, 18 Nov 2022 06:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrQNNNmu+VKpUKFaa2u9LGpDItJlV0ZsIlrvBdiYML4=;
        b=qzUyVqdQ3U398MaCH+c1E3pR5wh7qPanMD3/wPMJ5zc+YOXla/JX7vEfEydtmYJuWZ
         HGe7hUoBbow++sKp6j+/fTijnKZzlHRYYgLxr3Frum+kb5WfYbAgeqhR9kJAqsf02qs4
         OVgATGm9xRU/y8wPfyrFGbeM2F58dSTbR9XNAlMMjX1fxzPI/y7HK0Teb1A8XHfwZeBs
         fd9/YXByFwaOh4GAPwAhU9CblxHl4NzIRcKb8+poJYV1D8FslRTwUCbkeeqtpEp60n/m
         ZjJms48ZifEZn3RLnHDihvUeUIfUAItUZ22UAoFZ/9YnsiLC15eiqi0oZoJuD1aElh+n
         KsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrQNNNmu+VKpUKFaa2u9LGpDItJlV0ZsIlrvBdiYML4=;
        b=xQmX+8oJ5eiisrcNvvUg5CI2tiVE9+813AkllkUdzemqz5fqtshrS0yWYv9btSQ7HJ
         6LG3Sx6oozFcXgg6aaRXph8t1j7AGOrtKgwGmnrh8vFCgNNEg7yK3B1gnufM7qunlepM
         jSjOTCSXYE5eD/ty74YuGIlCXVK7pVqNFGnCWKIDy63+aWpTiLhtPunJTP2IesEZ1RnC
         5xmfmGUOKXjhbzlnJXCnyY4YnnbGwcKYSQLVPz4+kP+BUPFTCgA6JU0sv1a+NE3TXtfD
         uD1FoKEekKTlqruQdOwRVa08QIZFSSukNgHRoUhfLsuDaRC+mEeyxE8w9q9ofZyn/lih
         Uvmg==
X-Gm-Message-State: ANoB5plGkNEq7sDgPGWvcDKuz8//00TQVB7+4QgRN+dUFoF0ie1fw12T
        moRpJYngPwxxOjBjuNfCH8M=
X-Google-Smtp-Source: AA0mqf7xQKja0++RjotAlx5hUokuxOfFzv8GXX7jpXcZgv4QtbiTzj2OyaPwp6jU9UR4htFIgJ12tg==
X-Received: by 2002:a05:6808:178b:b0:35a:10ae:ed71 with SMTP id bg11-20020a056808178b00b0035a10aeed71mr3653487oib.299.1668780575667;
        Fri, 18 Nov 2022 06:09:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i10-20020a05683033ea00b00666a5b5d20fsm1582632otu.32.2022.11.18.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:09:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 18 Nov 2022 06:09:33 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jan Dabros <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, jarkko@kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca, gregkh@linuxfoundation.org,
        arnd@arndb.de, rrangel@chromium.org, timvp@google.com,
        apronin@google.com, mw@semihalf.com, upstream@semihalf.com
Subject: Re: [PATCH v2 2/3] char: tpm: cr50: Use generic request/relinquish
 locality ops
Message-ID: <20221118140933.GA676681@roeck-us.net>
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-3-jsd@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103145450.1409273-3-jsd@semihalf.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 03:54:49PM +0100, Jan Dabros wrote:
> Instead of using static functions tpm_cr50_request_locality and
> tpm_cr50_release_locality register callbacks from tpm class chip->ops
> created for this purpose.
> 
> Signed-off-by: Jan Dabros <jsd@semihalf.com>
> ---
[ ... ]

>  #ifdef CONFIG_ACPI
> @@ -686,6 +714,7 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  	u32 vendor;
>  	u8 buf[4];
>  	int rc;
> +	int loc;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -ENODEV;
> @@ -728,24 +757,30 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  			 TPM_CR50_TIMEOUT_NOIRQ_MS);
>  	}
>  
> -	rc = tpm_cr50_request_locality(chip);
> -	if (rc < 0) {
> +	loc = tpm_cr50_request_locality(chip, TPM_CR50_I2C_DEFAULT_LOC);
> +	if (loc < 0) {
>  		dev_err(dev, "Could not request locality\n");
>  		return rc;

As reported by 0-day and Dan Carpenter:

		return loc;

Guenter
