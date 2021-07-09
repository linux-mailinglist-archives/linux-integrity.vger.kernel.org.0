Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC23C2136
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhGIJJV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 05:09:21 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57775 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhGIJJU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 05:09:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UfChLkN_1625821595;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UfChLkN_1625821595)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Jul 2021 17:06:35 +0800
Subject: Re: [PATCH ima-evm-utils v3] ima-evm-utils: Support SM2 algorithm for
 sign and verify
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210526084455.56705-1-tianjia.zhang@linux.alibaba.com>
 <d7526f84-f7c9-cbc6-c4a5-3e8b8d78fb60@linux.alibaba.com>
 <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <bb6afba7-255f-5254-5ac7-e793c24d56d3@linux.alibaba.com>
Date:   Fri, 9 Jul 2021 17:06:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <10f55257f543cc1d63e7a8ae36cbf2433a01c30b.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/7/21 10:28 AM, Mimi Zohar wrote:
> On Fri, 2021-07-02 at 11:18 +0800, Tianjia Zhang wrote:
>> Hi,
>>
>> Any comment?
> 
> Except for a few older distros, Travis complains:
> 
>   openssl dgst  -sm3 sm3-hash.txt
> + evmctl -v  ima_hash --hashalgo sm3 --xattr-user sm3-hash.txt
>    hash(sm3):
> 04111ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
> Did not find expected hash for sm3:
>      user.ima=0x011ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035
> eb5082aa2b
> Actual output below:
>      # file: sm3-hash.txt
>      user.ima=0x04111ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed0
> 35eb5082aa2b
> 

Thanks for pointing it out, This is caused by incorrect use of 
hdr-prefix and will be fixed in the next version.

>>> diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
>>> index 46130cf..a75dc2e 100755
>>> --- a/tests/gen-keys.sh
>>> +++ b/tests/gen-keys.sh
>>> @@ -112,6 +112,28 @@ for m in \
>>>        fi
>>>    done
>>>    
>>> +# SM2
>>> +for curve in sm2; do
>>> +  if [ "$1" = clean ] || [ "$1" = force ]; then
>>> +    rm -f test-$curve.cer test-$curve.key test-$curve.pub
>>> +  fi
>>> +  if [ "$1" = clean ]; then
>>> +    continue
>>> +  fi
>>> +  if [ ! -e test-$curve.key ]; then
>>> +    log openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 \
>>> +      -sm3 -sigopt "distid:1234567812345678" \
>>> +      -config test-ca.conf \
>>> +      -copy_extensions copyall \
>>> +      -newkey $curve \
>>> +      -out test-$curve.cer -outform DER \
>>> +      -keyout test-$curve.key
>>> +    if [ -s test-$curve.key ]; then
>>> +      log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
>>> +    fi
>>> +  fi
>>> +done
> 
> I'm also seeing:
> - openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 -sm3
> -sigopt distid:1234567812345678 -config test-ca.conf -copy_extensions
> copyall -newkey sm2 -out test-sm2.cer -outform DER -keyout test-sm2.key
> req: Unrecognized flag copy_extensions
> 

This command is for openssl 3.0, and '-copy_extensions copyall' is also 
a parameter supported on 3.0. At present, the mainstream version of 
openssl 1.1.1 only partially supports SM2 signatures. For example, the 
USERID in the SM2 specification cannot be used, and the certificate 
cannot be operated in the command using the SM2/3 algorithm combination, 
just like the modification of libimaevm.c in this patch, this cannot be 
done directly through the openssl command, even if the '-copy_extensions 
copyall' parameter is deleted, this command will be failed on openssl 
1.1.1. The final solution may be openssl 3.0.

On openssl 1.1.1, there is no problem to operate the signature of the 
SM2/3 algorithm combination through the API. If it is possible, the 
sign_verify test of sm2/3 is not required. What is your opinion?

> thanks,
> 
> Mimi
> 

Cheers,
Tianjia
