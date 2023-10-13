Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472B7C7ADA
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Oct 2023 02:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbjJMAaU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Oct 2023 20:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344252AbjJMAaT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2023 20:30:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84EB7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2023 17:30:17 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39D0EnMH032246;
        Fri, 13 Oct 2023 00:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DIUantFOsMzEw/QS0BIVbuKoupftEJTPIZ7nY9ajbKI=;
 b=Ae4hudJIZj7dCeJ2aVktn21hfOwjcYZpnBrvcGVkGNGzxZQs9xKUxiXjeVyCQYeJCUSd
 COkxOp2dSWjXDQv97i3+wO9WTAhURR//MU8C/8Zf7dNZev/2Al/1Shxql168rC6I4kKG
 tPGHWBwt/I0lgUOjzSoCcZHv9WR1yuzoWtbaGpd4M2Vf4lrZuMMyU8B5SmZYoFHdetWF
 VncShMtWpd02nYmOtWkgSPoPW6utnf5+FHE3Yu/asRCLl1/mS5qqubvQ1lJK4b3peEbt
 14mSsDG7xg3+9zsKCqithg/DepH/JDBNv2/aN55jUln/WzWCSieyPDqcyl5vppSIRzdI Aw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpu678asv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:28:02 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CN4FTw007595;
        Fri, 13 Oct 2023 00:28:00 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt5a8e3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 00:28:00 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39D0RxHW21234406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 00:28:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA19B58052;
        Fri, 13 Oct 2023 00:27:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 249AD58065;
        Fri, 13 Oct 2023 00:27:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 13 Oct 2023 00:27:59 +0000 (GMT)
Message-ID: <a8828617-a296-8498-5e1f-b75a089916e0@linux.ibm.com>
Date:   Thu, 12 Oct 2023 20:27:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 6/7] ima: make the memory for events between kexec load
 and exec configurable
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, ebiederm@xmission.com, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-7-tusharsu@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20231005182602.634615-7-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YcZeWS7rtGvaPuN2C2FwdnQiLBxzF1qf
X-Proofpoint-GUID: YcZeWS7rtGvaPuN2C2FwdnQiLBxzF1qf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=876 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130001
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/5/23 14:26, Tushar Sugandhi wrote:
> IMA currently allocates half a PAGE_SIZE for the extra events that would
> be measured between kexec 'load' and 'execute'.  Depending on the IMA
> policy and the system state, that memory may not be sufficient to hold
> the extra IMA events measured after kexec 'load'.  The memory
> requirements vary from system to system and they should be configurable.
>
> Define a Kconfig option, IMA_KEXEC_EXTRA_PAGES, to configure the number
> of extra pages to be allocated for IMA measurements added in the window
> from kexec 'load' to kexec 'execute'.
>
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hardcoded one.
>
> Signed-off-by: Tushar Sugandhi<tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/Kconfig     |  9 +++++++++
>   security/integrity/ima/ima_kexec.c | 13 ++++++++-----
>   2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 60a511c6b583..1b55cd2bcb36 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>   	default n
>   	help
>   	   This option disables htable to allow measurement of duplicate records.
> +
> +config IMA_KEXEC_EXTRA_PAGES
> +	int
> +	depends on IMA && IMA_KEXEC
> +	default 16
> +	help
> +	  IMA_KEXEC_EXTRA_PAGES determines the number of extra
> +	  pages to be allocated for IMA measurements added in the
> +	  window from kexec 'load' to kexec 'execute'.


On ppc64 a page is 64kb. I would ask for additional kb here.


> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 13fbbb90319b..6cd5f46a7208 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -150,15 +150,18 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	int ret;
>   
>   	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added in the window from
> +	 * kexec 'load' to kexec 'execute'.
>   	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	binary_runtime_size = ima_get_binary_runtime_size() +
> +			      sizeof(struct ima_kexec_hdr) +
> +			      (CONFIG_IMA_KEXEC_EXTRA_PAGES * PAGE_SIZE);
> +
>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>   		kexec_segment_size = ULONG_MAX;
>   	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
> +
>   	if ((kexec_segment_size == ULONG_MAX) ||
>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>   		pr_err("Binary measurement list too large.\n");
