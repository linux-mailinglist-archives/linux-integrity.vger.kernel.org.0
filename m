Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA51551FD4
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jun 2022 17:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbiFTPH3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jun 2022 11:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242643AbiFTPHF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jun 2022 11:07:05 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60125E93;
        Mon, 20 Jun 2022 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1655736313; x=1687272313;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=UZGEgfDdFQPKNBb7uSvz5hHYFgyURg4ZXmrlm9p+W5Q=;
  b=L4Y39zJfcId2X3FaUThF5y88EjNniTsJ9LJMLpFY9sJre5dtAph5uzB4
   zd+MjSUovDmdpZEfz0eFiI5KJZh7p+5I9KlXRFOWhV/s4Mqr6/F1pPfyZ
   SOmeYejueLKxGJQpPh/L0KP0IjvmLuR9UMSnqyzw4OpxzdasGr5G3wPww
   o=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="127205080"
X-IronPort-AV: E=Sophos;i="5.92,207,1650924000"; 
   d="scan'208";a="127205080"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 16:45:11 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 20 Jun 2022 16:45:10 +0200 (CEST)
Received: from MUCSE818.infineon.com (172.23.29.44) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 20 Jun
 2022 16:45:10 +0200
Received: from [10.165.68.86] (10.165.68.86) by MUCSE818.infineon.com
 (172.23.29.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 20 Jun
 2022 16:45:10 +0200
Message-ID: <4832efdf-f2a7-7b0c-4477-088772c962c0@infineon.com>
Date:   Mon, 20 Jun 2022 16:45:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: <stefan.mahnke-hartmann@infineon.com>
Subject: Re: [PATCH] tpm: increase timeout for kselftests
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Johannes Holland <johannes.holland@infineon.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <stefan.mahnke-hartmann@infineon.com>
References: <20220510111607.22984-1-johannes.holland@infineon.com>
 <YnvSwJxOg+IZxrxz@kernel.org>
 <51a14f28-ce94-ade9-6512-a265f7b32dfb@infineon.com>
 <YovniXv6ATJ/vpt6@kernel.org>
From:   Stefan Mahnke-Hartmann <stefan.mahnke-hartmann@infineon.com>
Organization: Infineon Technologies AG
In-Reply-To: <YovniXv6ATJ/vpt6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.165.68.86]
X-ClientProxiedBy: MUCSE807.infineon.com (172.23.29.33) To
 MUCSE818.infineon.com (172.23.29.44)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 23.05.22 21:59, Jarkko Sakkinen wrote:
> On Fri, May 20, 2022 at 03:28:42PM +0200, Stefan Mahnke-Hartmann wrote:
>>
>> On 11.05.22 17:14, Jarkko Sakkinen wrote:
>>> On Tue, May 10, 2022 at 01:16:08PM +0200, Johannes Holland wrote:
>>>> Due to CreatePrimary commands which need to create RSA keys of
>>>> increasing size, the timeout value need to be raised, as well.
>>>> Default is 300s.
>>>>
>>>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
>>>> ---
>>>> A timeout of anything below 600s still lead to occasional timeouts for
>>>> me. Therefore, I propose 600s as a new value. 
>>>>
>>>>  tools/testing/selftests/tpm2/settings | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/tpm2/settings
>>>>
>>>> diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
>>>> new file mode 100644
>>>> index 000000000000..919bc3803f03
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/tpm2/settings
>>>> @@ -0,0 +1,2 @@
>>>> +timeout=600
>>>> +
>>>> -- 
>>>> 2.34.1
>>>>
>>> Could cope but I did not get why it needs to be raised.
>> The TPM2 SpaceTest testsuite currently creates 8 primary RSA 2k keys + 1 for
>> setup. Generating a RSA2k key can take up to ~1-2 minutes on some of our TPMs.
>> => 2x9 = 18 minutes. In the kernel we even define a duration timeout for rsa2k
>> keygen of 5 min per key! (TPM2_DURATION_LONG_LONG = 300000) => up to 45 minutes
>> would be "acceptable".
>>
>> However since the average key generation time is much faster, a value of ~10
>> minutes should be fine enough.
>>
>> The reason why you did not experience this yet on your test system is either
>> because PTT TPMs are faster in that respect and/or some TPMs implement pre-gen
>> mechanisms for key generation, (or just plain luck)
>>
>> BR, Stefan
>>
>>> BR, Jarkko
> I think this is ok.
>
>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko
>
Hi Jarkko,
 
Just curious. I can't see this patch was added to linux-next. Was I
expected to do something more to it?
 
Kind regards
Stefan
