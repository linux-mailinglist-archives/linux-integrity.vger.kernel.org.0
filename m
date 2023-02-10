Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0088C692504
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjBJSHF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 13:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjBJSHF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 13:07:05 -0500
Received: from mail-pj1-x1064.google.com (mail-pj1-x1064.google.com [IPv6:2607:f8b0:4864:20::1064])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB37CC83
        for <linux-integrity@vger.kernel.org>; Fri, 10 Feb 2023 10:07:04 -0800 (PST)
Received: by mail-pj1-x1064.google.com with SMTP id pj3so5990798pjb.1
        for <linux-integrity@vger.kernel.org>; Fri, 10 Feb 2023 10:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:date:message-id:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jwk0i+taCoZmO5hqTQwks2ZG+Yy0hvRchzSakw9yBgY=;
        b=jf43g6Ds5gRU4Mpfu3YzePTTZzlSwiY1rkMRlmSa5mUUzUt7kWLHi+7PaIrcer3Gft
         qevAy0xFCvPzDXKd4o3zv7f72w6r/rIJCGglWFuxkNawSCPiuWE0wd/KAVooH1oOe5b1
         aw7s3W6ZYK+83MAUCIrgV56W8K4p8NzSWawVLVLUhWdxTegab/KQe7Nd++j6MNQfGpDa
         8zher3ndkYasRVuU54qI8IIWGFjQjk6KSFLn+kWNKEzud0Fdwf1dO9UruLuCzrKGEgoj
         qVlvdIaSZUgdSOKagJSjiyeP23hFI+muoxRIYPEiXbo1xJkPs1llzKiV8+QD0mn8Fkgh
         JKaQ==
X-Gm-Message-State: AO0yUKUOMW5p8dG6tMOv8jznnm1XF87yDIcUytoDx1Go7XanPLNHvba/
        7ra/fT5EQ9zMTTeq6aUPLjqPgSzLu89cchu0oUzuOS+umeGb
X-Google-Smtp-Source: AK7set8cose0trt9MNoZfoMLGULHwP5M+SwqmhBXnbjaCwSsuEajTvX9YAOH1Ehxxbh1O3YTnSFlDJru5y2f
X-Received: by 2002:a17:903:2291:b0:199:1458:6c68 with SMTP id b17-20020a170903229100b0019914586c68mr17817382plh.57.1676052423456;
        Fri, 10 Feb 2023 10:07:03 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id a3-20020a170902ecc300b0018930cd8f91sm268584plh.144.2023.02.10.10.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2023 10:07:03 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from [10.95.72.106] (unknown [10.95.72.106])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 89E7D416E40;
        Fri, 10 Feb 2023 10:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1676052422;
        bh=Jwk0i+taCoZmO5hqTQwks2ZG+Yy0hvRchzSakw9yBgY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GcRY66c7HyZXSFGqGuaiXexyp2Spvq7gWF5Pdg3lknPD2or1tcjy4ziHkQNh523DV
         8LcRJWN0sjj1iYLOA/+hpbXJsVOGGhNkWT9SOeKinvdVkzVpf7bgiEOFJuMbAdq1vj
         ApOQ4G04xI2a3AFTAlDzfaulOUsmN+Ou/4qz/+qxkRXTiqZhzKgke+HUN+wmxLjX/Z
         19FoZb46yqPOxICIoOFBa8yXOfQBpAouiRr4J0y3FDmeuPnkVIeGcXTOGD3XvUKCoQ
         Y7nEKLhN1MIJJpumw7n3Rox/sH5IwsG2PE4fohfLF80l7gd8KXTAKgnuucZmPv4KMT
         A6X1feWq8Zq3w==
Message-ID: <865dfe9e-ee3d-1067-625e-2d93bf96da4b@arista.com>
Date:   Fri, 10 Feb 2023 10:07:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tpm: add vendor flag to command code validation
Content-Language: en-CA
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
References: <20230208195836.30175-1-julien@arista.com>
 <Y+WUqcNTc8t0KIyD@kernel.org>
From:   Julien Gomes <julien@arista.com>
In-Reply-To: <Y+WUqcNTc8t0KIyD@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2023-02-09 4:49 p.m., Jarkko Sakkinen wrote:
> On Wed, Feb 08, 2023 at 11:58:36AM -0800, Julien Gomes wrote:
>> Some TPM 2.0 devices have support for additional commands which are not
>> part of the TPM 2.0 specifications.
>> These commands are identified with bit 29 of the 32 bits command codes.
>> Contrarily to other fields of the TPMA_CC spec structure used to list
>> available commands, the Vendor flag also has to be present in the
>> command code itself (TPM_CC) when called.
>>
>> Add this flag to tpm_find_cc() mask to prevent blocking vendor command
>> codes that can actually be supported by the underlying TPM device.
>>
>> Signed-off-by: Julien Gomes <julien@arista.com>
>> ---
>>   drivers/char/tpm/tpm2-cmd.c | 4 +++-
>>   include/linux/tpm.h         | 1 +
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
>> index 65d03867e114..93545be190a5 100644
>> --- a/drivers/char/tpm/tpm2-cmd.c
>> +++ b/drivers/char/tpm/tpm2-cmd.c
>> @@ -777,10 +777,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>>   
>>   int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
>>   {
>> +	u32 cc_mask;
>>   	int i;
>>   
>> +	cc_mask = 1 << TPM2_CC_ATTR_VENDOR | GENMASK(15, 0);
>>   	for (i = 0; i < chip->nr_commands; i++)
>> -		if (cc == (chip->cc_attrs_tbl[i] & GENMASK(15, 0)))
>> +		if (cc == (chip->cc_attrs_tbl[i] & cc_mask))
>>   			return i;
>>   
>>   	return -1;
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index dfeb25a0362d..4dc97b9f65fb 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -265,6 +265,7 @@ enum tpm2_startup_types {
>>   enum tpm2_cc_attrs {
>>   	TPM2_CC_ATTR_CHANDLES	= 25,
>>   	TPM2_CC_ATTR_RHANDLE	= 28,
>> +	TPM2_CC_ATTR_VENDOR	= 29,
>>   };
>>   
>>   #define TPM_VID_INTEL    0x8086
>> -- 
>> 2.39.1
>>
> 
> Just checking: did you run testing/selftests/tpm2?
> 
> BR, Jarkko

I didn't know about these, good call.
Just ran the three test suites on a vm with a swtpm, as I don't have a
physical box with TPM 2.0 able to run latest kernels handy, all passed.

-- 
Julien Gomes

