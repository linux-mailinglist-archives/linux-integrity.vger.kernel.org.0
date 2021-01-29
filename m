Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D00308CE7
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 20:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhA2S7Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 13:59:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232651AbhA2S7V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 13:59:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10TIXgna055616;
        Fri, 29 Jan 2021 13:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gvlIQii1iYf+bscSq0IPvtHg7qQbBhSTXpfND6+KQac=;
 b=D652sdA17foaemZbO4smpJdhq3g7iOiKltQ2Dh1HcXoHREGCJle4sT08J4h5qXq6ky/q
 R+g2WTjhtxeQqNfYG9BIrvoeSI83Qa2+dI3XVPwxXPpfn3gSKA5ge5JL3dolpI7SwWnC
 3kG9IlrTCKjVRJU6MDU3udiBauAvI7/06N+zhyRAA46ka/2j5+kZbH+4UPyxfRKV/JUD
 NVd0dAO0H7G7bXrFpZObIEyk0aWyDa2Rux1NAuPDyrUFaSk2s4MuL9RLQ+fJ5EsFKr41
 XNuD4LDmiWgbMV0m/mYB9bT2UHM2qaAnk2W0ZAzSlsNuDjmaHHwIrlmPdoOps62rCOze yQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36cm08g336-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 13:58:00 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10TIXIxY014876;
        Fri, 29 Jan 2021 18:57:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 36acj9u9mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jan 2021 18:57:59 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10TIvxUG36766000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 18:57:59 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E95E1AC05F;
        Fri, 29 Jan 2021 18:57:58 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC4CDAC059;
        Fri, 29 Jan 2021 18:57:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jan 2021 18:57:58 +0000 (GMT)
Subject: Re: [PATCH v2] tpm: ibmvtpm: fix error return code in
 tpm_ibmvtpm_probe()
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>
References: <20210126014753.340299-1-stefanb@linux.vnet.ibm.com>
 <YBRHfZeqAirQolIN@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <262c3095-d4c0-f124-c8bc-e99685cbe572@linux.ibm.com>
Date:   Fri, 29 Jan 2021 13:57:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBRHfZeqAirQolIN@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-29_06:2021-01-29,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101290089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/29/21 12:35 PM, Jarkko Sakkinen wrote:
> On Mon, Jan 25, 2021 at 08:47:53PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Return error code -ETIMEDOUT rather than '0' when waiting for the
>> rtce_buf to be set has timed out.
>>
>> Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Thanks! Should I add
>
> Cc: stable@vger.kernel.org to this?

Yes, that would be good! Thank you!


    Stefan


>
> /Jarkko
>
>
>>   drivers/char/tpm/tpm_ibmvtpm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
>> index 994385bf37c0..813eb2cac0ce 100644
>> --- a/drivers/char/tpm/tpm_ibmvtpm.c
>> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
>> @@ -687,6 +687,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>>   				ibmvtpm->rtce_buf != NULL,
>>   				HZ)) {
>>   		dev_err(dev, "CRQ response timed out\n");
>> +		rc = -ETIMEDOUT;
>>   		goto init_irq_cleanup;
>>   	}
>>   
>> -- 
>> 2.25.4
>>
>>

