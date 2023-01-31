Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A49683208
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjAaQAV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 11:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjAaQAR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 11:00:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C00E4DBFE;
        Tue, 31 Jan 2023 08:00:16 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VG080i009268;
        Tue, 31 Jan 2023 16:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QhnY2LtE17z4R7y31f+Vs6DSz5B7T93PdcPupTXylLg=;
 b=EJmi0eAkn8G64zQYLoVW2Byz0C8VKszQurvTFoxYSKjoD2l4ObcRMakgvx2wOXslekUn
 vIEBNHVCJDLL750ZRJdZIW/frFJDyqki09M+VNzcDhH/klY10rCGSFtfriHiluN+SeKN
 MYOWpCXOV7mZ2asF3Jk6QbgDR7H8H9SvriBWGvde5z5YCqeW2LkLIG/uEgWjzfE3551q
 YQYL7oczMj4jScgMXtQNwQ1w70uTJQuI1xb5fk/9DoeBHRkuI4OcxCu8IKXaySrnCp3u
 26cGzRNbBPy48wK8YGbwhF/4nmbLelU9PTTR6WsizDQJQIwRvuoadPFr7Hj0tLJjXUxD sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf31ndfpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:00:07 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VG06gu009078;
        Tue, 31 Jan 2023 16:00:06 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf31ndfgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:00:06 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VExGD0012295;
        Tue, 31 Jan 2023 15:59:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3ncvvdgsw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:59:56 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VFxsEQ34406840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:59:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75BD258065;
        Tue, 31 Jan 2023 15:59:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9430758067;
        Tue, 31 Jan 2023 15:59:53 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 15:59:53 +0000 (GMT)
Message-ID: <4bc7245d-15f4-cb9c-dddc-4a05a3de98db@linux.ibm.com>
Date:   Tue, 31 Jan 2023 10:59:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 14/25] powerpc/pseries: Move plpks.h to include
 directory
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-15-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-15-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: otwtGfecQnNQ_VfRy5RR16rJ7i63x8n-
X-Proofpoint-GUID: 4Y4lJK87A0fpbmhZoI9heAsZUPmhu2jx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301310137
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
> Move plpks.h from platforms/pseries/ to include/asm/. This is necessary
> for later patches to make use of the PLPKS from code in other subsystems.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> ---
> 
> v3: New patch
> ---
>   .../powerpc/{platforms/pseries => include/asm}/plpks.h | 10 +++++++---
>   arch/powerpc/platforms/pseries/plpks.c                 |  3 +--
>   2 files changed, 8 insertions(+), 5 deletions(-)
>   rename arch/powerpc/{platforms/pseries => include/asm}/plpks.h (89%)
> 
> diff --git a/arch/powerpc/platforms/pseries/plpks.h b/arch/powerpc/include/asm/plpks.h
> similarity index 89%
> rename from arch/powerpc/platforms/pseries/plpks.h
> rename to arch/powerpc/include/asm/plpks.h
> index 275ccd86bfb5..8295502ee93b 100644
> --- a/arch/powerpc/platforms/pseries/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -6,8 +6,10 @@
>    * Platform keystore for pseries LPAR(PLPKS).
>    */
>   
> -#ifndef _PSERIES_PLPKS_H
> -#define _PSERIES_PLPKS_H
> +#ifndef _ASM_POWERPC_PLPKS_H
> +#define _ASM_POWERPC_PLPKS_H
> +
> +#ifdef CONFIG_PSERIES_PLPKS
>   
>   #include <linux/types.h>
>   #include <linux/list.h>
> @@ -68,4 +70,6 @@ int plpks_read_fw_var(struct plpks_var *var);
>    */
>   int plpks_read_bootloader_var(struct plpks_var *var);
>   
> -#endif
> +#endif // CONFIG_PSERIES_PLPKS
> +
> +#endif // _ASM_POWERPC_PLPKS_H
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index a01cf2ff140a..13e6daadb179 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -18,8 +18,7 @@
>   #include <linux/types.h>
>   #include <asm/hvcall.h>
>   #include <asm/machdep.h>
> -
> -#include "plpks.h"
> +#include <asm/plpks.h>
>   
>   #define PKS_FW_OWNER	     0x1
>   #define PKS_BOOTLOADER_OWNER 0x2


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
