Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BF6831E8
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 16:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjAaPyX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 10:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAaPyW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 10:54:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA5B3402B;
        Tue, 31 Jan 2023 07:54:21 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VFHxZI012741;
        Tue, 31 Jan 2023 15:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xU8BpF5sLLcX15OpEtEfyQ9Jy3K+3ENin2AexJDa7wQ=;
 b=JY2NVr3GhJ5RagpbxVCJkUqkLVxduj4meF/9KjyFjcNjr4mKcuJkhrG7/f240tywDsHU
 eqHPAsmt/5X8jQOZ8lwNYwnJKJxNAoX4dHB8nZNWtD5WSLky9LnsrJjY5FsoAWb19/DB
 lkowYKaNja667wxOI965187H3C/hPVkafS8Q2HrNY3EQyU0FCW45/sk4JQuKCTgYqcZN
 nC56HEcIb80P4U8ARMUV4o/GNSVjOSpNWoQn8NboY6JAXEgLc4NEP9EiXW2bewB5pqfs
 0o2q9LezgyWDrDtty++hvE2oOmS9fy4ioEuj3ql1zwv/7TqIxqprUBVCraOWGbQ0O026 hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3xjbw9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:54:11 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VFirRp007376;
        Tue, 31 Jan 2023 15:54:11 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3xjbw96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:54:11 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VFZfvo028510;
        Tue, 31 Jan 2023 15:54:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ncvuygta6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:54:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VFs8cp33030516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:54:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F13758058;
        Tue, 31 Jan 2023 15:54:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA36358059;
        Tue, 31 Jan 2023 15:54:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 15:54:07 +0000 (GMT)
Message-ID: <574522c3-3fc3-2c89-dfeb-587b9d7cd32c@linux.ibm.com>
Date:   Tue, 31 Jan 2023 10:54:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 11/25] powerpc/secvar: Allow backend to populate static
 list of variable names
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-12-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-12-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e-XYZajuYaGSfAUEL3QNH1MVaeIWIELE
X-Proofpoint-GUID: sy9HBSIV6Psy5TBiiQD7wBPvDleTt6lU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> Currently, the list of variables is populated by calling
> secvar_ops->get_next() repeatedly, which is explicitly modelled on the
> OPAL API (including the keylen parameter).
> 
> For the upcoming PLPKS backend, we have a static list of variable names.
> It is messy to fit that into get_next(), so instead, let the backend put
> a NULL-terminated array of variable names into secvar_ops->var_names,
> which will be used if get_next() is undefined.
> 
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> 
> ---
> 
> v3: New patch (ajd/mpe)
> ---
>   arch/powerpc/include/asm/secvar.h  |  4 ++
>   arch/powerpc/kernel/secvar-sysfs.c | 67 ++++++++++++++++++++----------
>   2 files changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
> index 011a53a8076c..4828e0ab7e3c 100644
> --- a/arch/powerpc/include/asm/secvar.h
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -21,6 +21,10 @@ struct secvar_operations {
>   	ssize_t (*format)(char *buf, size_t bufsize);
>   	int (*max_size)(u64 *max_size);
>   	const struct attribute **config_attrs;
> +
> +	// NULL-terminated array of fixed variable names
> +	// Only used if get_next() isn't provided
> +	const char * const *var_names;
>   };
>   
>   #ifdef CONFIG_PPC_SECURE_BOOT
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> index 7df32be86507..2cbc60b37e4e 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -157,9 +157,31 @@ static int secvar_sysfs_config(struct kobject *kobj)
>   	return 0;
>   }
>   
> -static int secvar_sysfs_load(void)
> +static int add_var(const char *name)
>   {
>   	struct kobject *kobj;
> +	int rc;
> +
> +	kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
> +	if (!kobj)
> +		return -ENOMEM;
> +
> +	kobject_init(kobj, &secvar_ktype);
> +
> +	rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
> +	if (rc) {
> +		pr_warn("kobject_add error %d for attribute: %s\n", rc,
> +			name);
> +		kobject_put(kobj);
> +		return rc;
> +	}
> +
> +	kobject_uevent(kobj, KOBJ_ADD);
> +	return 0;
> +}
> +
> +static int secvar_sysfs_load(void)
> +{
>   	u64 namesize = 0;
>   	char *name;
>   	int rc;
> @@ -179,31 +201,26 @@ static int secvar_sysfs_load(void)
>   			break;
>   		}
>   
> -		kobj = kzalloc(sizeof(*kobj), GFP_KERNEL);
> -		if (!kobj) {
> -			rc = -ENOMEM;
> -			break;
> -		}
> -
> -		kobject_init(kobj, &secvar_ktype);
> -
> -		rc = kobject_add(kobj, &secvar_kset->kobj, "%s", name);
> -		if (rc) {
> -			pr_warn("kobject_add error %d for attribute: %s\n", rc,
> -				name);
> -			kobject_put(kobj);
> -			kobj = NULL;
> -		}
> -
> -		if (kobj)
> -			kobject_uevent(kobj, KOBJ_ADD);
> -
> +		rc = add_var(name);
>   	} while (!rc);
>   
>   	kfree(name);
>   	return rc;
>   }
>   
> +static int secvar_sysfs_load_static(void)
> +{
> +	const char * const *name_ptr = secvar_ops->var_names;
> +	int rc;

Missing newline ?

> +	while (*name_ptr) {
> +		rc = add_var(*name_ptr);
> +		if (rc)
> +			return rc;
> +		name_ptr++;
> +	}
> +	return 0;
> +}
> +
>   static int secvar_sysfs_init(void)
>   {
>   	int rc;
> @@ -245,7 +262,15 @@ static int secvar_sysfs_init(void)
>   		goto err;
>   	}
>   
> -	secvar_sysfs_load();
> +	if (secvar_ops->get_next)
> +		rc = secvar_sysfs_load();
> +	else
> +		rc = secvar_sysfs_load_static();
> +
> +	if (rc) {
> +		pr_err("Failed to create variable attributes\n");
> +		goto err;
> +	}
>   
>   	return 0;
>   err:

With the above change:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
