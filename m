Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516D731335
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jun 2023 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbjFOJIu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jun 2023 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245385AbjFOJIp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jun 2023 05:08:45 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82741FE8;
        Thu, 15 Jun 2023 02:08:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vl9wwvH_1686820112;
Received: from 30.240.108.67(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Vl9wwvH_1686820112)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 17:08:34 +0800
Message-ID: <66c72938-912c-5167-fdb1-bffefe1db0c9@linux.alibaba.com>
Date:   Thu, 15 Jun 2023 17:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] integrity: Fix possible multiple allocation in
 integrity_inode_get()
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230530121453.10249-1-tianjia.zhang@linux.alibaba.com>
 <20230601064244.33633-1-tianjia.zhang@linux.alibaba.com>
 <CT86SNGF201H.2UZF8SN2MEKZ6@suppilovahvero>
Content-Language: en-US
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CT86SNGF201H.2UZF8SN2MEKZ6@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On 6/9/23 10:24 PM, Jarkko Sakkinen wrote:
> On Thu Jun 1, 2023 at 9:42 AM EEST, Tianjia Zhang wrote:
>> When integrity_inode_get() is querying and inserting the cache, there
>> is a conditional race in the concurrent environment.
>>
>> The race condition is the result of not properly implementing
>> "double-checked locking". In this case, it first checks to see if the
>> iint cache record exists before taking the lock, but doesn't check
>> again after taking the integrity_iint_lock.
>>
>> Fixes: bf2276d10ce5 ("ima: allocating iint improvements")
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
>> Cc: <stable@vger.kernel.org> # v3.10+
> 
> s/v3.10/v4.14/
> 
> I.e. cover only currently maintained longterms, right?
> 

Yes, the race condition was indeed introduced in 3.10, but the fix is
estimated to only cover the LTS version.

> 
>> ---
>>   security/integrity/iint.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
>> index c73858e8c6d5..a462df827de2 100644
>> --- a/security/integrity/iint.c
>> +++ b/security/integrity/iint.c
>> @@ -43,12 +43,10 @@ static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
>>   		else if (inode > iint->inode)
>>   			n = n->rb_right;
>>   		else
>> -			break;
>> +			return iint;
>>   	}
>> -	if (!n)
>> -		return NULL;
>>   
>> -	return iint;
>> +	return NULL;
>>   }
>>   
>>   /*
>> @@ -113,10 +111,15 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>>   		parent = *p;
>>   		test_iint = rb_entry(parent, struct integrity_iint_cache,
>>   				     rb_node);
>> -		if (inode < test_iint->inode)
>> +		if (inode < test_iint->inode) {
>>   			p = &(*p)->rb_left;
>> -		else
>> +		} else if (inode > test_iint->inode) {
>>   			p = &(*p)->rb_right;
>> +		} else {
>> +			write_unlock(&integrity_iint_lock);
>> +			kmem_cache_free(iint_cache, iint);
>> +			return test_iint;
>> +		}
>>   	}
>>   
>>   	iint->inode = inode;
>> -- 
>> 2.24.3 (Apple Git-128)
> 
> Mimi, are you picking this?

Mimi has picked this patch in next-integrity.

> 
> Off-topic: how do you compile kernel on macOS, you're using VM right?
> I'm just interested because I recently bought Mac mini for both
> compiling and testing arm64. Optimal would be to be able to compile
> the kernel on bare metal and then deploy to a VM...
> 

I am currently only coding and sending the final patch on a Mac.
Compilation and testing are still carried out in the linux environment.
If you have experience in launching a linux VM on macOS, please share it
with me, thanks.

Best regards,
Tianjia
