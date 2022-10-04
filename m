Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F55F48AB
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJDRix (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJDRiP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 13:38:15 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689E1A390;
        Tue,  4 Oct 2022 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1664905041; x=1696441041;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=bXEBroaWZPTfxlT+pHcVM2wJfQxT4dO2wrZZGruUUeU=;
  b=benAiZO2s/e1AEdlZIe5E8nJ8RJhhRhxrooi29efttFLxS7+U6it+a+e
   GbD8aNVwjOQgKEEG0J0doQJUogU2yyBpmlEo/bnQLFfBjhjQ3abgN+7A+
   YPStb4UDxhxubsdqHsirpr5JRYQ9vYpQqstjcabmBhp7dTCxjh8JPjhNC
   A=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="3046270"
X-IronPort-AV: E=Sophos;i="5.95,158,1661810400"; 
   d="scan'208";a="3046270"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 19:37:17 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Tue,  4 Oct 2022 19:37:16 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:37:16 +0200
Received: from [10.165.68.85] (10.165.68.85) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 19:37:16 +0200
Message-ID: <afc6b006-63b8-344d-ba2d-1070ddb464cd@infineon.com>
Date:   Tue, 4 Oct 2022 19:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH 2/7] dt-bindings: tpm: Improve documentation of
 compatibles
To:     Rob Herring <robh@kernel.org>
CC:     <benoit.houyere@st.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <amirmizi6@gmail.com>,
        <jarkko@kernel.org>, <peter@pjd.dev>,
        <Johannes.Holland@infineon.com>, <linux-integrity@vger.kernel.org>
References: <20220930165116.13329-1-Alexander.Steffen@infineon.com>
 <20220930165116.13329-3-Alexander.Steffen@infineon.com>
 <166457528569.1113018.4558441482039920312.robh@kernel.org>
Content-Language: en-US
In-Reply-To: <166457528569.1113018.4558441482039920312.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.165.68.85]
X-ClientProxiedBy: MUCSE820.infineon.com (172.23.29.46) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 01.10.22 00:05, Rob Herring wrote:
> On Fri, 30 Sep 2022 18:51:11 +0200, Alexander Steffen wrote:
>> Add missing information:
>> * Device name, for discoverability
>> * Interface, to distinguish otherwise similar devices
>> * TPM version, so that outdated devices can be deprecated in the future
>>
>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>> ---
>>   .../bindings/security/tpm/trivial-tpms.yaml        | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/
> 
> 
> tpm@20: 'powered-while-suspended' does not match any of the regexes: 'pinctrl-[0-9]+'
>          arch/arm/boot/dts/rk3288-veyron-brain.dtb
>          arch/arm/boot/dts/rk3288-veyron-fievel.dtb
>          arch/arm/boot/dts/rk3288-veyron-jaq.dtb
>          arch/arm/boot/dts/rk3288-veyron-jerry.dtb
>          arch/arm/boot/dts/rk3288-veyron-mickey.dtb
>          arch/arm/boot/dts/rk3288-veyron-mighty.dtb
>          arch/arm/boot/dts/rk3288-veyron-minnie.dtb
>          arch/arm/boot/dts/rk3288-veyron-pinky.dtb
>          arch/arm/boot/dts/rk3288-veyron-speedy.dtb
>          arch/arm/boot/dts/rk3288-veyron-tiger.dtb
>          arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dtb
>          arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtb
>          arch/arm64/boot/dts/mediatek/mt8173-elm.dtb
>          arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dtb

This is fixed by PATCH 3/7. Not sure it is worth changing the order, 
since the intention of the first two patches was just to convert the 
existing data, without making any functional changes.
