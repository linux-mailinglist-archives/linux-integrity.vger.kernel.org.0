Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6C374D7E
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 04:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhEFCZt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 22:25:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58346 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229872AbhEFCZt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 22:25:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14623v91028958;
        Wed, 5 May 2021 22:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kNAFX0YlM5A0Rb+prVY3CNFaP9ovm1l1esCVP5XxnNE=;
 b=g11bY4sYPPCqK5D0x0PVJBa0niRo7KGwaqVTurn5myED3bKfg3FtXLq6lVX8grn002jx
 MADZMUZEA01ZUcUU+j+9jpX1fOViYFc3bdzW4AmMiSegYGzxuOWjYOjYc6FTReyl8qH1
 pXByw8QXAhFEuWkiTzjLjbGhKuAPf7EN5gOWZgP4Dlr9eXat+JXoqRw0PP9WAatutRfo
 W4w1Mq3gVIBbderOKQd8nLxiofwqeuQAjrE11cZaaSE4Z2qkYHVSUWU3ioZDtxmFYfGG
 36iE3hc2ngd4ehVL2L02cikZSeqrcE9Ie39K2bH2ebcnPKHqaEQ3v70mzKJxszOZIPPQ YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38c7298r69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 22:24:50 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1462OogZ103920;
        Wed, 5 May 2021 22:24:50 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38c7298r62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 May 2021 22:24:50 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1462M1ra022789;
        Thu, 6 May 2021 02:24:49 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 38c1mxthyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 02:24:49 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1462OmOc14745950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 02:24:49 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8879AE060;
        Thu,  6 May 2021 02:24:48 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF2FAAE05F;
        Thu,  6 May 2021 02:24:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 02:24:48 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20210505064843.111900-1-vt@altlinux.org>
 <20210505064843.111900-3-vt@altlinux.org>
 <ed882d26-47a8-9b45-6c96-83d2f64982f2@linux.ibm.com>
 <20210506005453.6czsllqawzye4pzb@altlinux.org>
 <20210506010753.eqbrr42ltk2eh6hs@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <db89901d-cb0a-60ff-f6e6-d5719186dfba@linux.ibm.com>
Date:   Wed, 5 May 2021 22:24:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506010753.eqbrr42ltk2eh6hs@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r4uRCBJQeoMQ_gX2RpJ6sQMJepU6llD6
X-Proofpoint-ORIG-GUID: EgSkgGnZNl5xFGZOaGvzWgl6TSSoSIml
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_11:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/5/21 9:07 PM, Vitaly Chikunov wrote:
> Stefan, Mimi,
>
> On Thu, May 06, 2021 at 03:54:53AM +0300, Vitaly Chikunov wrote:
>> On Wed, May 05, 2021 at 07:13:39PM -0400, Stefan Berger wrote:
>>> On 5/5/21 2:48 AM, Vitaly Chikunov wrote:
>>>> Allow user to specify `--keyid @/path/to/cert.pem' to extract keyid from
>>>> SKID of the certificate file. PEM or DER format is auto-detected.
>>>>
>>>> `--keyid' option is reused instead of adding a new option (like possible
>>>> `--cert') to signify to the user it's only keyid extraction and nothing
>>>> more.
>>>>
>>>> This commit creates ABI change for libimaevm, due to adding new function
>>>> ima_read_keyid(). Newer clients cannot work with older libimaevm.
>>>> Together with previous commit it creates backward-incompatible ABI
>>>> change, thus soname should be incremented on release.
>>>>
>>>> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>>>> ---
>>>>    README                 |  1 +
>>>>    src/evmctl.c           | 22 ++++++++++---
>>>>    src/imaevm.h           |  1 +
>>>>    src/libimaevm.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    tests/sign_verify.test |  1 +
>>>>    5 files changed, 105 insertions(+), 5 deletions(-)
>>>>
>>>> +/**
>>>> + * ima_read_keyid() - Read 32-bit keyid from the cert file.
>>>> + * @certfile:	File possibly containing certificate in DER/PEM format.
>>>> + * @keyid:	Output keyid in network order.
>>>> + *
>>>> + * Try to read keyid from Subject Key Identifier (SKID) of certificate.
>>>> + * Autodetect if cert is in PEM or DER encoding.
>>>> + *
>>>> + * Return: -1 (ULONG_MAX) on error;
>>>> + *         32-bit keyid as unsigned integer in host order.
>>> That's confusing, two times the same result, one time in host order, on time
>>> in network order. Why not just one return value in host order?
>> Pointer API is similar to calc_keyid_v2().
>>
>> Do you sugegst to change calc_keyid_v2() API too?
>>
>> To introduce non-confusing API that contradict other parts of API would
>> be more confusing than it already is.
> Maybe we could change this libimaevm API:
>
>    void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey);
>
> to
>
>    void calc_keyid_v2(uint8_t *keyid, char *str, EVP_PKEY *pkey);


I think it's better to leave it... :-(


>
> To signal to the user that there it's not just uint32_t, but some byte
> array (possible in network order). This would not even break ABI, only
> API. (But, we breaking ABI with this patch set anyway.)

You mean we are breaking it by introducing this extensions here?

@ -196,6 +196,7 @@ struct libimaevm_params {
  	const char *hash_algo;
  	const char *keyfile;
  	const char *keypass;
+	uint32_t keyid;		/* keyid overriding value, unless 0. */
  };

>
> Thanks,
>
