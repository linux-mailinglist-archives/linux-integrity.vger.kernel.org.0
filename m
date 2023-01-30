Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39D6805DB
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jan 2023 07:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjA3GHH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 01:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3GHE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 01:07:04 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B74916338;
        Sun, 29 Jan 2023 22:07:02 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4P4yM56SQQzRr4V;
        Mon, 30 Jan 2023 14:04:49 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 14:06:59 +0800
Message-ID: <c95487db-f304-2610-5e93-41d7b39934d7@huawei.com>
Date:   Mon, 30 Jan 2023 12:02:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] evm: call dump_security_xattr() in all cases to
 remove code duplication
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230129004637.191106-1-xiujianfeng@huawei.com>
 <a7f1324e88023a86c3489d53268bde17069ece1f.camel@linux.ibm.com>
Content-Language: en-US
From:   xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <a7f1324e88023a86c3489d53268bde17069ece1f.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 2023/1/30 0:15, Mimi Zohar wrote:
>> @@ -254,15 +264,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>>  			if (is_ima)
>>  				ima_present = true;
>>  
>> -			if (req_xattr_value_len < 64)
>> -				pr_debug("%s: (%zu) [%*phN]\n", req_xattr_name,
>> -					 req_xattr_value_len,
>> -					 (int)req_xattr_value_len,
>> -					 req_xattr_value);
>> -			else
>> -				dump_security_xattr(req_xattr_name,
>> -						    req_xattr_value,
>> -						    req_xattr_value_len);
>> +			dump_security_xattr(req_xattr_name,
>> +					    req_xattr_value,
>> +					    req_xattr_value_len);
>>  			continue;
>>  		}
>>  		size = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
> 
> Hm, this patch doesn't apply properly.

I noticed that the patch fails to apply on linux master, however this
patch is meant for linux-next, would you please maybe have a look?

> 
> Mimi>
> 
