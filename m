Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027E36831D1
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 16:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjAaPtw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 10:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAaPtv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 10:49:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55AC18168;
        Tue, 31 Jan 2023 07:49:49 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEjBul029047;
        Tue, 31 Jan 2023 15:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=o/mHRBcLaJ60ur4maF29Xi6uQ8jBvLv5l7cqFVKMfk4=;
 b=DXAw7w1+ouz4uI2hzY0uwgtiC0RdU9VNM7/786icl81UH9AIAhsKt0W4a+xQXrk9h4lz
 wSmuctXG3kqEFnbQaxvTPZOOmiMDyYd/3/V8g5j+Ut2WoJCZP+QFAQ0TaRWEu0LbcH7V
 Zg1pKa/fR3bX/LDbWCKjytr+SIkDMS3ulALh7NVORbCUOSeNSEr6zhC5T64bZENT2UMc
 2KlOZ1Wqv3NQFzamxt7iw91/zCYDItLq6UiINfuF/nLQs5ftKzOyKicvdY+lC7ZdUQ8l
 EaA9xfvgr6fZjUzrMW+u5zfSuZrwnOPFZL35RiCoIHEZZI1ddfaUV7Ax6hBlHYH/wynh qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf519squf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:49:39 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VFnYKX004633;
        Tue, 31 Jan 2023 15:49:39 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf519squ8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:49:39 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VFf8ua007760;
        Tue, 31 Jan 2023 15:49:38 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtert18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:49:38 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VFnbxA12387010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:49:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E7ED5805B;
        Tue, 31 Jan 2023 15:49:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3E8A5805C;
        Tue, 31 Jan 2023 15:49:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 15:49:35 +0000 (GMT)
Message-ID: <aac15eb0-ca25-5012-6346-86a89ec461ac@linux.ibm.com>
Date:   Tue, 31 Jan 2023 10:49:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 10/25] powerpc/secvar: Extend sysfs to include config
 vars
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-11-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-11-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jW1wSN4d1F4T6Se--m6havXEtaqCI7EQ
X-Proofpoint-GUID: W8jG_Wnur3hspHNv4L2HpQ4uMkI6t0G7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
> 
> The forthcoming pseries consumer of the secvar API wants to expose a
> number of config variables.  Allowing secvar implementations to provide
> their own sysfs attributes makes it easy for consumers to expose what
> they need to.
> 
> This is not being used by the OPAL secvar implementation at present, and
> the config directory will not be created if no attributes are set.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> 
> ---
> 
> v3: Remove unnecessary "secvar:" prefix from error messages (ajd)
> 
>      Merge config attributes into secvar_operations (mpe)
> ---
>   arch/powerpc/include/asm/secvar.h  |  2 ++
>   arch/powerpc/kernel/secvar-sysfs.c | 33 +++++++++++++++++++++++++-----
>   2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
> index bf396215903d..011a53a8076c 100644
> --- a/arch/powerpc/include/asm/secvar.h
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -10,6 +10,7 @@
>   
>   #include <linux/types.h>
>   #include <linux/errno.h>
> +#include <linux/sysfs.h>
>   
>   extern const struct secvar_operations *secvar_ops;
>   
> @@ -19,6 +20,7 @@ struct secvar_operations {
>   	int (*set)(const char *key, u64 key_len, u8 *data, u64 data_size);
>   	ssize_t (*format)(char *buf, size_t bufsize);
>   	int (*max_size)(u64 *max_size);
> +	const struct attribute **config_attrs;
>   };
>   
>   #ifdef CONFIG_PPC_SECURE_BOOT
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> index 8f3deff94009..7df32be86507 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -144,6 +144,19 @@ static int update_kobj_size(void)
>   	return 0;
>   }
>   
> +static int secvar_sysfs_config(struct kobject *kobj)
> +{
> +	struct attribute_group config_group = {
> +		.name = "config",
> +		.attrs = (struct attribute **)secvar_ops->config_attrs,
> +	};
> +
> +	if (secvar_ops->config_attrs)
> +		return sysfs_create_group(kobj, &config_group);
> +
> +	return 0;
> +}
> +
>   static int secvar_sysfs_load(void)
>   {
>   	struct kobject *kobj;
> @@ -208,26 +221,36 @@ static int secvar_sysfs_init(void)
>   
>   	rc = sysfs_create_file(secvar_kobj, &format_attr.attr);
>   	if (rc) {
> -		kobject_put(secvar_kobj);
> -		return -ENOMEM;
> +		pr_err("Failed to create format object\n");
> +		rc = -ENOMEM;
> +		goto err;
>   	}
>   
>   	secvar_kset = kset_create_and_add("vars", NULL, secvar_kobj);
>   	if (!secvar_kset) {
>   		pr_err("sysfs kobject registration failed\n");
> -		kobject_put(secvar_kobj);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto err;
>   	}
>   
>   	rc = update_kobj_size();
>   	if (rc) {
>   		pr_err("Cannot read the size of the attribute\n");
> -		return rc;
> +		goto err;
> +	}
> +
> +	rc = secvar_sysfs_config(secvar_kobj);
> +	if (rc) {
> +		pr_err("Failed to create config directory\n");
> +		goto err;
>   	}
>   
>   	secvar_sysfs_load();
>   
>   	return 0;
> +err:
> +	kobject_put(secvar_kobj);
> +	return rc;
>   }
>   
>   late_initcall(secvar_sysfs_init);
