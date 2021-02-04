Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD4F30EC2B
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 06:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBDFoe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 00:44:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38284 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhBDFoc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 00:44:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1145VwUw161726;
        Thu, 4 Feb 2021 00:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H1K8keCfYd88y6FeSveP1pC8C27fc39xWe+VR3onYlE=;
 b=CJEcxLIDhyqyfdt2Jix9eiA87XNU5WkfN0+j22NxH0FBsy0j2cbcUajnfttUTwTXGGZq
 Nn6Pyleb4h4dnuylf6XjytZw6IOkI9k4d1OR6uB78DmrjD7VvXKPOGF/VODvk6JHvhUI
 hi7hP+w1wNOqUlNs1TjhcIQBuOY7TzOVGUGCoshj++646AJOfj9oKBp3YP6d6hrSGDyY
 sBAiXe69Yi+fESxAt6y5BnjTXnzNoj2jXZ+mwxN31NH6qV4/LlrBbbkVVN3042GMtY2w
 uFBw8P2PPhqteme3WIkN1rOPhgoOenFVdjaN1UIGV553GozY2MLKMDHdz7TWMISqeyMh Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gams0kjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 00:43:45 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1145Wx5e165902;
        Thu, 4 Feb 2021 00:43:44 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36gams0kje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 00:43:44 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1145SKiv016451;
        Thu, 4 Feb 2021 05:43:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 36cy39kxwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 05:43:44 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1145hhl641550302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Feb 2021 05:43:43 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A341124054;
        Thu,  4 Feb 2021 05:43:43 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47CE3124053;
        Thu,  4 Feb 2021 05:43:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Feb 2021 05:43:43 +0000 (GMT)
Subject: Re: [PATCH v7 1/4] crypto: Add support for ECDSA signature
 verification
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Saulo Alessandre <saulo.alessandre@gmail.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
 <20210201151910.1465705-2-stefanb@linux.ibm.com>
 <20210204052738.GA7086@gondor.apana.org.au>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <652c922b-a231-b1ab-43ce-d4d670c90eef@linux.ibm.com>
Date:   Thu, 4 Feb 2021 00:43:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204052738.GA7086@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_02:2021-02-03,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040029
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/4/21 12:27 AM, Herbert Xu wrote:
> On Mon, Feb 01, 2021 at 10:19:07AM -0500, Stefan Berger wrote:
>> Add support for parsing the parameters of a NIST P256 or NIST P192 key.
>> Enable signature verification using these keys. The new module is
>> enabled with CONFIG_ECDSA:
>>    Elliptic Curve Digital Signature Algorithm (NIST P192, P256 etc.)
>>    is A NIST cryptographic standard algorithm. Only signature verification
>>    is implemented.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: linux-crypto@vger.kernel.org
>> ---
>>   crypto/Kconfig               |  10 +
>>   crypto/Makefile              |   6 +
>>   crypto/ecc.c                 |  13 +-
>>   crypto/ecc.h                 |  28 +++
>>   crypto/ecdsa.c               | 361 +++++++++++++++++++++++++++++++++++
>>   crypto/ecdsasignature.asn1   |   4 +
>>   crypto/testmgr.c             |  12 ++
>>   crypto/testmgr.h             | 267 ++++++++++++++++++++++++++
>>   include/linux/oid_registry.h |   4 +
>>   9 files changed, 694 insertions(+), 11 deletions(-)
>>   create mode 100644 crypto/ecdsa.c
>>   create mode 100644 crypto/ecdsasignature.asn1
> Saulo Alessandre is implementing ecdsa with signing so you two
> should coordinate on this.

Hello Saulo,

  so this series here supports NIST P256 and NIST P192 for usage by IMA 
for example. It looks like you want to support more elliptic curves than 
these: p384 and even p521. Do you have any suggestion on how to proceed? 
Would you want to add patches with your additional curves on top of this 
series?

I have a project here with some test scripts that may also be relevant 
for your case: https://github.com/stefanberger/eckey-testing


     Stefan


>
> Thanks,


