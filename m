Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FFC6832E5
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 17:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjAaQlO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 11:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjAaQlK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 11:41:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7991218164;
        Tue, 31 Jan 2023 08:41:09 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VG06rx003415;
        Tue, 31 Jan 2023 16:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pJvoL5V/+GcwknrQBp7a7hc0Ze1gkZySLeaW30LrKYs=;
 b=lIn+UJpnSeBL2m9/dUvSQdJnRJvAt1sKxPyfXSPJx/dQsJe4JAYonwP2Cl9fgHl/ho2C
 vZTZMbOoblQLopJlUm7wR2H/RzrSR/br94TLcK+kf/MmoIOBPC0oiQiCXRafjjRNH4j7
 T9z50T53UZF94LwcZRsSkSZlULg/sLN1FP54DtWJDp1HQEGzn3pSoUfHfhy2gAohT0Vx
 +i8K4RTqErGVqC+9SKGE2Zv728d8vrh9axdxMHR5aDFVbMudqSf533CaCUSFSK8nHZBK
 QfrQ7h0QDdd9qG/LM7QCRCTIOFiiccN3NBSbRSwVqSujMLTYljQ1iuU/D4QylbNQjwNH Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3xjd9vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:41:00 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VGGNAS016317;
        Tue, 31 Jan 2023 16:41:00 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf3xjd9vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:40:59 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGPSfp008520;
        Tue, 31 Jan 2023 16:40:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw2n7d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:40:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VGevEm44040816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 16:40:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D261E5805F;
        Tue, 31 Jan 2023 16:40:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E67945805C;
        Tue, 31 Jan 2023 16:40:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 16:40:56 +0000 (GMT)
Message-ID: <6e2267c6-fdd9-b017-ed94-3dc9a8878a29@linux.ibm.com>
Date:   Tue, 31 Jan 2023 11:40:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 20/25] powerpc/pseries: Turn PSERIES_PLPKS into a
 hidden option
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-21-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-21-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zpDreHzUUq5L81lXC_RtOYNYpFmTHmvq
X-Proofpoint-GUID: aibIpIYoRq5r5gIECFq3td07LY-rMRwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> It seems a bit unnecessary for the PLPKS code to have a user-visible
> config option when it doesn't do anything on its own, and there's existing
> options for enabling Secure Boot-related features.
> 
> It should be enabled by PPC_SECURE_BOOT, which will eventually be what
> uses PLPKS to populate keyrings.
> 
> However, we can't get of the separate option completely, because it will
> also be used for SED Opal purposes.
> 
> Change PSERIES_PLPKS into a hidden option, which is selected by
> PPC_SECURE_BOOT.
> 
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> 
> ---
> 
> v3: New patch
> 
> v5: Change the previous description into a comment (npiggin)
> ---
>   arch/powerpc/Kconfig                   |  1 +
>   arch/powerpc/platforms/pseries/Kconfig | 19 +++++++++----------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b8c4ac56bddc..d4ed46101bec 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -1029,6 +1029,7 @@ config PPC_SECURE_BOOT
>   	depends on PPC_POWERNV || PPC_PSERIES
>   	depends on IMA_ARCH_POLICY
>   	imply IMA_SECURE_AND_OR_TRUSTED_BOOT
> +	select PSERIES_PLPKS if PPC_PSERIES
>   	help
>   	  Systems with firmware secure boot enabled need to define security
>   	  policies to extend secure boot to the OS. This config allows a user
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index a3b4d99567cb..e51d65969318 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -151,16 +151,15 @@ config IBMEBUS
>   
>   config PSERIES_PLPKS
>   	depends on PPC_PSERIES
> -	bool "Support for the Platform Key Storage"
> -	help
> -	  PowerVM provides an isolated Platform Keystore(PKS) storage
> -	  allocation for each LPAR with individually managed access
> -	  controls to store sensitive information securely. It can be
> -	  used to store asymmetric public keys or secrets as required
> -	  by different usecases. Select this config to enable
> -	  operating system interface to hypervisor to access this space.
> -
> -	  If unsure, select N.
> +	bool
> +	# PowerVM provides an isolated Platform Keystore (PKS) storage
> +	# allocation for each LPAR with individually managed access
> +	# controls to store sensitive information securely. It can be
> +	# used to store asymmetric public keys or secrets as required
> +	# by different usecases.
> +	#
> +	# This option is selected by in-kernel consumers that require
> +	# access to the PKS.
>   
>   config PAPR_SCM
>   	depends on PPC_PSERIES && MEMORY_HOTPLUG && LIBNVDIMM
