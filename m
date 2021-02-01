Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758D530A841
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 14:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhBANFc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 08:05:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231478AbhBANFb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 08:05:31 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111D2QKK163281;
        Mon, 1 Feb 2021 08:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hxuRMRBRfXGHt6rA9F92aI19zpjVyYYQdrKgJ+Z9NTE=;
 b=C+yzMtGHCu6djAbMCOeWLIsHagtbR8OKaWCZGNN9OCjvJFFEbgCZrHFvjo8hylh6zicZ
 lhwsj5omQV8WbiitOu7u7n92DO38/JyUBoD0m5qRSejYb8u0qg13f6a7m8Q9GbUyGn5T
 XgB71mn9/1TVb0ce4MewUrQLg5zPUyQWkIjuWwY8ypoLFJOC3xO16zlnCth8X+kXorop
 4gL6aL+3K3waohc+6zQitVPOYb/TIli8oL05iv1ELG9STZBQVOfeRMUPxAIMTzgoWTCF
 cvqd3XoAhTB0DMi1s0uQ3OEdUAWIuofRGdMpjoiGFnZRUfkvATpr0Jp+4WmJcJaRos4L DQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ej6082kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 08:04:37 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111Cw3v2023924;
        Mon, 1 Feb 2021 13:04:28 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 36cy3921c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 13:04:28 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111D4RPM6881828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 13:04:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8859EAC064;
        Mon,  1 Feb 2021 13:04:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77A75AC060;
        Mon,  1 Feb 2021 13:04:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 13:04:27 +0000 (GMT)
Subject: Re: [PATCH v6 1/4] crypto: Add support for ECDSA signature
 verification
To:     yumeng <yumeng18@huawei.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20210131233301.1301787-1-stefanb@linux.ibm.com>
 <20210131233301.1301787-2-stefanb@linux.ibm.com>
 <289ef2ac-d653-47b3-7771-5d8a7342ad21@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <f7660865-3efc-8425-d494-2e6cc9631cc5@linux.ibm.com>
Date:   Mon, 1 Feb 2021 08:04:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <289ef2ac-d653-47b3-7771-5d8a7342ad21@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010065
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/1/21 2:24 AM, yumeng wrote:
>
>
> 在 2021/2/1 7:32, Stefan Berger 写道:
>> +/**
>> + * ecc_get_curve()  - Get a curve given its curve_id
>> + *
>> + * @curve_id:  Id of the curve
>> + *
>> + * Returns pointer to the curve data, NULL if curve is not available
>> + */
>> +const struct ecc_curve *ecc_get_curve(unsigned int curve_id);
>> +
>>   /**
>>    * ecc_is_key_valid() - Validate a given ECDH private key
>
>
> Shall we move this definition to 'include/crypto'? Other drivers may 
> also want to use it.

Maybe the driver that starts using would move it?


