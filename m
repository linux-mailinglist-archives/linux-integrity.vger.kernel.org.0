Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8124B682FAC
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 15:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAaOtW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 09:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjAaOtR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 09:49:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828218B36;
        Tue, 31 Jan 2023 06:49:09 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VDFF2K021574;
        Tue, 31 Jan 2023 14:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TRDtapeBXXxtYB+Zw5r/qRo4BG/ybRq1Zq9gzcJUADY=;
 b=O76487c/ei1cxJB0H21HrP9pNmzPtst+OpABXhSWJd65vaQZkPEjgKReYaVFFZQ7vtsx
 9EGvlJZEx/LmaBwN0GgnPIq7z6iNa5As8Ji1afJZzJXeXckJKAlM9wLsGshdxAKdrUSJ
 PZ2dJkGtCteNqIqbc4UBFAaYPc6hjh4f3pc3qDtbyHsHmxoVq6Qxbgvbhp5Mdk04VAXT
 E8zwUCiSjoM6hAqxBUc5qCKuN3Eh7SENvyM6E+RWektH/qKLvu/wTwb7Cq3g7AeOLhl5
 LmQK/78J++isclYo0MOfXByfkgintleZc6VSjquCgIpzxNLNDNAkgqoM6VAyC8T2gnnZ 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3q7te86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 14:48:58 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VECZ3r013224;
        Tue, 31 Jan 2023 14:48:58 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3q7te7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 14:48:57 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VDdr0T008520;
        Tue, 31 Jan 2023 14:48:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw2mmft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 14:48:55 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VEmsf837749206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 14:48:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D62658058;
        Tue, 31 Jan 2023 14:48:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6E6B58054;
        Tue, 31 Jan 2023 14:48:52 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 14:48:52 +0000 (GMT)
Message-ID: <fa04bca6-23c4-d5e9-c1dc-468bd9bcd8f9@linux.ibm.com>
Date:   Tue, 31 Jan 2023 09:48:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 05/25] powerpc/secvar: Warn and error if multiple
 secvar ops are set
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-6-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-6-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -PKkExnNQjocgjTkV335iOcEUV_46i9Z
X-Proofpoint-GUID: gNRO77ddtui0AkIPMyxCxs_fGTZBlADp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
> 
> The secvar code only supports one consumer at a time.
> 
> Multiple consumers aren't possible at this point in time, but we'd want
> it to be obvious if it ever could happen.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> ---
> 
> v4: Return an error and don't actually try to set secvar_operations if the
>      warning is triggered (npiggin)
> 
> v5: Drop "extern" to fix a checkpatch check (snowpatch)
> ---
>   arch/powerpc/include/asm/secvar.h            | 4 ++--
>   arch/powerpc/kernel/secvar-ops.c             | 8 ++++++--
>   arch/powerpc/platforms/powernv/opal-secvar.c | 4 +---
>   3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
> index 07ba36f868a7..a2b5f2203dc5 100644
> --- a/arch/powerpc/include/asm/secvar.h
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -21,11 +21,11 @@ struct secvar_operations {
>   
>   #ifdef CONFIG_PPC_SECURE_BOOT
>   
> -extern void set_secvar_ops(const struct secvar_operations *ops);
> +int set_secvar_ops(const struct secvar_operations *ops);
>   
>   #else
>   
> -static inline void set_secvar_ops(const struct secvar_operations *ops) { }
> +static inline int set_secvar_ops(const struct secvar_operations *ops) { return 0; }
>   
>   #endif
>   
> diff --git a/arch/powerpc/kernel/secvar-ops.c b/arch/powerpc/kernel/secvar-ops.c
> index 6a29777d6a2d..9c8dd4e7c270 100644
> --- a/arch/powerpc/kernel/secvar-ops.c
> +++ b/arch/powerpc/kernel/secvar-ops.c
> @@ -8,10 +8,14 @@
>   
>   #include <linux/cache.h>
>   #include <asm/secvar.h>
> +#include <asm/bug.h>
>   
> -const struct secvar_operations *secvar_ops __ro_after_init;
> +const struct secvar_operations *secvar_ops __ro_after_init = NULL;
>   
> -void set_secvar_ops(const struct secvar_operations *ops)
> +int set_secvar_ops(const struct secvar_operations *ops)
>   {
> +	if (WARN_ON_ONCE(secvar_ops))
> +		return -1;

The calling function  opal_secvar_probe() returns an errno (-ENODEV for example). Return also an errno here?

>   	secvar_ops = ops;
> +	return 0;
>   }
> diff --git a/arch/powerpc/platforms/powernv/opal-secvar.c b/arch/powerpc/platforms/powernv/opal-secvar.c
> index ef89861569e0..4c0a3b030fe0 100644
> --- a/arch/powerpc/platforms/powernv/opal-secvar.c
> +++ b/arch/powerpc/platforms/powernv/opal-secvar.c
> @@ -113,9 +113,7 @@ static int opal_secvar_probe(struct platform_device *pdev)
>   		return -ENODEV;


This is the errno.
>   	}
>   
> -	set_secvar_ops(&opal_secvar_ops);
> -
> -	return 0;
> +	return set_secvar_ops(&opal_secvar_ops);

    Stefan
