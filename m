Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA967BA33
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjAYTGl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 14:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjAYTGl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 14:06:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B6B1632C;
        Wed, 25 Jan 2023 11:06:39 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PIY4pF025566;
        Wed, 25 Jan 2023 19:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DVwlzLV2T29P7gprHZbGZtg1DcnRIAcFqM7GJEKAGpU=;
 b=kSyx7vgJGFpPef0bJMRinWEWC/UJGTdxDSw7BB4UgDiQ0ABjJtbJ3CeAt3Vc+PPgCbvq
 ZzCf1kJaEvVyMa4Byx6S+/57k6nwaQMMobVSy3hGxxs73jDILB1KQzm0eisxl2wJnWHI
 uuULMznAa1ox3PlX8fg9f3+Qe4IyRZ+n100AoG5pgTKLuDuCWEJGXGF7+u3fbcy/7MQb
 F7GQQMgiZtQMGgCge03jZah+Wn6az8JVSja91iEW1aAPPT64nnkrvlg2ASOlNGth4RlA
 ZhPf9Dn3z6E91QtN1/Cy6cwnGw61wPFFG2V693pEG8hm5mJsEQbJPLvfVubNysp6SMVq gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb6c278xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:06:35 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PIZHHp030702;
        Wed, 25 Jan 2023 19:06:34 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nb6c278x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:06:34 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGvRPL026121;
        Wed, 25 Jan 2023 19:06:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n87p7qt7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:06:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PJ6WgQ5112450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 19:06:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD4CA5805D;
        Wed, 25 Jan 2023 19:06:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FB9D58052;
        Wed, 25 Jan 2023 19:06:32 +0000 (GMT)
Received: from [9.77.150.21] (unknown [9.77.150.21])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 19:06:32 +0000 (GMT)
Message-ID: <ea8e873f-c052-832f-b4a5-0164f5cd6947@linux.ibm.com>
Date:   Wed, 25 Jan 2023 13:06:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] tpm: Use managed allocation for bios event log
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
 <20230113161017.1079299-2-eajames@linux.ibm.com>
 <Y8stxF+2XfSFN9wt@kernel.org>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <Y8stxF+2XfSFN9wt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T6A9xfNJnEVRkynLF-Y43ofkEd09sGDC
X-Proofpoint-ORIG-GUID: re6FPotWPEwYgrB2ynSS9UBm95LPrkRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_12,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301250165
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/20/23 18:11, Jarkko Sakkinen wrote:
> On Fri, Jan 13, 2023 at 10:10:16AM -0600, Eddie James wrote:
>> Since the bios event log is freed in the device release function,
>> let devres handle the deallocation. This will allow other memory
>> allocation/mapping functions to be used for the bios event log.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/char/tpm/eventlog/acpi.c |  5 +++--
>>   drivers/char/tpm/eventlog/efi.c  | 13 +++++++------
>>   drivers/char/tpm/eventlog/of.c   |  3 ++-
>>   drivers/char/tpm/tpm-chip.c      |  1 -
>>   4 files changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
>> index 0913d3eb8d51..40360e599bc3 100644
>> --- a/drivers/char/tpm/eventlog/acpi.c
>> +++ b/drivers/char/tpm/eventlog/acpi.c
>> @@ -14,6 +14,7 @@
>>    * Access to the event log extended by the TCG BIOS of PC platform
>>    */
>>   
>> +#include <linux/device.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/fs.h>
>>   #include <linux/security.h>
>> @@ -135,7 +136,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>>   	}
>>   
>>   	/* malloc EventLog space */
>> -	log->bios_event_log = kmalloc(len, GFP_KERNEL);
>> +	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
>>   	if (!log->bios_event_log)
>>   		return -ENOMEM;
>>   
>> @@ -160,7 +161,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>>   	return format;
>>   
>>   err:
>> -	kfree(log->bios_event_log);
>> +	devm_kfree(&chip->dev, log->bios_event_log);
> I wonder do we want to do devm_kfree's at all as the memory is freed during
> detach, i.e. taken care by devres.


I think we should since the chip/tpm driver will continue to probe 
without the bios event log. Therefore that memory will be wasted if 
there is some error during bios log setup.


Thanks,

Eddie


>
>>   	log->bios_event_log = NULL;
>>   	return ret;
>>   }
>> diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
>> index e6cb9d525e30..4e9d7c2bf32e 100644
>> --- a/drivers/char/tpm/eventlog/efi.c
>> +++ b/drivers/char/tpm/eventlog/efi.c
>> @@ -6,6 +6,7 @@
>>    *      Thiebaud Weksteen <tweek@google.com>
>>    */
>>   
>> +#include <linux/device.h>
>>   #include <linux/efi.h>
>>   #include <linux/tpm_eventlog.h>
>>   
>> @@ -55,7 +56,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>>   	}
>>   
>>   	/* malloc EventLog space */
>> -	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
>> +	log->bios_event_log = devm_kmemdup(&chip->dev, log_tbl->log, log_size, GFP_KERNEL);
>>   	if (!log->bios_event_log) {
>>   		ret = -ENOMEM;
>>   		goto out;
>> @@ -76,7 +77,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>>   			     MEMREMAP_WB);
>>   	if (!final_tbl) {
>>   		pr_err("Could not map UEFI TPM final log\n");
>> -		kfree(log->bios_event_log);
>> +		devm_kfree(&chip->dev, log->bios_event_log);
>>   		ret = -ENOMEM;
>>   		goto out;
>>   	}
>> @@ -91,11 +92,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>>   	 * Allocate memory for the 'combined log' where we will append the
>>   	 * 'final events log' to.
>>   	 */
>> -	tmp = krealloc(log->bios_event_log,
>> -		       log_size + final_events_log_size,
>> -		       GFP_KERNEL);
>> +	tmp = devm_krealloc(&chip->dev, log->bios_event_log,
>> +			    log_size + final_events_log_size,
>> +			    GFP_KERNEL);
>>   	if (!tmp) {
>> -		kfree(log->bios_event_log);
>> +		devm_kfree(&chip->dev, log->bios_event_log);
>>   		ret = -ENOMEM;
>>   		goto out;
>>   	}
>> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
>> index a9ce66d09a75..741ab2204b11 100644
>> --- a/drivers/char/tpm/eventlog/of.c
>> +++ b/drivers/char/tpm/eventlog/of.c
>> @@ -10,6 +10,7 @@
>>    * Read the event log created by the firmware on PPC64
>>    */
>>   
>> +#include <linux/device.h>
>>   #include <linux/slab.h>
>>   #include <linux/of.h>
>>   #include <linux/tpm_eventlog.h>
>> @@ -65,7 +66,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>>   		return -EIO;
>>   	}
>>   
>> -	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
>> +	log->bios_event_log = devm_kmemdup(&chip->dev, __va(base), size, GFP_KERNEL);
>>   	if (!log->bios_event_log)
>>   		return -ENOMEM;
>>   
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 741d8f3e8fb3..b99f55f2d4fd 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -267,7 +267,6 @@ static void tpm_dev_release(struct device *dev)
>>   	idr_remove(&dev_nums_idr, chip->dev_num);
>>   	mutex_unlock(&idr_lock);
>>   
>> -	kfree(chip->log.bios_event_log);
>>   	kfree(chip->work_space.context_buf);
>>   	kfree(chip->work_space.session_buf);
>>   	kfree(chip->allocated_banks);
>> -- 
>> 2.31.1
>>
> BR, Jarkko
