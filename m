Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE015348BB
	for <lists+linux-integrity@lfdr.de>; Thu, 26 May 2022 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbiEZCQj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 May 2022 22:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiEZCQh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 May 2022 22:16:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535EB1ADA3;
        Wed, 25 May 2022 19:16:35 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L7s3n3SNVzjX2m;
        Thu, 26 May 2022 10:15:49 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 26 May 2022 10:16:33 +0800
Message-ID: <495a214a-5d80-d64d-90ab-986fdb143cb6@huawei.com>
Date:   Thu, 26 May 2022 10:16:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] keys: Use struct_size and size_add helper with alloc
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <dhowells@redhat.com>,
        <keyrings@vger.kernel.org>, <gustavoars@kernel.org>
References: <20220525012617.6915-1-guozihua@huawei.com>
 <1bfdca4f564eb812d86eb2f3f2b191aee171cdbd.camel@kernel.org>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <1bfdca4f564eb812d86eb2f3f2b191aee171cdbd.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/5/26 9:06, Jarkko Sakkinen wrote:
> On Wed, 2022-05-25 at 09:26 +0800, GUO Zihua wrote:
>> Use struct_size helper for calculating size of flexible struct, following
>> the best practice.
>>
>> Note: HASH_SIZE here is a SHA256_DIGEST_SIZE whoes value is 32, so
>                                                 ~~~~~
> 
>> adding 1 should be fine here.
> 
> Where? '1' is without a context. I don't really know how to interpret
> this sentence.

Hi Jarkko,

The original code computes the size for kzalloc with open-coded 
HASH_SIZE + 1. Although the best practice for size computation suggest 
that we should be using size_add(). I figure it's a bit redundant here 
as the purpose of size_add() is to avoid size overflow and adding 32 
with 1 will not trigger a size overflow.

Maybe I should just use size_add() anyway? Please lemme know and I'll 
update the patch or the commit message.
> 
>>
>> Link: https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>>
>> ---
>>
>> v3:
>>      Update commit message format according to Jarkko's feedback.
>> v2:
>>      Update the commit message, removing the part about "potential issue"
>>      following Jarkko's suggestion.
>>
>> ---
>>   security/keys/encrypted-keys/encrypted.c | 7 +++++--
>>   security/keys/user_defined.c             | 2 +-
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
>> index e05cfc2e49ae..37349580e855 100644
>> --- a/security/keys/encrypted-keys/encrypted.c
>> +++ b/security/keys/encrypted-keys/encrypted.c
>> @@ -613,6 +613,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>          long dlen;
>>          int i;
>>          int ret;
>> +       size_t epayload_datalen = 0;
>>   
>>          ret = kstrtol(datalen, 10, &dlen);
>>          if (ret < 0 || dlen < MIN_DATA_SIZE || dlen > MAX_DATA_SIZE)
>> @@ -667,8 +668,10 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>          if (ret < 0)
>>                  return ERR_PTR(ret);
>>   
>> -       epayload = kzalloc(sizeof(*epayload) + payload_datalen +
>> -                          datablob_len + HASH_SIZE + 1, GFP_KERNEL);
>> +       epayload_datalen = size_add(payload_datalen, datablob_len);
>> +       epayload_datalen = size_add(epayload_datalen, HASH_SIZE + 1);

BTW, the "here" is here.

>> +       epayload = kzalloc(struct_size(epayload, payload_data,
>> +                               epayload_datalen), GFP_KERNEL);
>>          if (!epayload)
>>                  return ERR_PTR(-ENOMEM);
>>   
>> diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
>> index 749e2a4dcb13..334fed36e9f3 100644
>> --- a/security/keys/user_defined.c
>> +++ b/security/keys/user_defined.c
>> @@ -64,7 +64,7 @@ int user_preparse(struct key_preparsed_payload *prep)
>>          if (datalen <= 0 || datalen > 32767 || !prep->data)
>>                  return -EINVAL;
>>   
>> -       upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
>> +       upayload = kmalloc(struct_size(upayload, data, datalen), GFP_KERNEL);
>>          if (!upayload)
>>                  return -ENOMEM;
>>   
> 
> BR, Jarkko


-- 
Best
GUO Zihua
