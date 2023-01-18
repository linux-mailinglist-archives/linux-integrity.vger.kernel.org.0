Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2F672076
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 16:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjARPEF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 10:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjARPDY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 10:03:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D219EFC;
        Wed, 18 Jan 2023 07:01:32 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IDQdjx026665;
        Wed, 18 Jan 2023 15:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YkwduTzeC5Q+fT7xYzOubW85Ac+Vr1816b17dJED+P4=;
 b=Zn7fJI/apc8Lt92/rRGegUhc2J3aFxGW9a4HMpU2slf0tTkbx5HKMJtz/TmoZ3g1fsMu
 rMzuEd/IYEJ1f5xP0IpKTbtCsNkLyx0dnaaPBCltxHlTJdAdljTUCOGKyfinWyEk6/Gm
 ceVzbVJO3qdAT+jEd+zOD7xRgeJ51uj9nvN7RzrWlDtqRDJrFjuQqTfZTFCi8c0j3TTS
 QvuOF4na41coe9cWEgfohByztL5qsPGJ+Tu1Y5O4AREQ6/lvvt0HgikPYtPmE9yUxCBs
 uglEvoFdRQhHRVOwYYSWNhEIrE0BsBou+C4WE3xaIr7Oi068HuQtB/P8Tsdwk347bNXc Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6f91wyut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:01:21 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30IEpik0002495;
        Wed, 18 Jan 2023 15:01:20 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6f91wytv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:01:20 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30IEqjda006556;
        Wed, 18 Jan 2023 15:01:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3n3m17nt1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 15:01:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30IF1HHu56426848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 15:01:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E37058057;
        Wed, 18 Jan 2023 15:01:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E12D058065;
        Wed, 18 Jan 2023 15:01:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 15:01:16 +0000 (GMT)
Message-ID: <adced60c-3abe-8f14-9146-e15cee98d5ee@linux.ibm.com>
Date:   Wed, 18 Jan 2023 10:01:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] tpm: Add reserved memory event log
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de
References: <20230113161017.1079299-1-eajames@linux.ibm.com>
 <20230113161017.1079299-3-eajames@linux.ibm.com>
 <d30d23f2-46d0-acfc-4356-49e82b027a9b@linux.ibm.com>
 <3161efa3-2e72-bcc4-95d9-736a55f6535e@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <3161efa3-2e72-bcc4-95d9-736a55f6535e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nIrqjAfx9xC7zPXAHT10nQTfo1vx4y4e
X-Proofpoint-ORIG-GUID: BPFx0nRA3LcwbHr2Rw1oZYeH9ylvnO1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/18/23 09:49, Eddie James wrote:
> 
> On 1/18/23 07:27, Stefan Berger wrote:
>>
>>
>> On 1/13/23 11:10, Eddie James wrote:
>>> Some platforms may desire to pass the event log up to linux in the
>>
>> Which platforms are these that work like this?
> 
> 
> Platforms booting from U-Boot without EFI. So at the moment, IBM's OpenBMC systems hope to use this.

It may be worth to mention this in the patch description in case someone wonders which
systems would take that path.

    Stefan
> 
> Thanks,
> 
> Eddie
> 
> 
>>
>>    Stefan
>>
>>> form of a reserved memory region. Add support for this in the TPM
>>> core to find the reserved memory region and map it.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>>   drivers/char/tpm/eventlog/of.c | 38 +++++++++++++++++++++++++++++++++-
>>>   1 file changed, 37 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
>>> index 741ab2204b11..c815cadf00a4 100644
>>> --- a/drivers/char/tpm/eventlog/of.c
>>> +++ b/drivers/char/tpm/eventlog/of.c
>>> @@ -12,12 +12,48 @@
>>>     #include <linux/device.h>
>>>   #include <linux/slab.h>
>>> +#include <linux/io.h>
>>> +#include <linux/ioport.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_reserved_mem.h>
>>>   #include <linux/tpm_eventlog.h>
>>>     #include "../tpm.h"
>>>   #include "common.h"
>>>   +static int tpm_read_log_memory_region(struct tpm_chip *chip)
>>> +{
>>> +    struct device_node *node;
>>> +    struct resource res;
>>> +    int rc;
>>> +
>>> +    node = of_parse_phandle(chip->dev.parent->of_node, "memory-region", 0);
>>> +    if (!node) {
>>> +        dev_info(&chip->dev, "no phandle\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    rc = of_address_to_resource(node, 0, &res);
>>> +    of_node_put(node);
>>> +    if (rc) {
>>> +        dev_info(&chip->dev, "no mem\n");
>>> +        return rc;
>>> +    }
>>> +
>>> +    chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
>>> +                         MEMREMAP_WB);
>>> +    if (!chip->log.bios_event_log) {
>>> +        dev_info(&chip->dev, "err memremap\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
>>> +
>>> +    return chip->flags & TPM_CHIP_FLAG_TPM2 ? EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 :
>>> +        EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
>>> +}
>>> +
>>>   int tpm_read_log_of(struct tpm_chip *chip)
>>>   {
>>>       struct device_node *np;
>>> @@ -39,7 +75,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>>>       sizep = of_get_property(np, "linux,sml-size", NULL);
>>>       basep = of_get_property(np, "linux,sml-base", NULL);
>>>       if (sizep == NULL && basep == NULL)
>>> -        return -ENODEV;
>>> +        return tpm_read_log_memory_region(chip);
>>>       if (sizep == NULL || basep == NULL)
>>>           return -EIO;
