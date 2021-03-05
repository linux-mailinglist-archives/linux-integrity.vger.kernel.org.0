Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93432EDA6
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 16:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCEPFB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 10:05:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhCEPEn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 10:04:43 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125F3ucc109313;
        Fri, 5 Mar 2021 10:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kSVhTZ4GiXSFmDlmjESUTcke6AF0wnA3C+nzwO0roJk=;
 b=ikYxZd44BLNMlNlYCbLqZurF951LQi53BrmlPRYfQrfbqKL9cTkCylEVvipRnQWDl+IE
 i6bYF7CZNLJ0X1YRJJn/IiqOokutU0Vh1M3jKlBYUWbyZxZHWskVPEHhzBqi1U50ArUb
 KBmN91wjHw0bKnxymhy+ISJiBmONwxsr4yplC27utgd9+kBYr7uR3IACxsLO2qr077kO
 i60kxu06bIEdQPJuG9lWE7hf09lG/BA5aUoU4SmJ6wNQnfc76ZZTFueSaJMCWpbkrYCm
 WUhHOprp9D2OP2Pn9p8zpe/i3yZHjq39DXBpwc1r0dpdi/sqGaw/ul84uuECw2MvZzri VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373p9wsbgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 10:04:34 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125F4Xge112611;
        Fri, 5 Mar 2021 10:04:33 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373p9wsbg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 10:04:33 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125F2N1e026060;
        Fri, 5 Mar 2021 15:04:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 3712pj83xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 15:04:32 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125F4Wgd27459936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 15:04:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20EF3AE05C;
        Fri,  5 Mar 2021 15:04:32 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15003AE064;
        Fri,  5 Mar 2021 15:04:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 15:04:32 +0000 (GMT)
Subject: Re: [PATCH v9 2/9] x509: Detect sm2 keys by their parameters OID
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
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
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1b8e63ad-faa0-4b19-c515-32cbb160763a@linux.ibm.com>
Date:   Fri, 5 Mar 2021 10:04:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4e584fe5-966f-a0e8-3542-8ef01d647101@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_08:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/21 2:37 AM, Tianjia Zhang wrote:
> Hi,
>
> On 3/4/21 7:46 AM, Stefan Berger wrote:
>> Tianjia,
>>
>>     can you say whether SM2 support works for you before and after 
>> applying this patch? I cannot verify it with an sm2 key I have 
>> created using a sequence of commands like this:
>>
>>  > modprobe sm2_generic
>>  > id=$(keyctl newring test @u)
>>  > keyctl padd asymmetric "" $id < sm2.der
>> add_key: Key was rejected by service
>>  > keyctl padd asymmetric "" $id < eckeys/cert-prime192v1-0.der
>> 88506426
>>
>> The sm2 key is reject but the pime192v1 key works just fine. SM2 
>> support neither worked for me before nor after this patch here. The 
>> difference is that before it returned 'add_key: Package not installed'.
>>
>> This is my sm2 cert:
>>
>>  > base64 < sm2.der
>> MIIBbzCCARWgAwIBAgIUfqwndeAy7reymWLwvCHOgYPU2YUwCgYIKoZIzj0EAwIwDTELMAkGA1UE 
>>
>> AwwCbWUwHhcNMjEwMTI0MTgwNjQ3WhcNMjIwMTI0MTgwNjQ3WjANMQswCQYDVQQDDAJtZTBZMBMG 
>>
>> ByqGSM49AgEGCCqBHM9VAYItA0IABEtiMaczdk46MEugmOsY/u+puf5qoi7JdLd/w3VpdixvDd26 
>>
>> vrxLKL7lCTVn5w3a07G7QB1dgdMDpzIRgWrVXC6jUzBRMB0GA1UdDgQWBBSxOVnE7ihvTb6Nczb4 
>>
>> /mow+HIc9TAfBgNVHSMEGDAWgBSxOVnE7ihvTb6Nczb4/mow+HIc9TAPBgNVHRMBAf8EBTADAQH/ 
>>
>> MAoGCCqGSM49BAMCA0gAMEUCIE1kiji2ABUy663NANe0iCPjCeeqg02Yk4b3K+Ci/Qh4AiEA/cFB 
>>
>> eJEVklyveRMvuTP7BN7FG4U8iRdtedjiX+YrNio=
>>
>> Regards,
>>     Stefan
>>
>
> Yes, it works fine here. Your test method may be wrong. First of all, 
> the certificate looks wrong, I don’t know if it is not sent 
> completely. Secondly, the SM2 algorithm must be compiled with builtin. 
> There will be a problem when it is compiled into a module. This is a 
> restriction for SM2 signature with Za. you may refer to this discussion:
>
> https://lkml.org/lkml/2021/1/12/1736
>
> In addition, give you a self-signed root certificate for my test:
>
> -----BEGIN CERTIFICATE-----
> MIICLjCCAdWgAwIBAgIUEoozP6LzMYWh4gCpcWlzsUyfgsIwCgYIKoEcz1UBg3Uw
> bTELMAkGA1UEBhMCQ04xCzAJBgNVBAgMAkdTMQswCQYDVQQHDAJHdDENMAsGA1UE
> CgwEYmFiYTELMAkGA1UECwwCT1MxCzAJBgNVBAMMAmNhMRswGQYJKoZIhvcNAQkB
> FgxjYUB3b3JsZC5jb20wHhcNMjAwNDE1MTE1NDA3WhcNMzAwNDEzMTE1NDA3WjBt
> MQswCQYDVQQGEwJDTjELMAkGA1UECAwCR1MxCzAJBgNVBAcMAkd0MQ0wCwYDVQQK
> DARiYWJhMQswCQYDVQQLDAJPUzELMAkGA1UEAwwCY2ExGzAZBgkqhkiG9w0BCQEW
> DGNhQHdvcmxkLmNvbTBZMBMGByqGSM49AgEGCCqBHM9VAYItA0IABMTGRiHezKm5
> MiKHlyfa5Bv5jLxge/WRRG0nLNsZx1yf0XQTQBR/tFFjPGePEr7+Fa1CPgYpXExx
> i44coYMmQT6jUzBRMB0GA1UdDgQWBBSjd9GWIe98Ll9J0dquxgCktp9DrTAfBgNV
> HSMEGDAWgBSjd9GWIe98Ll9J0dquxgCktp9DrTAPBgNVHRMBAf8EBTADAQH/MAoG
> CCqBHM9VAYN1A0cAMEQCIAvLWIfGFq85u/vVMLc5H1D/DnrNS0VhSkQA4daRO4tc
> AiABbeWENcQZDZLWTuqG9P2KDPOoNqV/QV/+0XjMAVblhg==
> -----END CERTIFICATE-----
>
> If you can, please add:
>
> Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>
> good luck!


