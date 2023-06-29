Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B92742AFC
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jun 2023 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjF2RDE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjF2RDD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 13:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805673586
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jun 2023 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688058132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAvGrde4MtuxZLnVvBlSKLGykkv5j7+I9BzanVVshIE=;
        b=SzfXLBx9ZAlQOEuJpRM7a7SrNH1CfYxrVzxNSKwzUke4bcOIzg/9XXAr5R093JbLM0A6+3
        5KNQqy2f5OOEjHlWcrx8zu+MFC0rNd9PVGBgOtzp99tjzs1HJhZZ7IL9MFayHSEsHeCosv
        Rp7oVluA1WtTCZjeYRZyNsMidFXCYro=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-y_VZzY9kPtqIOWMIKOsL7Q-1; Thu, 29 Jun 2023 13:02:10 -0400
X-MC-Unique: y_VZzY9kPtqIOWMIKOsL7Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62fe5abe808so6527616d6.1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jun 2023 10:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688058130; x=1690650130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAvGrde4MtuxZLnVvBlSKLGykkv5j7+I9BzanVVshIE=;
        b=Lqp9pUePdaggaot0KDYKqcMQIlV/oBTapAnJpXSejpVKiS4GS45HMw+XMdB4HjuHLn
         g3XhjXQ9wihms2VqJxwCvPD5oqLIo/uGJFhxsV87XxB/wj2MVnqjYrtt0PI9oW1GTKd9
         R5jWj53eMEHD9ryoBfvJNHiogweVPPZZYeg8CVh+i6ZImEfAl/D8uU3FTaeieeBr5nCm
         TOvSmUTqXjFj97ze3JQ+JZ9TSdHZmeamxSV5P1/2f8wTH7M3taUaKmOtWhWRwXSzGCQb
         O0E+3JMDsQWw9bfi8Lv5xMP5ltusfh1RIcWzoI0KZVsrmz9tGetcU8AviCWWB15AdxJQ
         y56Q==
X-Gm-Message-State: ABy/qLbhxw2pvxSTis9JNhXTVoQl4hv7VVdP0uYpRyQ6VVUG9f1Qd9xx
        0YMb82KWWugoVT0zhVkCjW5/9nx8+iAhaZO1wUZs1/XMZmiRlGCs8yGI4nq1aYu0yVBXLi6dCNq
        srdqfWCmXRczU62C0U0pzi2HsBxHV
X-Received: by 2002:a05:6214:4003:b0:62d:ed86:154b with SMTP id kd3-20020a056214400300b0062ded86154bmr570171qvb.5.1688058130050;
        Thu, 29 Jun 2023 10:02:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFIlZKSA03MUe0kuBlHNv1mmJ/JxAOE5u+mAyL+HRPpI6KWZRPdjJpykJjqW8orgC2eSoaCqQ==
X-Received: by 2002:a05:6214:4003:b0:62d:ed86:154b with SMTP id kd3-20020a056214400300b0062ded86154bmr570155qvb.5.1688058129752;
        Thu, 29 Jun 2023 10:02:09 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id p15-20020a0cf68f000000b0063631be090csm705644qvn.125.2023.06.29.10.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 10:02:09 -0700 (PDT)
Date:   Thu, 29 Jun 2023 10:02:07 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] tpm: remove redundant variable len
Message-ID: <zsl2srmpmv5tezl7gbz3gruvuj2c5xwiovnyqh67b2qtm34v7z@5uppil2tvt5z>
References: <20230616170730.2343540-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170730.2343540-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 16, 2023 at 06:07:30PM +0100, Colin Ian King wrote:
> Variable len is being accumulated but the value is never read. It is
> redundant and can be removed. Cleans up clang scan build warning:
> 
> drivers/char/tpm/eventlog/tpm1.c:276:2: warning: Value stored to 'len' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/eventlog/tpm1.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
> index 8aa9057601d6..12ee42a31c71 100644
> --- a/drivers/char/tpm/eventlog/tpm1.c
> +++ b/drivers/char/tpm/eventlog/tpm1.c
> @@ -251,7 +251,6 @@ static int tpm1_binary_bios_measurements_show(struct seq_file *m, void *v)
>  
>  static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
>  {
> -	int len = 0;
>  	char *eventname;
>  	struct tcpa_event *event = v;
>  	unsigned char *event_entry =
> @@ -273,7 +272,7 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
>  	/* 3rd: event type identifier */
>  	seq_printf(m, " %02x", do_endian_conversion(event->event_type));
>  
> -	len += get_event_name(eventname, event, event_entry);
> +	get_event_name(eventname, event, event_entry);
>  
>  	/* 4th: eventname <= max + \'0' delimiter */
>  	seq_printf(m, " %s\n", eventname);
> -- 
> 2.39.2
> 

