Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8832F281
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 19:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCES17 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 13:27:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhCES1a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 13:27:30 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125I9AYx075497;
        Fri, 5 Mar 2021 13:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VmxNsh0XuesPJtzAnS19czukR9HyMk0qR6Q685xZu74=;
 b=edgko5t8u5px0TkS7wtqbjUWSEFAr02jTmJ1wc1BlW9m8+43mEj80qde0obNzlDDerB+
 ZuKiCtO9FSnAGmewQYrWK8YD4XGoipj6zeh6eKPhYcibX0gTDRSa7YAekuiiAHvsrh76
 CEFSD2yF3+BCu+2e+RJiTKCKv8QPNfezZBaxD+KimjQZbzHS31FQ5vpPXoCJYGd2QpJs
 qSTbHcBzgcQp2QB/s+tw362UQMS4TTPMvawFXKmMMvtFFfrKpZTao/conVKkZu23ViY+
 7L8utfVSUzmyTsydwDNlhGQxHyiyoMtzUTBu3GbrgrvDRGSDFg1mt4XKNSxzYTpWD2/S 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373rhwjckr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 13:27:20 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 125I9Q0x077349;
        Fri, 5 Mar 2021 13:27:20 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373rhwjcka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 13:27:19 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 125IGtPU023489;
        Fri, 5 Mar 2021 18:27:19 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 36ydqa5mrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 18:27:19 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 125IRId711469296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 18:27:18 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44255112066;
        Fri,  5 Mar 2021 18:27:18 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FFEB112065;
        Fri,  5 Mar 2021 18:27:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 18:27:18 +0000 (GMT)
Subject: Re: [PATCH v10 4/9] ecdsa: Register NIST P384 and extend test suite
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-5-stefanb@linux.vnet.ibm.com>
 <YEJl/SxdisIJxncp@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <a4cafd1b-c548-9a6f-e275-53093d4c71bb@linux.ibm.com>
Date:   Fri, 5 Mar 2021 13:27:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YEJl/SxdisIJxncp@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_13:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050092
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/5/21 12:10 PM, Jarkko Sakkinen wrote:
> On Thu, Mar 04, 2021 at 07:51:58PM -0500, Stefan Berger wrote:
>> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>>
>> * crypto/ecdsa.c
>>    - add ecdsa_nist_p384_init_tfm
>>    - register and unregister P384 tfm
>>
>> * crypto/testmgr.c
>>    - add test vector for P384 on vector of tests
>>
>> * crypto/testmgr.h
>>    - add test vector params for P384(sha1, sha224, sha256, sha384
>>      and sha512)
>>
>> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> "diffstat"

I will add an explanation on top but leave what Saulo wrote in place. It 
has been accepted before like this in this corner of the kernel: 
https://github.com/torvalds/linux/commit/0d7a78643f6972214e99205b364e508f8ea9598e#diff-334794133a31417069722ddf2cc2725b04d4f5e3e4cfbbfdd627ae058e261c38