It works with your certificate! When I create the sm2 with OpenSSL on 
Ubuntu, which seems to have sm2 support, or so one may think, I get this 
type of signature:


I cannot create it with sm3, if that's how this is supposed to be signed:

 > # openssl req -x509 -sm3 -newkey ec -pkeyopt ec_paramgen_curve:sm2 
-keyout sm2key.pem -days 365 -subj '/CN=test' -nodes -outform der -out 
sm2.der
parameter error "ec_paramgen_curve:sm2"
140735899258064:error:100AE081:elliptic curve 
routines:EC_GROUP_new_by_curve_name:unknown group:crypto/ec/ec_curve.c:418:
140735899258064:error:100C508D:elliptic curve 
routines:pkey_ec_ctrl:invalid curve:crypto/ec/ec_pmeth.c:231:


Using sha256 instead, which is the mistake:

 > openssl req -x509 -sha256 -newkey ec -pkeyopt ec_paramgen_curve:sm2 
-keyout sm2key.pem -days 365 -subj '/CN=test' -nodes -outform der -out 
sm2-2nd.der

 > openssl x509 -inform der -in sm2-2nd.der -noout -text

[...]

     Signature Algorithm: ecdsa-with-SHA256
          30:45:02:20:05:72:15:b0:e8:f5:5a:27:d2:fb:f9:de:de:35:
          05:b2:76:8a:6f:84:c1:54:db:c2:38:8c:d2:64:8b:67:23:01:
          02:21:00:97:77:9e:42:fa:41:3d:d4:81:5e:5b:ad:9e:56:ad:
          46:fc:5e:94:92:a6:07:2d:af:62:d2:2d:39:7b:71:f1:4a


Yours has this type of signature:

     Signature Algorithm: 1.2.156.10197.1.501
          30:44:02:20:0b:cb:58:87:c6:16:af:39:bb:fb:d5:30:b7:39:
          1f:50:ff:0e:7a:cd:4b:45:61:4a:44:00:e1:d6:91:3b:8b:5c:
          02:20:01:6d:e5:84:35:c4:19:0d:92:d6:4e:ea:86:f4:fd:8a:
          0c:f3:a8:36:a5:7f:41:5f:fe:d1:78:cc:01:56:e5:86

Thanks anyway!


    Stefan


