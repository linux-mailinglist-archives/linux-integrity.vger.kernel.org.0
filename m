Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CAB530D9F
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbiEWJqW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 05:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiEWJoo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 05:44:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9329211807
        for <linux-integrity@vger.kernel.org>; Mon, 23 May 2022 02:44:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u23so24608076lfc.1
        for <linux-integrity@vger.kernel.org>; Mon, 23 May 2022 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Jr9DBTyCpl+GzbgIiIftgJCFKadRgk6xEv2EUggf+lM=;
        b=Zz+TzdaObs1cHcPhV0HoKPgF+Lt9QJKW/ttKpz8cQMaNK4iZN2MeLKXpvnxsk0jW0U
         +nm7fIIO3W7gvFA6fS9yGRGz9+8RW2iTD8FieVIfPovi5EiAEDY/+guWnUNF3JyiaWc2
         dNpdOtRyCv9rEx47g9SEVxls83cV/b9DKxJTvIVobgQzATDhXqa25fCmP+Wh8E8Wecfx
         qM27C3n4PkuymuZ3t5QjH/B3uyVLti1oNanOMxQGxqBlXmV47H0QGomciRyrOccOjabw
         fZingTxugI7SmVnGKiqqm89mvSNUPJnJw+MmquIHtFmz4tTCX9BF7BmbIIaTWMSLYrRP
         o/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Jr9DBTyCpl+GzbgIiIftgJCFKadRgk6xEv2EUggf+lM=;
        b=hcBef5Gpb0EZOpfFmHHhdbVvxdcgLq6IyD8rB6SGbxqgfmtJhMt9vsJ6RESptKQWA2
         Y4M+rfk9gRyg7+Ke46y2+Tv5I/xGg0kXs0rnJWutJHbSVBPqps+4uxzzVP+R243bw9FN
         f5c2k1B9NwqmiWbv2tPxsVB3qhWkbqVFgoC1g+4OS6CR+D2wzTJagANzkLeeAIy9ZZOT
         UJola8QvHP8B1LYiUXu54oT44qoYa3vQjCKA/0C1bUjB8wSooOPQ/FYG0AzUoFfT/TE5
         ToJhbRkHhkFQMGseejnbHjhyjF/SAGyqTJQ1zcmEAMjXSVXLuiPjSWeIDeMYbTjWz/oD
         cq+g==
X-Gm-Message-State: AOAM533zKX8U13Qe/uadq0v1fVTg7ruDB+SG4JWeYSdSUtf8A3VFW1uc
        vq87uz9pCcGoxRFbXCfAwwpMlw==
X-Google-Smtp-Source: ABdhPJyC+OCnnGdP7t/jBMKBSvHk3d3Qn4wLxLsJYMvh8yH51hANgMTw/GvPFnBypPdZwRayCxNb+A==
X-Received: by 2002:a05:6512:2204:b0:478:68d9:bb45 with SMTP id h4-20020a056512220400b0047868d9bb45mr5056697lfu.453.1653299075948;
        Mon, 23 May 2022 02:44:35 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z9-20020a056512376900b00477c164293csm1881182lft.79.2022.05.23.02.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 02:44:35 -0700 (PDT)
Message-ID: <9d9e04e9-463a-bd43-b116-a9488f6e154e@linaro.org>
Date:   Mon, 23 May 2022 11:44:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        jarkko@kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
References: <20220520172422.4309-1-Alexander.Steffen@infineon.com>
 <20220520172422.4309-2-Alexander.Steffen@infineon.com>
 <02596f22-3d19-8872-75fd-2a8f563c8270@linaro.org>
 <8f0d2098-8c7f-2347-3004-bf3e422de3a3@infineon.com>
 <d4ab965c-d193-3b4b-9b88-95b8b2b40f80@linaro.org>
In-Reply-To: <d4ab965c-d193-3b4b-9b88-95b8b2b40f80@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 23/05/2022 11:32, Krzysztof Kozlowski wrote:
> On 23/05/2022 10:55, Alexander Steffen wrote:
>> On 22.05.22 10:30, Krzysztof Kozlowski wrote:
>>> On 20/05/2022 19:24, Alexander Steffen wrote:
>>>>
>>>> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>>>> +
>>>> +#ifdef CONFIG_OF
>>>> +static const struct of_device_id of_tis_i2c_match[] = {
>>>> +     { .compatible = "infineon,slb9673", },
>>>> +     { .compatible = "tcg,tpm_tis-i2c", },
>>>
>>> Please run checkpatch on your patches. You add undocumented compatibles.
>>
>> Sorry, the old infrastructure I had to do that automatically is not in 
>> place at the moment, so it slipped through.
>>
>>> Without bindings, new compatibles and properties cannot be accepted, so NAK.
>>
>> Could you be more specific as to what the correct solution is here? 
>> Usually, I'd just look at what the existing code does, but that is a 
>> little messy:
>>
>>
>>
>> * socionext,synquacer-tpm-mmio is documented only in 
>> Documentation/devicetree/bindings/trivial-devices.yaml
>>
>> * nuvoton,npct601 is documented in trivial-devices.yaml and is also 
>> mentioned in Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>>
>> * nuvoton,npct650 is only mentioned in tpm-i2c.txt, but appears nowhere 
>> in the code
>>
>> * infineon,tpm_i2c_infineon appears only in tpm_i2c_infineon.c, but is 
>> documented nowhere
>>
>> * tpm_tis_spi_main.c has all its compatibles documented in 
>> tpm_tis_spi.txt, except google,cr50, which is documented in 
>> google,cr50.txt, even though it has the same properties
>>
>> * tpm_tis_i2c_cr50.c uses the exact same google,cr50, even though that 
>> is explicitly documented as a device "on SPI Bus" and lists 
>> spi-max-frequency as one of its required properties, which does not make 
>> any sense for an I2C device
>>
>> * According to the feedback in 
>> https://patchwork.kernel.org/project/linux-integrity/patch/20220404081835.495-4-johannes.holland@infineon.com/#24801807, 
>> the text format, that is currently used everywhere in 
>> Documentation/devicetree/bindings/security/tpm/, is deprecated anyway 
>> and should be replaced by YAML
>>
>>
>>
>> So would you be okay with just adding the compatibles from tpm_tis_i2c.c 
>> to trivial-devices.yaml, so that checkpatch does not complain anymore, 
>> and leave the cleanup of the mess above for later?
> 
> To trivial-devices you should add only bindings really trivial devices,
> which do not have any other properties, even when the bindings are
> finished. This means you entirely fully the hardware and still have only
> reg+compatible.
> 
> If this device fits such case - no other hardware properties than reg -
> then, feel free to document it in trivial-devices. However I am not sure
> that TPM devices are that trivial... For example tpm-i2c.txt defines
> also interrupts and label.
> 
> If the device is not trivial, it should be documented in bindings,
> either dedicated or some existing ones.

It seems I lost few words in my message, so let me write it again, but
maybe closer to English:

To trivial-devices you should add only bindings of really trivial
devices, which do not have any other properties, even when the bindings
are finished. This means you describe fully the hardware and still have
only reg+compatible.

If this device fits such case - no other hardware properties than reg -
then, feel free to document it in trivial-devices. However I am not sure
that TPM devices are that trivial... For example tpm-i2c.txt defines
also interrupts and label.

If the device is not trivial, it should be documented in bindings,
either dedicated or some existing ones.

Best regards,
Krzysztof
