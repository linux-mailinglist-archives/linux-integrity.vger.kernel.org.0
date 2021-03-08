Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70799330882
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Mar 2021 07:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHG65 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Mar 2021 01:58:57 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:37923 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhCHG65 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Mar 2021 01:58:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UQr4yhY_1615186732;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UQr4yhY_1615186732)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Mar 2021 14:58:53 +0800
Subject: Re: [PATCH v9 2/9] x509: Detect sm2 keys by their parameters OID
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
 <20210225160802.2478700-3-stefanb@linux.vnet.ibm.com>
 <048e22c7-45e3-022c-cd5b-a6bc127958d3@linux.ibm.com>
 <4e584fe5-966f-a0e8-3542-8ef01d647101@linux.alibaba.com>
 <1b8e63ad-faa0-4b19-c515-32cbb160763a@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <7590b698-3609-8061-6a06-dee1a338e16c@linux.alibaba.com>
Date:   Mon, 8 Mar 2021 14:58:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1b8e63ad-faa0-4b19-c515-32cbb160763a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 3/5/21 11:04 PM, Stefan Berger wrote:
> On 3/5/21 2:37 AM, Tianjia Zhang wrote:
>> Hi,
>>
>> On 3/4/21 7:46 AM, Stefan Berger wrote:
>>> Tianjia,
>>>
>>>     can you say whether SM2 support works for you before and after 
>>> applying this patch? I cannot verify it with an sm2 key I have 
>>> created using a sequence of commands like this:
>>>
>>>  > modprobe sm2_generic
>>>  > id=$(keyctl newring test @u)
>>>  > keyctl padd asymmetric "" $id < sm2.der
>>> add_key: Key was rejected by service
>>>  > keyctl padd asymmetric "" $id < eckeys/cert-prime192v1-0.der
>>> 88506426
>>>
>>> The sm2 key is reject but the pime192v1 key works just fine. SM2 
>>> support neither worked for me before nor after this patch here. The 
>>> difference is that before it returned 'add_key: Package not installed'.
>>>
>>> This is my sm2 cert:
>>>
>>>  > base64 < sm2.der
>>> MIIBbzCCARWgAwIBAgIUfqwndeAy7reymWLwvCHOgYPU2YUwCgYIKoZIzj0EAwIwDTELMAkGA1UE 
>>>
>>> AwwCbWUwHhcNMjEwMTI0MTgwNjQ3WhcNMjIwMTI0MTgwNjQ3WjANMQswCQYDVQQDDAJtZTBZMBMG 
>>>
>>> ByqGSM49AgEGCCqBHM9VAYItA0IABEtiMaczdk46MEugmOsY/u+puf5qoi7JdLd/w3VpdixvDd26 
>>>
>>> vrxLKL7lCTVn5w3a07G7QB1dgdMDpzIRgWrVXC6jUzBRMB0GA1UdDgQWBBSxOVnE7ihvTb6Nczb4 
>>>
>>> /mow+HIc9TAfBgNVHSMEGDAWgBSxOVnE7ihvTb6Nczb4/mow+HIc9TAPBgNVHRMBAf8EBTADAQH/ 
>>>
>>> MAoGCCqGSM49BAMCA0gAMEUCIE1kiji2ABUy663NANe0iCPjCeeqg02Yk4b3K+Ci/Qh4AiEA/cFB 
>>>
>>> eJEVklyveRMvuTP7BN7FG4U8iRdtedjiX+YrNio=
>>>
>>> Regards,
>>>     Stefan
>>>
>>
>> Yes, it works fine here. Your test method may be wrong. First of all, 
>> the certificate looks wrong, I don’t know if it is not sent 
>> completely. Secondly, the SM2 algorithm must be compiled with builtin. 
>> There will be a problem when it is compiled into a module. This is a 
>> restriction for SM2 signature with Za. you may refer to this discussion:
>>
>> https://lkml.org/lkml/2021/1/12/1736
>>
>> In addition, give you a self-signed root certificate for my test:
>>
>> -----BEGIN CERTIFICATE-----
>> MIICLjCCAdWgAwIBAgIUEoozP6LzMYWh4gCpcWlzsUyfgsIwCgYIKoEcz1UBg3Uw
>> bTELMAkGA1UEBhMCQ04xCzAJBgNVBAgMAkdTMQswCQYDVQQHDAJHdDENMAsGA1UE
>> CgwEYmFiYTELMAkGA1UECwwCT1MxCzAJBgNVBAMMAmNhMRswGQYJKoZIhvcNAQkB
>> FgxjYUB3b3JsZC5jb20wHhcNMjAwNDE1MTE1NDA3WhcNMzAwNDEzMTE1NDA3WjBt
>> MQswCQYDVQQGEwJDTjELMAkGA1UECAwCR1MxCzAJBgNVBAcMAkd0MQ0wCwYDVQQK
>> DARiYWJhMQswCQYDVQQLDAJPUzELMAkGA1UEAwwCY2ExGzAZBgkqhkiG9w0BCQEW
>> DGNhQHdvcmxkLmNvbTBZMBMGByqGSM49AgEGCCqBHM9VAYItA0IABMTGRiHezKm5
>> MiKHlyfa5Bv5jLxge/WRRG0nLNsZx1yf0XQTQBR/tFFjPGePEr7+Fa1CPgYpXExx
>> i44coYMmQT6jUzBRMB0GA1UdDgQWBBSjd9GWIe98Ll9J0dquxgCktp9DrTAfBgNV
>> HSMEGDAWgBSjd9GWIe98Ll9J0dquxgCktp9DrTAPBgNVHRMBAf8EBTADAQH/MAoG
>> CCqBHM9VAYN1A0cAMEQCIAvLWIfGFq85u/vVMLc5H1D/DnrNS0VhSkQA4daRO4tc
>> AiABbeWENcQZDZLWTuqG9P2KDPOoNqV/QV/+0XjMAVblhg==
>> -----END CERTIFICATE-----
>>
>> If you can, please add:
>>
>> Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>
>> good luck!
> 
> 
> It works with your certificate! When I create the sm2 with OpenSSL on 
> Ubuntu, which seems to have sm2 support, or so one may think, I get this 
> type of signature:
> 
> 
> I cannot create it with sm3, if that's how this is supposed to be signed:
> 
>  > # openssl req -x509 -sm3 -newkey ec -pkeyopt ec_paramgen_curve:sm2 
> -keyout sm2key.pem -days 365 -subj '/CN=test' -nodes -outform der -out 
> sm2.der
> parameter error "ec_paramgen_curve:sm2"
> 140735899258064:error:100AE081:elliptic curve 
> routines:EC_GROUP_new_by_curve_name:unknown group:crypto/ec/ec_curve.c:418:
> 140735899258064:error:100C508D:elliptic curve 
> routines:pkey_ec_ctrl:invalid curve:crypto/ec/ec_pmeth.c:231:
> 
> 
> Using sha256 instead, which is the mistake:
> 
>  > openssl req -x509 -sha256 -newkey ec -pkeyopt ec_paramgen_curve:sm2 
> -keyout sm2key.pem -days 365 -subj '/CN=test' -nodes -outform der -out 
> sm2-2nd.der
> 
>  > openssl x509 -inform der -in sm2-2nd.der -noout -text
> 
> [...]
> 
>      Signature Algorithm: ecdsa-with-SHA256
>           30:45:02:20:05:72:15:b0:e8:f5:5a:27:d2:fb:f9:de:de:35:
>           05:b2:76:8a:6f:84:c1:54:db:c2:38:8c:d2:64:8b:67:23:01:
>           02:21:00:97:77:9e:42:fa:41:3d:d4:81:5e:5b:ad:9e:56:ad:
>           46:fc:5e:94:92:a6:07:2d:af:62:d2:2d:39:7b:71:f1:4a
> 
> 
> Yours has this type of signature:
> 
>      Signature Algorithm: 1.2.156.10197.1.501
>           30:44:02:20:0b:cb:58:87:c6:16:af:39:bb:fb:d5:30:b7:39:
>           1f:50:ff:0e:7a:cd:4b:45:61:4a:44:00:e1:d6:91:3b:8b:5c:
>           02:20:01:6d:e5:84:35:c4:19:0d:92:d6:4e:ea:86:f4:fd:8a:
>           0c:f3:a8:36:a5:7f:41:5f:fe:d1:78:cc:01:56:e5:86
> 
> Thanks anyway!
> 
> 
>     Stefan
> 

I guess it may be that your openssl version is too low. At present, only 
openssl 3.0.0 (still in the alpha stage and not yet officially released) 
can support the certificate of the SM2-with-SM3 algorithm combination.

This is the command I used in openssl-3.0.0-alpha6:

openssl ecparam -genkey -name SM2 -text -out ca.key
openssl req -new \
     -x509 -days 3650 \
     -sm3 -sigopt "distid:1234567812345678" \
     -key ca.key \
     -out ca.crt \
     -subj "/C=CN/ST=GS/L=Gt/O=baba/OU=OS/CN=ca/emailAddress=ca@world.com"
