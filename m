Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E9671E9A
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Jan 2023 14:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjARN4p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 08:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjARN4Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 08:56:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6094E50C;
        Wed, 18 Jan 2023 05:27:54 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IC9YAU023085;
        Wed, 18 Jan 2023 13:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=h8QKC9HBsZ2WVliqH8imjRco0PuJfspcpxoo1zsNtVE=;
 b=mx/d8yWMiE6S50H3T36223LS1iesd+OPxFaAE98FOgwrqDDKqJFbOvWHp1xS9RmhcC1m
 bz0aHVXPJ3fON7IByG2KQDA6vQ3xo4YoYtsih3tA0X9+ubhII6t+9HDwtOCgtoNRDTNA
 vUb8OP20e6ZROWM0VjNRjbexErnRe/8d5ANW2+guWRvYuqK4UPJ8ZeAFLuljdi2SOPIg
 qLDn1fcr1eMcFjk77r8WlDfdWDJq3Fff3DFGyZ3Yx6r/W61qqkd/92WwWlddvlcPYca4
 ThJFsWzcZoTLSCCip0r7TWL3OjpPyghDu5MN6kr4xf1QZo6Iu+M88L6qJbQjYP1cgRD2 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6gh79v8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 13:27:51 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30ICt57m014116;
        Wed, 18 Jan 2023 13:27:51 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6gh79v8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 13:27:51 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30ICTpsF009766;
        Wed, 18 Jan 2023 13:27:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n3m17w9fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 13:27:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30IDRmb97799342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 13:27:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68D5358053;
        Wed, 18 Jan 2023 13:27:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA1D858043;
        Wed, 18 Jan 2023 13:27:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 13:27:47 +0000 (GMT)
Message-ID: <d30d23f2-46d0-acfc-4356-49e82b027a9b@linux.ibm.com>
Date:   Wed, 18 Jan 2023 08:27:47 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230113161017.1079299-3-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ooca7sjD3K_a790sg7sDX5mPBW6zs6zE
X-Proofpoint-GUID: xxnsxAvXmht50VRNwlVhMPSMYt4BwMJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/13/23 11:10, Eddie James wrote:
> Some platforms may desire to pass the event log up to linux in the

Which platforms are these that work like this?

    Stefan

> form of a reserved memory region. Add support for this in the TPM
> core to find the reserved memory region and map it.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   drivers/char/tpm/eventlog/of.c | 38 +++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
> index 741ab2204b11..c815cadf00a4 100644
> --- a/drivers/char/tpm/eventlog/of.c
> +++ b/drivers/char/tpm/eventlog/of.c
> @@ -12,12 +12,48 @@
>   
>   #include <linux/device.h>
>   #include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>   #include <linux/tpm_eventlog.h>
>   
>   #include "../tpm.h"
>   #include "common.h"
>   
> +static int tpm_read_log_memory_region(struct tpm_chip *chip)
> +{
> +	struct device_node *node;
> +	struct resource res;
> +	int rc;
> +
> +	node = of_parse_phandle(chip->dev.parent->of_node, "memory-region", 0);
> +	if (!node) {
> +		dev_info(&chip->dev, "no phandle\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = of_address_to_resource(node, 0, &res);
> +	of_node_put(node);
> +	if (rc) {
> +		dev_info(&chip->dev, "no mem\n");
> +		return rc;
> +	}
> +
> +	chip->log.bios_event_log = devm_memremap(&chip->dev, res.start, resource_size(&res),
> +						 MEMREMAP_WB);
> +	if (!chip->log.bios_event_log) {
> +		dev_info(&chip->dev, "err memremap\n");
> +		return -ENOMEM;
> +	}
> +
> +	chip->log.bios_event_log_end = chip->log.bios_event_log + resource_size(&res);
> +
> +	return chip->flags & TPM_CHIP_FLAG_TPM2 ? EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 :
> +		EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
> +}
> +
>   int tpm_read_log_of(struct tpm_chip *chip)
>   {
>   	struct device_node *np;
> @@ -39,7 +75,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
>   	sizep = of_get_property(np, "linux,sml-size", NULL);
>   	basep = of_get_property(np, "linux,sml-base", NULL);
>   	if (sizep == NULL && basep == NULL)
> -		return -ENODEV;
> +		return tpm_read_log_memory_region(chip);
>   	if (sizep == NULL || basep == NULL)
>   		return -EIO;
>   
