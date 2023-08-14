Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89677C397
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Aug 2023 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjHNWkr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Aug 2023 18:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjHNWkp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Aug 2023 18:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6948E65
        for <linux-integrity@vger.kernel.org>; Mon, 14 Aug 2023 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692052802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l7gIh6nlPqSk8LuuWdz7csSouyNxDZki4ms0rDOko5s=;
        b=WRIjQBjJPz9VloENeOoxHvr/UkFHC9HZn+lnCinXL0z0HiPD4W1nXXKdJIh1laTiuzu6o/
        vIB9UzIDO2cFz+upj9ulNs3WJq9goPyw8yiFC+KrTZ26jjjnlkGKk4GV60r+H74ZMjXGvh
        JwPSnTEeLgxYez756nb6T1oo67flMao=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-QqyJcX5xN6qs7ppfaNofoQ-1; Mon, 14 Aug 2023 18:40:01 -0400
X-MC-Unique: QqyJcX5xN6qs7ppfaNofoQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5646868b9e7so5080613a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 14 Aug 2023 15:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052800; x=1692657600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7gIh6nlPqSk8LuuWdz7csSouyNxDZki4ms0rDOko5s=;
        b=ai3PGZ3H2XlAhWP33C1mdEzKn33+7yI8+xYqYGVu1+7qIE9Y3YA8SxOMM5jP1jPvpO
         neutwBE1kBf9t5idTfzfS7d4HnqbJPaw/D4qKpZkaLZG96dr94q9CmkEQ1ITHOgTI0ep
         FyhoYtKk9wxBEBJBomt3G5WNhIuEa3PO2tz1D0NwaTLcx7Ih0ULBaBASu4RXfLeFUmaw
         chpzrilQjGPMow42mHTlVC+3na21yNxMQCAaSnKd67sQ4U5oTPupo1g0vvXLlRo4wUIS
         Q3ovpnaj75n6B3rrNeshh0/wCZijfdaRcSfvtebMKb2Fg/inA48pJN1Qp2zT4pZReu7O
         9U6Q==
X-Gm-Message-State: AOJu0YxyvBnpjKEvs2b9MQ+DxdXlf6GFbg7x4n7ox9Kp0ozk3A/FyvQp
        heDnwf4OTM0nTkGN4e++A7GqkQUB1MYKxDMXeDkG3MTsvyOLmw5P1/394B4M9k8bVJm5VPtu0nV
        ycR8wu6WfRX50vs6NbucUtYdz+K3yT2qn6IhG
X-Received: by 2002:a05:6a20:441f:b0:12e:7c29:a6dd with SMTP id ce31-20020a056a20441f00b0012e7c29a6ddmr11376824pzb.43.1692052800014;
        Mon, 14 Aug 2023 15:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF01jSZJ6upznh7bf7zow0hjWHaC+2v5nH9nEmy2PDwpj41mQnVkeFYwD3RO97AQ8NT35C/VA==
X-Received: by 2002:a05:6a20:441f:b0:12e:7c29:a6dd with SMTP id ce31-20020a056a20441f00b0012e7c29a6ddmr11376811pzb.43.1692052799700;
        Mon, 14 Aug 2023 15:39:59 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001b53953f306sm9975124plh.178.2023.08.14.15.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 15:39:57 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:39:56 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts categorically for Lenovo
Message-ID: <7ruidj3qnt6eapetwt6uwhkqeextehaisoc2i6axqax3s5js7z@eu6hoh2q7tkd>
References: <20230810182433.518523-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810182433.518523-1-jarkko@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 10, 2023 at 09:24:33PM +0300, Jarkko Sakkinen wrote:
> By large most of the entries in tpm_tis_dmi_table[] are for Lenovo laptops,
> and they keep on coming. Therefore, disable IRQs categorically for Lenovo.
> 
> Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
> Cc: <stable@vger.kernel.org> # v6.4+
> Reported-by: "Takashi Iwai" <tiwai@suse.de>
> Closes: https://lore.kernel.org/linux-integrity/87il9qhxjq.wl-tiwai@suse.de/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Acked-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
> This will be included into v6.5-rc6 PR, as long as Takashi ack's it. I'm
> planning to send tomorrow morning (GMT+3).
> 
> BR, Jarkko
>  drivers/char/tpm/tpm_tis.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 3c0f68b9e44f..dd0f52d35073 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -132,42 +132,8 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  	},
>  	{
>  		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad T490s",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P360 Tiny",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L490",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkPad L590",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
> -		},
> -	},
> -	{
> -		.callback = tpm_tis_disable_irq,
> -		.ident = "ThinkStation P620",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
>  		},
>  	},
>  	{
> -- 
> 2.39.2
> 

