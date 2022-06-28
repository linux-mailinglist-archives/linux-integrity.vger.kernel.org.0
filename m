Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78F55E49F
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jun 2022 15:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbiF1Nbg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jun 2022 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbiF1Nai (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jun 2022 09:30:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474264C1;
        Tue, 28 Jun 2022 06:30:02 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SD1ZL3011915;
        Tue, 28 Jun 2022 13:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FNQemyB/OW0nWHwzGNJkEHsB83P2tTckEJpnuaiqO7U=;
 b=EpWM1uaQ/DOrfOsliXHvUCm9G32BotfF9QYQO3ixauF8Cpxr9HIM67f5HIkYoN6kO7ws
 B50BED37E/khCBktxNYgc1qokcK/9/BpJNCksEDNG3fjbpKL2pL+1t/MTZtPrtFavTJj
 XqhHklSuN4x8UEQLVgbhwAUay0Ntu43kLYp3pQv61mVSseCo+TnsNDgIRhFPaxhiPziR
 OYaccrNOgUkxZ3COcLQ5zEqKrSth6wIew3BfsSucDPzKZDFqj78qNNNmeOwQh7VkvdqJ
 qGMHSQX8AZTN+O+OB2df2SQJlqeKHWIZ2rZH8xFzQn/bzPVLURjwZHXzsz5DNKMmpucM Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h025sh8na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 13:29:52 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25SD1wPx015765;
        Tue, 28 Jun 2022 13:29:51 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h025sh8ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 13:29:51 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SDJtvh013165;
        Tue, 28 Jun 2022 13:29:50 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3gwt0a13jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 13:29:50 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SDTnI214025152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 13:29:49 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B19DBE053;
        Tue, 28 Jun 2022 13:29:49 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5602BE04F;
        Tue, 28 Jun 2022 13:29:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 28 Jun 2022 13:29:48 +0000 (GMT)
Message-ID: <170c78f7-f0ba-c186-dacf-55759dae9b83@linux.ibm.com>
Date:   Tue, 28 Jun 2022 09:29:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/3] tpm: of: Move of-tree specific code from tpm
 driver into of driver
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Frank Rowand <frowand.list@gmail.com>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
 <20220616154130.2052541-2-stefanb@linux.ibm.com>
 <20220627224325.GB3082294-robh@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220627224325.GB3082294-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ejAW8MjeayEDOFS4zHLIlz_R7LRBy4JK
X-Proofpoint-ORIG-GUID: MGZzN5PnmhnegDiOa0wS5Ex5fN_GJmaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_07,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/27/22 18:43, Rob Herring wrote:
> On Thu, Jun 16, 2022 at 11:41:28AM -0400, Stefan Berger wrote:
>> Simplify tpm_read_log_of() by moving Openfirmware-specific code into
>> the Openfirmware driver to make the code reusable. Call the new
> 
> There is no such 'Openfirmware driver'.
> 
>> of_tpm_get_sml_parameters() function from the TPM Openfirmware driver.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Frank Rowand <frowand.list@gmail.com>
>> ---
>>   drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
>>   drivers/of/Makefile            |  2 +-
>>   drivers/of/device_node.c       | 27 +++++++++++++++++++++++++++
> 
> Humm, definitely the wrong direction. Generally, code for specific
> bindings does not go in drivers/of/. There used to be some, but we've
> moved it to the appropriate subsystems. kexec was an exception to not
> have 2 copies of the same code in arch/.

The function I am moving here is called by the TPM subsystem and also 
now by of/kexec.c. The latter is compiled under the following conditions:

ifdef CONFIG_KEXEC_FILE
ifdef CONFIG_OF_FLATTREE
obj-y	+= kexec.o
endif
endif

The code that current calls it is compiled under the following conditions:

tpm-$(CONFIG_OF) += eventlog/of.o

To make it available to both I could keep it in the TPM subsystem like this:

obj-$(CONFIG_OF) = tpm_of.o


Jarrko, if you read this, any comment?


    Stefan


