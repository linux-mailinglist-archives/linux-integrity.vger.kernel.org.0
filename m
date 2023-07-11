Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E490574F8E2
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 22:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGKUQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 16:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGKUQt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 16:16:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE52171E
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 13:16:46 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BKCKfB028815;
        Tue, 11 Jul 2023 20:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IL+AOPlpv7sXx6J9Qrm22wjnMz4nXvYoy91J1MQet4w=;
 b=OoNHNx+Su5dHg0yBlJ2JkEkGTnmf3a0YMd4VHdhij8BXBIAZLX4vbXg2y/hH40oUCmzr
 CGMSaScxg21BqakSRMh0Q2e9hutr0yBUz7tYckiIV2giryG1Fdkskf87en987e9h2hr8
 eSrGIi7lr2V7IQNjs4vl5GQ9u+hZs/W6AMgRkyVdC2UD5ZYl8ZE0ZZpzJel7uCdeFJWp
 rxJ73xtP/ntbv4oMx39W0rRPiNKVu9/r7jHxnBtJAFiBo6WYAikkhVtN34TsjPVP9Jnk
 RQWS3Us69sTKfLWQMOC2mGres7NBmSy6iov2FRrPz+Xbwr3W8mJup1A83UiKzhS4g30j Kw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsdwf04fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 20:16:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEFi7M019772;
        Tue, 11 Jul 2023 20:16:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqmu0rnub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 20:16:30 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BKGTVr525030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 20:16:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6973658054;
        Tue, 11 Jul 2023 20:16:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17DC35805C;
        Tue, 11 Jul 2023 20:16:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jul 2023 20:16:27 +0000 (GMT)
Message-ID: <273cea4f-9c82-e5ca-20e4-1db30d83393e@linux.ibm.com>
Date:   Tue, 11 Jul 2023 16:16:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 03/10] ima: allocate buffer at kexec load to hold ima
 measurements
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        "Eric W . Biederman" <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7XSJl1t9iIALAcvigGO2plrI8l8mIVZU
X-Proofpoint-ORIG-GUID: 7XSJl1t9iIALAcvigGO2plrI8l8mIVZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/3/23 17:57, Tushar Sugandhi wrote:
> The IMA subsystem needs a dedicated mechanism to reserve extra memory for
> measurements added between the kexec 'load' and kexec 'execute'.
> 
> Update ima_add_kexec_buffer to allocate a buffer of a sufficient size
> taking ima binary runtime measurements size, size of ima_kexec_hdr, and
> IMA_KEXEC_EXTRA_SIZE into account.  Adjust the kexec_segment_size to align
> to the PAGE_SIZE.  Call ima_allocate_buf_at_kexec_load() to allocate the
> buffer.
> 
> This patch assumes the extra space defined (IMA_KEXEC_EXTRA_SIZE) is
> sufficient to handle the additional measurements.  This should be as per
> the system requirements and based on the number of additional measurements
> expected during the window from kexec 'load' to kexec 'execute'.

This could be the most problematic part if the 'execute' happens much later
than the 'load' with lots of measurement activity in between. I am wondering
whether not doing anything at 'load' time and doing the whole work at 'execute' time
wouldn't be the right thing to do ?

Otherwise, if we wanted the work to be split as you suggest, could you
- krealloc the src_pages (now in kimage_map_segment) to add space for a few more pages needed for the additional measurements
- add those few more pages to src_pages
- vunmap the previous mapping
- vmap the extended src_pages array
- update ima_kexec_file.buf with the diff between the new and old vmap'ed addresses
- append to the existing log

This presumably would help resolve this potential issue.

The src_pages is currently not kfree'd -- may be a memory leak.

Regards,
    Stefan

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>   security/integrity/ima/ima.h       |  2 ++
>   security/integrity/ima/ima_kexec.c | 21 ++++++++++-----------
>   2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..2ffda9449b9b 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -43,6 +43,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>   
>   #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
>   
> +#define IMA_KEXEC_EXTRA_SIZE (16 * PAGE_SIZE)
> +
>   /* current content of the policy */
>   extern int ima_policy_flag;
>   
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 858b67689701..7deb8df31485 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -188,31 +188,30 @@ void ima_add_kexec_buffer(struct kimage *image)
>   	/* use more understandable variable names than defined in kbuf */
>   	void *kexec_buffer = NULL;
>   	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
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
> +			      IMA_KEXEC_EXTRA_SIZE;
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
>   		return;
>   	}
>   
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);
> -	if (!kexec_buffer) {
> -		pr_err("Not enough memory for the kexec measurement buffer.\n");
> +	ret = ima_allocate_buf_at_kexec_load();
> +	if (ret < 0)
>   		return;
> -	}
>   
>   	kbuf.buffer = kexec_buffer;
>   	kbuf.bufsz = kexec_buffer_size;
