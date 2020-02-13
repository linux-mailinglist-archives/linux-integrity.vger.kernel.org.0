Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE88F15CA29
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgBMSUZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 13:20:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgBMSUY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 13:20:24 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DIIrSN149131;
        Thu, 13 Feb 2020 13:20:16 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn6jp8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 13:20:15 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DICA3c018763;
        Thu, 13 Feb 2020 18:20:13 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 2y5bc0050h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 18:20:13 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DIKCGY52494764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 18:20:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0BC9B2066;
        Thu, 13 Feb 2020 18:20:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A021FB2065;
        Thu, 13 Feb 2020 18:20:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 18:20:12 +0000 (GMT)
Subject: Re: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, gcwilson@linux.ibm.com
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
 <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d805c04b-3680-97d5-8ea7-82409c7ef308@linux.ibm.com>
Date:   Thu, 13 Feb 2020 13:20:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_06:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130129
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/13/20 12:53 PM, Nayna wrote:
>
> On 2/4/20 8:27 AM, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
>> version of TPM is connected through the vio_device_id.
>>
>> In case a TPM 2 is found, we set the TPM_OPS_AUTO_STARTUP flag to
>> have properly initialize the TPM and driver.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_ibmvtpm.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c 
>> b/drivers/char/tpm/tpm_ibmvtpm.c
>> index eee566eddb35..d479d64a65aa 100644
>> --- a/drivers/char/tpm/tpm_ibmvtpm.c
>> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
>> @@ -29,6 +29,7 @@ static const char tpm_ibmvtpm_driver_name[] = 
>> "tpm_ibmvtpm";
>>
>>   static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
>>       { "IBM,vtpm", "IBM,vtpm"},
>> +    { "IBM,vtpm", "IBM,vtpm20"},
>>       { "", "" }
>>   };
>>   MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
>> @@ -443,7 +444,7 @@ static bool tpm_ibmvtpm_req_canceled(struct 
>> tpm_chip *chip, u8 status)
>>       return (status == 0);
>>   }
>>
>> -static const struct tpm_class_ops tpm_ibmvtpm = {
>> +static struct tpm_class_ops tpm_ibmvtpm = {
>>       .recv = tpm_ibmvtpm_recv,
>>       .send = tpm_ibmvtpm_send,
>>       .cancel = tpm_ibmvtpm_cancel,
>> @@ -672,6 +673,11 @@ static int tpm_ibmvtpm_probe(struct vio_dev 
>> *vio_dev,
>>       if (rc)
>>           goto init_irq_cleanup;
>>
>> +    if (!strcmp(id->compat, "IBM,vtpm20")) {
>> +        chip->flags |= TPM_CHIP_FLAG_TPM2;
>> +        tpm_ibmvtpm.flags = TPM_OPS_AUTO_STARTUP;
>
> TPM_OPS_AUTO_STARTUP flag isn't set for vTPM 1.2. What is different in 
> case of vTPM 2.0 ?


I don't want side effects for the TPM 1.2 case here, so I am only 
modifying the flag for the case where the new TPM 2 is being used.  
Here's the code where it shows the effect.

int tpm_auto_startup(struct tpm_chip *chip)
{
     int rc;

     if (!(chip->ops->flags & TPM_OPS_AUTO_STARTUP))
         return 0;

     if (chip->flags & TPM_CHIP_FLAG_TPM2)
         rc = tpm2_auto_startup(chip);
     else
         rc = tpm1_auto_startup(chip);

     return rc;
}

In the TPM 2 case we then get timeouts, do the TPM self test, send 
TPM2_STARTUP if necessary and get attributes of the TPM 2 command from 
the device. All necessary to start it up.


https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/tpm2-cmd.c#L719

Does this answer your question ?


    Stefan




>
> Thanks & Regards,
>
>      - Nayna
>

