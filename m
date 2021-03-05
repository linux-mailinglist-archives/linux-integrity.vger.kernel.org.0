Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9F32E307
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 08:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCEHh2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 02:37:28 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34189 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhCEHh2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 02:37:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UQWshPv_1614929842;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UQWshPv_1614929842)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Mar 2021 15:37:22 +0800
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
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <4e584fe5-966f-a0e8-3542-8ef01d647101@linux.alibaba.com>
Date:   Fri, 5 Mar 2021 15:37:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <048e22c7-45e3-022c-cd5b-a6bc127958d3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 3/4/21 7:46 AM, Stefan Berger wrote:
> Tianjia,
> 
>     can you say whether SM2 support works for you before and after 
> applying this patch? I cannot verify it with an sm2 key I have created 
> using a sequence of commands like this:
> 
>  > modprobe sm2_generic
>  > id=$(keyctl newring test @u)
>  > keyctl padd asymmetric "" $id < sm2.der
> add_key: Key was rejected by service
>  > keyctl padd asymmetric "" $id < eckeys/cert-prime192v1-0.der
> 88506426
> 
> The sm2 key is reject but the pime192v1 key works just fine. SM2 support 
> neither worked for me before nor after this patch here. The difference 
> is that before it returned 'add_key: Package not installed'.
> 
> This is my sm2 cert:
> 
>  > base64 < sm2.der
> MIIBbzCCARWgAwIBAgIUfqwndeAy7reymWLwvCHOgYPU2YUwCgYIKoZIzj0EAwIwDTELMAkGA1UE 
> 
> AwwCbWUwHhcNMjEwMTI0MTgwNjQ3WhcNMjIwMTI0MTgwNjQ3WjANMQswCQYDVQQDDAJtZTBZMBMG 
> 
> ByqGSM49AgEGCCqBHM9VAYItA0IABEtiMaczdk46MEugmOsY/u+puf5qoi7JdLd/w3VpdixvDd26 
> 
> vrxLKL7lCTVn5w3a07G7QB1dgdMDpzIRgWrVXC6jUzBRMB0GA1UdDgQWBBSxOVnE7ihvTb6Nczb4 
> 
> /mow+HIc9TAfBgNVHSMEGDAWgBSxOVnE7ihvTb6Nczb4/mow+HIc9TAPBgNVHRMBAf8EBTADAQH/ 
> 
> MAoGCCqGSM49BAMCA0gAMEUCIE1kiji2ABUy663NANe0iCPjCeeqg02Yk4b3K+Ci/Qh4AiEA/cFB 
> 
> eJEVklyveRMvuTP7BN7FG4U8iRdtedjiX+YrNio=
> 
> Regards,
>     Stefan
> 

Yes, it works fine here. Your test method may be wrong. First of all, 
the certificate looks wrong, I don’t know if it is not sent completely. 
Secondly, the SM2 algorithm must be compiled with builtin. There will be 
a problem when it is compiled into a module. This is a restriction for 
SM2 signature with Za. you may refer to this discussion:

https://lkml.org/lkml/2021/1/12/1736

In addition, give you a self-signed root certificate for my test:

-----BEGIN CERTIFICATE-----
MIICLjCCAdWgAwIBAgIUEoozP6LzMYWh4gCpcWlzsUyfgsIwCgYIKoEcz1UBg3Uw
bTELMAkGA1UEBhMCQ04xCzAJBgNVBAgMAkdTMQswCQYDVQQHDAJHdDENMAsGA1UE
CgwEYmFiYTELMAkGA1UECwwCT1MxCzAJBgNVBAMMAmNhMRswGQYJKoZIhvcNAQkB
FgxjYUB3b3JsZC5jb20wHhcNMjAwNDE1MTE1NDA3WhcNMzAwNDEzMTE1NDA3WjBt
MQswCQYDVQQGEwJDTjELMAkGA1UECAwCR1MxCzAJBgNVBAcMAkd0MQ0wCwYDVQQK
DARiYWJhMQswCQYDVQQLDAJPUzELMAkGA1UEAwwCY2ExGzAZBgkqhkiG9w0BCQEW
DGNhQHdvcmxkLmNvbTBZMBMGByqGSM49AgEGCCqBHM9VAYItA0IABMTGRiHezKm5
MiKHlyfa5Bv5jLxge/WRRG0nLNsZx1yf0XQTQBR/tFFjPGePEr7+Fa1CPgYpXExx
i44coYMmQT6jUzBRMB0GA1UdDgQWBBSjd9GWIe98Ll9J0dquxgCktp9DrTAfBgNV
HSMEGDAWgBSjd9GWIe98Ll9J0dquxgCktp9DrTAPBgNVHRMBAf8EBTADAQH/MAoG
CCqBHM9VAYN1A0cAMEQCIAvLWIfGFq85u/vVMLc5H1D/DnrNS0VhSkQA4daRO4tc
AiABbeWENcQZDZLWTuqG9P2KDPOoNqV/QV/+0XjMAVblhg==
-----END CERTIFICATE-----

If you can, please add:

Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

good luck!

Tianjia

