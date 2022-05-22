Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A65301DA
	for <lists+linux-integrity@lfdr.de>; Sun, 22 May 2022 10:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiEVIaR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 May 2022 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiEVIaQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 May 2022 04:30:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49E3BF8D
        for <linux-integrity@vger.kernel.org>; Sun, 22 May 2022 01:30:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u7so13238947ljd.11
        for <linux-integrity@vger.kernel.org>; Sun, 22 May 2022 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XqWzQpy3oPnX1lfphyq4b5xThmFgDWnY8w8vH3221Eg=;
        b=sohKLdGi5rNl57zueyhzR9jMzFV1Ae2ZzGcMZDIU06VcgWnlrjUyM7X6QXD4nEh87a
         TtxztpWVlrAPKemqDZ0ZjkrKz+XhumZZRiRs21D6GllcYuJuNyNwgMw8mFUCE+roFvgp
         5x8NBw7MHtCZhIvBV2Jc/HdN0+7Z7eB+cyDrlIchCvn/lCGJraiU4A2XyfCfcbvxw/DJ
         R0zf/ppSPfQc6RFD1+kFK2RQHlmbK+BZE1PrStTteFpH2ui0upD4lwyb21JK7SUKanrC
         dxTnuNOzhaEC1czCe4Gu2ZyxA8JEKLKl0Kgkqxy8SY7/+Gq97RlR7imlUPPwsE8xxW2e
         u+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XqWzQpy3oPnX1lfphyq4b5xThmFgDWnY8w8vH3221Eg=;
        b=jdmdNbmmXiWJpU9JeIoLe/EXN8tvcPY3EfuYvGiGRAWAysi0kH0AAecFE1TX5B3MHR
         HRaGezVs66uiWmb8bZuxRdFkEXxP8ImMl7Xt7qJS8JVZWJQjBEGGo7M29xK3tGPlNfSZ
         UNE6e66VyWPIftTiX0Jizp6Pka5jj5vSifY/5+iHvyDHlxKpu+GObqccCs8iI2P2NEF1
         o1JaiYvxauB02Q/2MKVztglr12nxEtsvkdvc23/C1EvHzv3E9fMe6rLhBNTSmaFBWe2p
         xpxC3+93tL2jZvpz77NPcizpBgDudpyvx75yGWTWPDGqRBsViMTMJYm860sZdIFuu3AD
         dlkg==
X-Gm-Message-State: AOAM530GrMR1rxfCH4GpnBFat8osZejtXn57H4A9E8FzXHqkkL5XvYrc
        3mM9lzBqH50lTWQmDDgsYjKc/Q==
X-Google-Smtp-Source: ABdhPJyUHHgTlviw7qP3mGx9nBdHLSO/sotDdyEvnur7XEEu0EmriTrNpkvKL8TcRtQhHJvAUF3QpA==
X-Received: by 2002:a2e:894e:0:b0:253:e480:1fff with SMTP id b14-20020a2e894e000000b00253e4801fffmr2986699ljk.245.1653208213554;
        Sun, 22 May 2022 01:30:13 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a11-20020a2e980b000000b00253df2d526asm969093ljj.77.2022.05.22.01.30.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 01:30:13 -0700 (PDT)
Message-ID: <02596f22-3d19-8872-75fd-2a8f563c8270@linaro.org>
Date:   Sun, 22 May 2022 10:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/2] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Content-Language: en-US
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220520172422.4309-1-Alexander.Steffen@infineon.com>
 <20220520172422.4309-2-Alexander.Steffen@infineon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520172422.4309-2-Alexander.Steffen@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 20/05/2022 19:24, Alexander Steffen wrote:
>
> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_tis_i2c_match[] = {
> +	{ .compatible = "infineon,slb9673", },
> +	{ .compatible = "tcg,tpm_tis-i2c", },

Please run checkpatch on your patches. You add undocumented compatibles.

Without bindings, new compatibles and properties cannot be accepted, so NAK.

Best regards,
Krzysztof