> 
>>   include/linux/of_device_node.h |  9 +++++++++
> 
> of_tpm.h would be the right name assuming we kept this structure which
> we shouldn't. Probably linux/tpm.h? Just a guess, I'm not familar with
> the TPM code really.
> 
> 
>>   4 files changed, 42 insertions(+), 27 deletions(-)
>>   create mode 100644 drivers/of/device_node.c
>>   create mode 100644 include/linux/of_device_node.h
>>
>> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
>> index a9ce66d09a75..5b18f4333ad1 100644
>> --- a/drivers/char/tpm/eventlog/of.c
>> +++ b/drivers/char/tpm/eventlog/of.c
>> @@ -12,6 +12,7 @@
>>   
>>   #include <linux/slab.h>
>>   #include <linux/of.h>
>> +#include <linux/of_device_node.h>
>>   #include <linux/tpm_eventlog.h>
>>   
>>   #include "../tpm.h"
>> @@ -20,11 +21,10 @@
>>   int tpm_read_log_of(struct tpm_chip *chip)
>>   {
>>   	struct device_node *np;
>> -	const u32 *sizep;
>> -	const u64 *basep;
>>   	struct tpm_bios_log *log;
>>   	u32 size;
>>   	u64 base;
>> +	int ret;
>>   
>>   	log = &chip->log;
>>   	if (chip->dev.parent && chip->dev.parent->of_node)
>> @@ -35,30 +35,9 @@ int tpm_read_log_of(struct tpm_chip *chip)
>>   	if (of_property_read_bool(np, "powered-while-suspended"))
>>   		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
>>   
>> -	sizep = of_get_property(np, "linux,sml-size", NULL);
>> -	basep = of_get_property(np, "linux,sml-base", NULL);
>> -	if (sizep == NULL && basep == NULL)
>> -		return -ENODEV;
>> -	if (sizep == NULL || basep == NULL)
>> -		return -EIO;
>> -
>> -	/*
>> -	 * For both vtpm/tpm, firmware has log addr and log size in big
>> -	 * endian format. But in case of vtpm, there is a method called
>> -	 * sml-handover which is run during kernel init even before
>> -	 * device tree is setup. This sml-handover function takes care
>> -	 * of endianness and writes to sml-base and sml-size in little
>> -	 * endian format. For this reason, vtpm doesn't need conversion
>> -	 * but physical tpm needs the conversion.
>> -	 */
>> -	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
>> -	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
>> -		size = be32_to_cpup((__force __be32 *)sizep);
>> -		base = be64_to_cpup((__force __be64 *)basep);
>> -	} else {
>> -		size = *sizep;
>> -		base = *basep;
>> -	}
>> +	ret = of_tpm_get_sml_parameters(np, &base, &size);
>> +	if (ret < 0)
>> +		return ret;
>>   
>>   	if (size == 0) {
>>   		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index e0360a44306e..1c9feac450ad 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -obj-y = base.o device.o platform.o property.o
>> +obj-y = base.o device.o platform.o property.o device_node.o
>>   obj-$(CONFIG_OF_KOBJ) += kobj.o
>>   obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>>   obj-$(CONFIG_OF_FLATTREE) += fdt.o
>> diff --git a/drivers/of/device_node.c b/drivers/of/device_node.c
>> new file mode 100644
>> index 000000000000..71a19bc1bac2
>> --- /dev/null
>> +++ b/drivers/of/device_node.c
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/export.h>
>> +#include <linux/of_device_node.h>
>> +
>> +int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size)
>> +{
>> +	const u32 *sizep;
>> +	const u64 *basep;
>> +
>> +	sizep = of_get_property(np, "linux,sml-size", NULL);
>> +	basep = of_get_property(np, "linux,sml-base", NULL);
>> +	if (sizep == NULL && basep == NULL)
>> +		return -ENODEV;
>> +	if (sizep == NULL || basep == NULL)
>> +		return -EIO;
>> +
>> +	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
>> +	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
>> +		*size = be32_to_cpup((__force __be32 *)sizep);
>> +		*base = be64_to_cpup((__force __be64 *)basep);
>> +	} else {
>> +		*size = *sizep;
>> +		*base = *basep;
>> +	}
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_tpm_get_sml_parameters);
>> diff --git a/include/linux/of_device_node.h b/include/linux/of_device_node.h
>> new file mode 100644
>> index 000000000000..ae3faf023aab
>> --- /dev/null
>> +++ b/include/linux/of_device_node.h
>> @@ -0,0 +1,9 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_OF_DEVICE_NODE_H
>> +#define _LINUX_OF_DEVICE_NODE_H
>> +
>> +#include <linux/of.h>
>> +
>> +int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size);
>> +
>> +#endif /* _LINUX_OF_DEVICE_NODE_H */
>> -- 
>> 2.35.1
>>
>>
