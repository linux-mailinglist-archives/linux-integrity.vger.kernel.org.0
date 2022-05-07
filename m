Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3956D51E85D
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 18:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiEGQE7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446629AbiEGQE6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 12:04:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4818113E1A
        for <linux-integrity@vger.kernel.org>; Sat,  7 May 2022 09:01:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so19457237ejj.10
        for <linux-integrity@vger.kernel.org>; Sat, 07 May 2022 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EEjFelFS20jkO4Qj4ob7I4X5U5OVEQ8vF/HCYLVafkA=;
        b=TJ/UCa7zjhsvY8f1+l2nJ4qtsnLHQST0Rhd1k4UuUt6txkhhcxyeL6cl1O7/3fzIlw
         Id6IVxyu6KQLzqBbUiRuNytkbovehemPKUuGguWKer+3FnSkIvwkuWpS+90eOFxADc5l
         p+TGGxzuyqZamj3prMfE3PPeG1BgnRSJmhXgo5w2UXAt8srzKqE79PmMD0jkVVjawfHj
         NfMbk/l2ypH2YwaNRX0VwfBrqZceAg4lScENlpY31Vi+utYuNpbUqYl7PXinQgu+Frws
         IrG8BIA8dvoO0Y/WLGYQG+yU2UXTzFHrdGUmzMSgKaZAvgKXT80O3bEcygRlv1LJ3BAo
         ipiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EEjFelFS20jkO4Qj4ob7I4X5U5OVEQ8vF/HCYLVafkA=;
        b=zjKN2VaIpVarg7elCViS7b1Xj1TxsNtDa/ikuD5A+VaTeZHY62b8k312pjNxtOFCF7
         M8tAP8ByqWUkb86do7uB0k0WGgSw/DTTzA35lx0JcC6v3MwjpuESpHA4iIXh7hkE3ux9
         72YqR+gM3jdeI4Pt56sWiRGdKurG246BIxT/XBxjVoVemewIyI56c3Wu4OmO8Uu0z5A1
         3Lyl+U/3VWepyioEmY4qJpdAlBRzWaASMXpWWcsRfsZ2wJKmoYV+DLCYVjun4txdEToh
         sU8Y+HNzPUPTBiEO/pp1G+C+igts0zR++vPx0Xom9E0BzzBt/K3HmOOmLWiS1gRN/zVM
         q8nw==
X-Gm-Message-State: AOAM530ZBIROP2IpgQ6IJjr37Uf1zFREMYmqmcClIlt1U2dzG1EC8ADs
        RZsW/3q6bwgCoHtJ5iasq351YQ==
X-Google-Smtp-Source: ABdhPJwtRto5hiYLsR+QHrgUUplzWtci9HQS6vAJ/b/CgrVBQsAbJfaavkt/qpAOhe/i1WEHNnh4yA==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr7664191ejc.712.1651939269690;
        Sat, 07 May 2022 09:01:09 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906d11a00b006f3ef214dedsm3094167ejz.83.2022.05.07.09.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 09:01:09 -0700 (PDT)
Message-ID: <7588a043-19b0-f7c6-0f47-7024e2fb1a56@linaro.org>
Date:   Sat, 7 May 2022 18:01:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/4] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Content-Language: en-US
To:     Johannes Holland <johannes.holland@infineon.com>,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Alexander Steffen <alexander.steffen@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220506170013.22598-1-johannes.holland@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220506170013.22598-1-johannes.holland@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 06/05/2022 19:00, Johannes Holland wrote:
> Implement the TCG I2C Interface driver, as specified in the TCG PC
> Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
> revision 14, section 8, I2C Interface Definition.
> 

> +static const struct i2c_device_id tpm_tis_i2c_id[] = {
> +	{ "tpm_tis_i2c", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> +
> +static const struct of_device_id of_tis_i2c_match[] = {
> +	{ .compatible = "infineon,slb9673", },
> +	{ .compatible = "tcg,tpm-tis-i2c", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> +
> +static struct i2c_driver tpm_tis_i2c_driver = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "tpm_tis_i2c",
> +		.pm = &tpm_tis_pm,
> +		.of_match_table = of_match_ptr(of_tis_i2c_match),

of_match_ptr does not match your of_device_id table - you will have
warnings. Either mark them maybe_unused or skip of_match_ptr.


Best regards,
Krzysztof
