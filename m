Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32766B64BB
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Mar 2023 11:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCLKHP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Mar 2023 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLKHO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Mar 2023 06:07:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97D710EA
        for <linux-integrity@vger.kernel.org>; Sun, 12 Mar 2023 03:06:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id j11so37584605edq.4
        for <linux-integrity@vger.kernel.org>; Sun, 12 Mar 2023 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678615616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIXcdYNaCDOkRTJEblUpy7cNQB2/TaT4XzKrLIM1vjM=;
        b=FUdaDkwkeVr13g9fJhnoLKmuLefogi57PyvzuN675lONvNfs3rnv93g+mzVIkzo/AX
         bpu8zop/fSBk8fwSHmFgjmqvVFdt5+SeGvNM0X+ntFoIGznl1TG9HaMHHHNE2k3Lls5s
         TpDyXeTk9KsbsR8MAvIdfMUFpvaCRIH+xc+G4qxdGaIqy74QIiD0jfPzQdEaZj2/9mov
         QxbhU8m4utL5tT9QHFnq+WTM7soBbO7TfAzWMJnuiCPgM61i8TvYNYBSRzdK0Ccbgfuu
         PQBA+Ln6TQ3J3PPBGaTXBR0BWwSyn2YP1k5F5kAFHbiMCvSCh+HUb8xWlq+u12AouycM
         cwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678615616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIXcdYNaCDOkRTJEblUpy7cNQB2/TaT4XzKrLIM1vjM=;
        b=x0N06V2QjZwq0QYyU2o3OCp91NQ5mnxcsUDvSv04s2B5ISP++Cn33NJrpSvNgbc+iR
         L8cV7Q1nFi6Phr7fQXfEKzPdfRa4KEwNnIKS7dUgWGIGOTpbKy3602cSsDPP22fS/Pwz
         pJ74m4srlmt8w7vF7zL7H7TFIKyNTzdNKlGFpXHH9q+mltkAh80eW2YwQENCGfAGxRMY
         oHOgm/HmbGJPs8Vr24o8EuKg6zTDekoLOQ/efZtmznbtXf2AcIlVT8ww82LSUHDkDvyj
         IqRZfHUlMMqN0YRtumWTULcWLXLLSic/yPHnzACEHKyCTLXQ0YvqbGykTJfQZDNutzZd
         2AeA==
X-Gm-Message-State: AO0yUKVDAiDsPmJfLMM+yJqntBwUx67ci4sXjgalyKsybmElA4RLjK69
        E7SamMJ8nqoXG5bXFYDvLl6phQ==
X-Google-Smtp-Source: AK7set9SbILJkYNUKlnfS+9hZ9ynZ54V3vAx321wPqoJbUR24PDItyBQNOpXsExc13tTvqX5t9mn4Q==
X-Received: by 2002:a17:907:8691:b0:8b1:3009:536b with SMTP id qa17-20020a170907869100b008b13009536bmr38192343ejc.29.1678615616350;
        Sun, 12 Mar 2023 03:06:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id a30-20020a509ea1000000b004aef147add6sm2025086edf.47.2023.03.12.03.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:06:55 -0700 (PDT)
Message-ID: <9c2e8cba-0720-d7ed-a765-afbc0d0b1578@linaro.org>
Date:   Sun, 12 Mar 2023 11:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] tpm: tpm_tis_spi: Mark ACPI and OF related data as
 maybe unused
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
 <20230311173541.262949-2-krzysztof.kozlowski@linaro.org>
 <ZA0wor67TlOdBOs/@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZA0wor67TlOdBOs/@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/03/2023 02:53, Jarkko Sakkinen wrote:
> On Sat, Mar 11, 2023 at 06:35:41PM +0100, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
>> unused:
>>
>>   drivers/char/tpm/tpm_tis_spi_main.c:234:34: error: ‘of_tis_spi_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/char/tpm/tpm_tis_spi_main.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
>> index a0963a3e92bd..1f5207974a17 100644
>> --- a/drivers/char/tpm/tpm_tis_spi_main.c
>> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
>> @@ -231,7 +231,7 @@ static const struct spi_device_id tpm_tis_spi_id[] = {
>>  };
>>  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
>>  
>> -static const struct of_device_id of_tis_spi_match[] = {
>> +static const struct of_device_id of_tis_spi_match[] __maybe_unused = {
>>  	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
>>  	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
>>  	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
>> @@ -240,7 +240,7 @@ static const struct of_device_id of_tis_spi_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, of_tis_spi_match);
>>  
>> -static const struct acpi_device_id acpi_tis_spi_match[] = {
>> +static const struct acpi_device_id acpi_tis_spi_match[] __maybe_unused = {
>>  	{"SMO0768", 0},
>>  	{}
>>  };
>> -- 
>> 2.34.1
>>
> 
> Ditto.

This commit msg was not cut, so what do you want to describe here? It's
obvious and there is no single point to repeat code in commit msg. What
the commit does is easily visible from the diff.

Best regards,
Krzysztof

