Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6766E1B2
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jan 2023 16:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjAQPJr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Jan 2023 10:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjAQPJd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Jan 2023 10:09:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5371140BC3;
        Tue, 17 Jan 2023 07:09:29 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HF5oks035847;
        Tue, 17 Jan 2023 15:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dWXZ2e63jmmSSVEE1KNFRF1xjIVGL5WConxn21nLixg=;
 b=rWckHt71ud3lqsuEqRADoGDQPS6q1Ds12mDwdUbBu/4n19FQbCJXoHYrt2pfSwgk4gpM
 rJ0SqlvG8yfQJ7kBroynfSJfoinJTevCHXhx+op0NwSCWL7bqVokGvhMZqakgLx3pMgO
 sAsCJ1BRDDLZfgYFyLhKBHKrE+dDNCgFjsSE95bj/jWRM0brcnhFB9dLvR0t0u//Ug3B
 5IsWXpdtT/vN6/004BMh4KJEbg4RDO9DZfko3PuNctl+WXFLoPQt+uEK1xaGSCDkXjRE
 LuTqek2U/J5l3XFJsR0hetVaQ1GORTPqZGC0EBMl/vsqovFXTOZXw74FWthO5KS05yhN mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5qb62a3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:09:22 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30HEpbBg005234;
        Tue, 17 Jan 2023 15:09:22 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5qb62a2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:09:22 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HF0Ck7005659;
        Tue, 17 Jan 2023 15:09:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n3m17dws0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 15:09:21 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30HF9Jqc38732096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 15:09:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC0FB58056;
        Tue, 17 Jan 2023 15:09:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFC855805E;
        Tue, 17 Jan 2023 15:09:18 +0000 (GMT)
Received: from [9.160.177.68] (unknown [9.160.177.68])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jan 2023 15:09:18 +0000 (GMT)
Message-ID: <e11dfc19-d531-a574-e8f9-abab63398564@linux.ibm.com>
Date:   Tue, 17 Jan 2023 09:09:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] tpm: Add reserved memory event log
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de, joel@jms.id.au
References: <20230103162010.381214-1-eajames@linux.ibm.com>
 <Y8T0VxQiCQH5sDEs@kernel.org>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <Y8T0VxQiCQH5sDEs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 93cufhhzV66qlnb3uzPYv36jr0YaEfmg
X-Proofpoint-ORIG-GUID: wbt_CvqwwwQAP7FXAzT790RIVEpOqTHP
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 bulkscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/16/23 00:53, Jarkko Sakkinen wrote:
> On Tue, Jan 03, 2023 at 10:20:10AM -0600, Eddie James wrote:
>> Some platforms may desire to pass the event log up to linux in the
>> form of a reserved memory region. Add support for this in the TPM
>> core to find the reserved memory region and map it.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Which platforms?
>
> I do not see information of
>
> +	void (*release)(void *ptr);
>
> in the commit message. The description of the implemenation approach is
> missing.


Hi, please see v2 which is a two patch series. I have changed the 
implementation to avoid this release pointer. 
https://patchwork.kernel.org/project/linux-integrity/list/?series=711832


Thanks,

Eddie


>
>
>> ---
>>   drivers/char/tpm/eventlog/of.c | 38 +++++++++++++++++++++++++++++++++-
>>   drivers/char/tpm/tpm-chip.c    |  3 ++-
>>   include/linux/tpm.h            |  1 +
>>   3 files changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
>> index a9ce66d09a75..0455d7f61c10 100644
>> --- a/drivers/char/tpm/eventlog/of.c
>> +++ b/drivers/char/tpm/eventlog/of.c
>> @@ -11,12 +11,48 @@
>>    */
>>   
>>   #include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/ioport.h>
>>   #include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_reserved_mem.h>
>>   #include <linux/tpm_eventlog.h>
>>   
>>   #include "../tpm.h"
>>   #include "common.h"
>>   
>> +static int tpm_read_log_memory_region(struct tpm_chip *chip)
>> +{
>> +	struct device_node *node;
>> +	struct resource res;
>> +	int rc;
>> +
>> +	node = of_parse_phandle(chip->dev.parent->of_node, "memory-region", 0);
>> +	if (!node) {
>> +		dev_info(&chip->dev, "no phandle\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rc = of_address_to_resource(node, 0, &res);
>> +	of_node_put(node);
>> +	if (rc) {
>> +		dev_info(&chip->dev, "no mem\n");
>> +		return rc;
>> +	}
>> +
>> +	chip->log.bios_event_log = memremap(res.start, resource_size(&res), MEMREMAP_WB);
>> +	if (!chip->log.bios_event_log) {
>> +		dev_info(&chip->dev, "err memremap\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	chip->log.release = memunmap;
>> +	chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
>> +
>> +	return chip->flags & TPM_CHIP_FLAG_TPM2 ? EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 :
>> +		EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>> +}
> We do not want to support TPM 1.2 for new features.
>
>> +
>>   int tpm_read_log_of(struct tpm_chip *chip)
>>   {
>>   	struct device_node *np;
>> @@ -38,7 +74,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>>   	sizep = of_get_property(np, "linux,sml-size", NULL);
>>   	basep = of_get_property(np, "linux,sml-base", NULL);
>>   	if (sizep == NULL && basep == NULL)
>> -		return -ENODEV;
>> +		return tpm_read_log_memory_region(chip);
>>   	if (sizep == NULL || basep == NULL)
>>   		return -EIO;
>>   
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index 741d8f3e8fb3..09ea8145d7c6 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -267,7 +267,7 @@ static void tpm_dev_release(struct device *dev)
>>   	idr_remove(&dev_nums_idr, chip->dev_num);
>>   	mutex_unlock(&idr_lock);
>>   
>> -	kfree(chip->log.bios_event_log);
>> +	chip->log.release(chip->log.bios_event_log);
>>   	kfree(chip->work_space.context_buf);
>>   	kfree(chip->work_space.session_buf);
>>   	kfree(chip->allocated_banks);
>> @@ -324,6 +324,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>>   	init_rwsem(&chip->ops_sem);
>>   
>>   	chip->ops = ops;
>> +	chip->log.release = (void(*)(void *))kfree;
> Why do you need this cast?
>
>>   
>>   	mutex_lock(&idr_lock);
>>   	rc = idr_alloc(&dev_nums_idr, NULL, 0, TPM_NUM_DEVICES, GFP_KERNEL);
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index dfeb25a0362d..f1c0b0eb20a5 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -109,6 +109,7 @@ struct tpm_space {
>>   struct tpm_bios_log {
>>   	void *bios_event_log;
>>   	void *bios_event_log_end;
>> +	void (*release)(void *ptr);
>>   };
>>   
>>   struct tpm_chip_seqops {
>> -- 
>> 2.31.1
>>
> BR, Jarkko
