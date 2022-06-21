Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646F8553052
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jun 2022 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbiFUK6z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 06:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiFUK6x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 06:58:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82242981D;
        Tue, 21 Jun 2022 03:58:51 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LS3ML2BchzSh03;
        Tue, 21 Jun 2022 18:55:26 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 18:58:49 +0800
Subject: Re: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220606101042.89638-1-xiujianfeng@huawei.com>
 <64511312-df94-c40b-689c-5fc3823e91f5@pengutronix.de>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <812c4ee9-56f7-900a-df48-f3ca3e15542f@huawei.com>
Date:   Tue, 21 Jun 2022 18:58:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <64511312-df94-c40b-689c-5fc3823e91f5@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, Ahmad

在 2022/6/7 14:06, Ahmad Fatoum 写道:
> On 06.06.22 12:10, Xiu Jianfeng wrote:
>> Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
>> initialize .enabled, minor simplicity improvement.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
thank you for the review, and I'm not sure if this patch has been 
picked, so frendly ping here...
>> ---
>>   security/integrity/evm/evm_main.c | 52 ++++++++++++++-----------------
>>   1 file changed, 23 insertions(+), 29 deletions(-)
>>
>> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
>> index cc88f02c7562..397fea5b3fa6 100644
>> --- a/security/integrity/evm/evm_main.c
>> +++ b/security/integrity/evm/evm_main.c
>> @@ -36,42 +36,36 @@ static const char * const integrity_status_msg[] = {
>>   int evm_hmac_attrs;
>>   
>>   static struct xattr_list evm_config_default_xattrnames[] = {
>> -	{.name = XATTR_NAME_SELINUX,
>> -#ifdef CONFIG_SECURITY_SELINUX
>> -	 .enabled = true
>> -#endif
>> +	{
>> +	 .name = XATTR_NAME_SELINUX,
>> +	 .enabled = IS_ENABLED(CONFIG_SECURITY_SELINUX)
>>   	},
>> -	{.name = XATTR_NAME_SMACK,
>> -#ifdef CONFIG_SECURITY_SMACK
>> -	 .enabled = true
>> -#endif
>> +	{
>> +	 .name = XATTR_NAME_SMACK,
>> +	 .enabled = IS_ENABLED(CONFIG_SECURITY_SMACK)
>>   	},
>> -	{.name = XATTR_NAME_SMACKEXEC,
>> -#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
>> -	 .enabled = true
>> -#endif
>> +	{
>> +	 .name = XATTR_NAME_SMACKEXEC,
>> +	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
>>   	},
>> -	{.name = XATTR_NAME_SMACKTRANSMUTE,
>> -#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
>> -	 .enabled = true
>> -#endif
>> +	{
>> +	 .name = XATTR_NAME_SMACKTRANSMUTE,
>> +	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
>>   	},
>> -	{.name = XATTR_NAME_SMACKMMAP,
>> -#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
>> -	 .enabled = true
>> -#endif
>> +	{
>> +	 .name = XATTR_NAME_SMACKMMAP,
>> +	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
>>   	},
>> -	{.name = XATTR_NAME_APPARMOR,
>> -#ifdef CONFIG_SECURITY_APPARMOR
>> -	 .enabled = true
>> -#endif
>> +	{
>> +	 .name = XATTR_NAME_APPARMOR,
>> +	 .enabled = IS_ENABLED(CONFIG_SECURITY_APPARMOR)
>>   	},
>> -	{.name = XATTR_NAME_IMA,
>> -#ifdef CONFIG_IMA_APPRAISE
>> -	 .enabled = true
>> -#endif
>> +	{
>> +	 .name = XATTR_NAME_IMA,
>> +	 .enabled = IS_ENABLED(CONFIG_IMA_APPRAISE)
>>   	},
>> -	{.name = XATTR_NAME_CAPS,
>> +	{
>> +	 .name = XATTR_NAME_CAPS,
>>   	 .enabled = true
>>   	},
>>   };
>
