Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5653E87C4
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 03:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhHKBvW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 21:51:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230401AbhHKBvW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 21:51:22 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B1Wb8S121278;
        Tue, 10 Aug 2021 21:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4YyHtzQsCrTd8shlfgbCeJc6L1qn4hEFd6Uj12mcM2g=;
 b=byCez6+QwW2j1RWt48H0HmT5+pbHDEnVvgVGCJkRlufw284nxq0fO/2sigSa5xlcLQOI
 1N/he4anLjGrl3aXki13hp9TvvNiJ2j/OUjpzt64b8JYmJH9x6cu0azy9KZQ1nKZXAt+
 yr5R7CzCy2/2vLlzIYJyvTy9bc3HBO21E8nrRyhXBl2GX1mRg6r/7lENwTBZcYywdz5s
 pbIqTEFhQhmNExYu1AuLmnThn7yEjpF93DNbvhPI/m+TIpCAemQjrTViscBv3KAule+P
 pn0ueg/Ut0L5RQAnv1pc2hzxIMGbc4T4Q9d9Q1CDGrvaPZkhpYnIUqZ904gqScw9D83G nA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aby977t1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 21:50:58 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17B1m0ke021287;
        Wed, 11 Aug 2021 01:50:58 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3a9htdm53m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 01:50:58 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17B1oub630278046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 01:50:56 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D85F28068;
        Wed, 11 Aug 2021 01:50:56 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D3CF2806D;
        Wed, 11 Aug 2021 01:50:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 01:50:56 +0000 (GMT)
Subject: Re: [PATCH v4 2/2] tpm: ibmvtpm: Rename tpm_process_cmd to tpm_status
 and define flag
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     nasastry@in.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
 <20210809192159.2176580-3-stefanb@linux.vnet.ibm.com>
 <20210810175855.fixtw5jks4gbmkua@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <86f6a6c8-87cc-a397-35b3-a30220f12aed@linux.ibm.com>
Date:   Tue, 10 Aug 2021 21:50:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810175855.fixtw5jks4gbmkua@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kHS51RwoDUoLBMfVUf9-7oWwEuLThsug
X-Proofpoint-ORIG-GUID: kHS51RwoDUoLBMfVUf9-7oWwEuLThsug
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_08:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110007
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 8/10/21 1:58 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 09, 2021 at 03:21:59PM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
>> the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.
>>
>>
>>   		default:
>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
>> index 51198b137461..252f1cccdfc5 100644
>> --- a/drivers/char/tpm/tpm_ibmvtpm.h
>> +++ b/drivers/char/tpm/tpm_ibmvtpm.h
>> @@ -41,7 +41,8 @@ struct ibmvtpm_dev {
>>   	wait_queue_head_t wq;
>>   	u16 res_len;
>>   	u32 vtpm_version;
>> -	u8 tpm_processing_cmd;
>> +	u8 tpm_status;
>> +#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
> Declare this already in the fix, and just leave the rename here.

You mean the fix patch does not use 'true' anymore but uses the 
TPM_STATUS_BUSY flag already but the name is still tpm_processing_cmd? 
And literally only the renaming of this field is done in the 2nd patch?


    Stefan


>
>>   };
>>   
>>   #define CRQ_RES_BUF_SIZE	PAGE_SIZE
>> -- 
>> 2.31.1
>>
>>
> Otherwise, these look fine.
>
> /Jarkko
