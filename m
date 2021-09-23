Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22D0416860
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Sep 2021 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbhIWXOI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Sep 2021 19:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42523 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243530AbhIWXOI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Sep 2021 19:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632438755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jrUDmEsFlAqsXSCqcMguRu0ocBSxp9jaMQmZzgC6BBQ=;
        b=gcGnTmm7+b4T3q8LxyEROnDuGBBU5/jG75Gj1UqDRGWmloRIlWdu1PI6MLs9TJTRqT5I8w
        PMIUmCaEAOE6fKFTodjKo1P/X2GOkPyzpYYKqFYDb8oFvXjvulXvV50cITV/qiDmDhJmxP
        HXJpOAqTe0sL3k5aw9EOww5ETh568cc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-mDPHE4CNPjSZ-vAx-YatIA-1; Thu, 23 Sep 2021 19:12:35 -0400
X-MC-Unique: mDPHE4CNPjSZ-vAx-YatIA-1
Received: by mail-wr1-f71.google.com with SMTP id z2-20020a5d4c82000000b0015b140e0562so6458160wrs.7
        for <linux-integrity@vger.kernel.org>; Thu, 23 Sep 2021 16:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jrUDmEsFlAqsXSCqcMguRu0ocBSxp9jaMQmZzgC6BBQ=;
        b=ABuC0ofAvPRtfLBTS9JDZhphdGDh5YS3k1wCTY/IBjOOhEE0+o4/JmgJC2mo4qXzG0
         t5TZow8z9VmLTT62XPHdElMreO7fUuoQPBh2XSFyqosfI4rGWEKyvKbeHylJZyTDnkr5
         PQHwwByJKKbVwQLNfGnfdXHTNzYAee/olVSsW2WEtGlsDMN2EuztbTBZvla4AvGeKU8V
         xy37pL/wsKXwPuR5nrPqkJ6Mk9L44yXr9udTMRqIhyjnahnCSjc201e9l39lcUTHBYHe
         c956rIlfUOjrQt2WCEwqjBo0Idb6LIicrbdkm/VDT8IscKbOUwEYQqc6HGE8yMaqu8nq
         Vwhg==
X-Gm-Message-State: AOAM531LffXvt+dZDi5neg9H6TMUWcIx55ks6rgTee96mv5+5KkbShP8
        7mxCSDjqlIZUbJvCouIz7/NBVlHQ2PoI5ZVRgzQT2fkaojY3NQ3aVrWgQRnlMAIGgx4yGg7vitS
        ww5qxJhrA+8DqrUuiuuVcsFG72QbY6ZGx1te/Urq9pPwF0lCyn46QrJQFTyLA3ImIAyNUWALEY8
        l7fik=
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr6916209wmg.47.1632438753140;
        Thu, 23 Sep 2021 16:12:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx71Go+1FmAtKjPLtff7hAL+ZVdAW+AqHTpXhtonLCYYI4htn+ZHgEOjSrNurNbZGKXqygv7g==
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr6916185wmg.47.1632438752858;
        Thu, 23 Sep 2021 16:12:32 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id s14sm6576527wrp.84.2021.09.23.16.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 16:12:32 -0700 (PDT)
Subject: Re: [PATCH] tpm_tis_spi: Add missing SPI ID
To:     Mark Brown <broonie@kernel.org>,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org
References: <20210923181520.8680-1-broonie@kernel.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <8e0da67c-e211-8c5b-5533-3ce359719ba7@redhat.com>
Date:   Fri, 24 Sep 2021 01:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210923181520.8680-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mark,

I agree with your patch but the commit message is not completely accurate.

On 9/23/21 8:15 PM, Mark Brown wrote:
> In commit c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
> we added SPI IDs for all the DT aliases to handle the fact that we always
> use SPI modaliases to load modules even when probed via DT however this
> added an alias for the non-idiomatic tpm_tis-spi compatible as tpm_tis_spi

The "tpm_tis_spi" entry was not introduced by the mentioned commit but it
has been in the driver since commit 0edbfea537d ("tpm/tpm_tis_spi: Add
support for spi phy").

What was missed in commit c46ed2281bbe was that the entries in the OF and
SPI tables didn't match and were different. So maybe the following instead:

"... however the mentioned commit missed that the SPI and OF device ID
entries did not match and were different and so DT nodes with compatible
"tcg,tpm_tis-spi" will not match".

> which doesn't actually match. Add an extra ID for tpm_tis-spi rather than
> just fix the existing one since what's currently there is going to be
> better for anyone actually using SPI IDs to instantiate.
> 
> Fixes: c46ed2281bbe ("tpm_tis_spi: add missing SPI device ID entries")
> Fixes: 96c8395e2166 ("spi: Revert modalias changes")

Oh, I missed that the SPI core was modified to report OF modalias uevents
at some point. Yes, that won't work unless all the SPI drivers are fixed.

Anyway, for the change itself:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

