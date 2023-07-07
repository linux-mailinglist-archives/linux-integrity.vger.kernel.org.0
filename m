Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683CB74B162
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 15:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGGNCo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjGGNCn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 09:02:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5989E6E
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 06:02:42 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367CkaN0029186;
        Fri, 7 Jul 2023 13:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=H2ezGORMzLzq3X4mxEa+WGr7fxMn7SnI+/bebCaNQjc=;
 b=MJG9NtS0oGH821kVgSwATYIMun2oGIRm5yHN6MREVpX/taA6gqOwVZFryEMg2IbXLUGt
 a3yVAij2N9fyIQbMoyeKv5mkUGcSlSbVuU9jk5lkRERR4ZIXPPpcL8Odhm8rhF54x4ne
 6MJXa1FGk87fz48ZT2249UR8ITW4B8pPoBm/OuRZmtsMNVf86vWJMPfK1hUEQcSdQWHJ
 l5dhClKp0FcbRYgdH/YXnDtKco39ame8fZ7pCt33fBbd3GCBd51YcidukFKOq9ipGkmk
 R6hw2RJbPGLP/qilmd54JvgkJBwl/2NSrW7PMmne5cx2cFveDwTZPX0hS5S7oHER6LUS 2A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpk0tgbj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:02:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367AWPeb016300;
        Fri, 7 Jul 2023 13:01:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6wm4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:01:30 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367D1SKa3342860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 13:01:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89FE05805D;
        Fri,  7 Jul 2023 13:01:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E39C058058;
        Fri,  7 Jul 2023 13:01:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 13:01:27 +0000 (GMT)
Message-ID: <ef2f8f1f9ab806e010cac02aab1b64fa51ce4c2c.camel@linux.ibm.com>
Subject: Re: [PATCH 03/10] ima: allocate buffer at kexec load to hold ima
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 07 Jul 2023 09:01:27 -0400
In-Reply-To: <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
         <20230703215709.1195644-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DS9aXoetQKrL-QpSnynpSMPadsGWlsmZ
X-Proofpoint-ORIG-GUID: DS9aXoetQKrL-QpSnynpSMPadsGWlsmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

The function to "ima: allocate buffer at kexec load to hold ima
measurements" already exists.  Please update the Subject line to
indicate increasing the IMA kexec buffer size.

On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
> The IMA subsystem needs a dedicated mechanism to reserve extra memory for
> measurements added between the kexec 'load' and kexec 'execute'.

What is a "dedicated mechanism?".  Either start the sentence with
"reserve ..." or completely remove it.

> Update ima_add_kexec_buffer to allocate a buffer of a sufficient size
> taking ima binary runtime measurements size, size of ima_kexec_hdr, and
> IMA_KEXEC_EXTRA_SIZE into account.  Adjust the kexec_segment_size to align
> to the PAGE_SIZE.  Call ima_allocate_buf_at_kexec_load() to allocate the
> buffer.

The size of the ima_kexec_hdr kind of gets lost in the amount of
additional memory being allocated, but sure it's a nice clean up.

> This patch assumes the extra space defined (IMA_KEXEC_EXTRA_SIZE) is
> sufficient to handle the additional measurements.  This should be as per
> the system requirements and based on the number of additional measurements
> expected during the window from kexec 'load' to kexec 'execute'.

Should the extra amount of memory be hard coded?

> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h       |  2 ++
>  security/integrity/ima/ima_kexec.c | 21 ++++++++++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..2ffda9449b9b 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -43,6 +43,8 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>  
>  #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
>  
> +#define IMA_KEXEC_EXTRA_SIZE (16 * PAGE_SIZE)
> 

Not all IMA policies require extra memory.  Define and use a new IMA
Kconfig to set the amount of extra memory.

>  /* current content of the policy */
>  extern int ima_policy_flag;
>  
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 858b67689701..7deb8df31485 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -188,31 +188,30 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	/* use more understandable variable names than defined in kbuf */
>  	void *kexec_buffer = NULL;
>  	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
>  	int ret;
>  
>  	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added in the window from
> +	 * kexec 'load' to kexec 'execute'.
>  	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	binary_runtime_size = ima_get_binary_runtime_size() +
> +			      sizeof(struct ima_kexec_hdr) +
> +			      IMA_KEXEC_EXTRA_SIZE;
> +
>  	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>  		kexec_segment_size = ULONG_MAX;
>  	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
> +
>  	if ((kexec_segment_size == ULONG_MAX) ||
>  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>  		pr_err("Binary measurement list too large.\n");
>  		return;
>  	}
>  
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);

Removing the call to ima_dump_measurement_list here is not bisect safe.

> -	if (!kexec_buffer) {
> -		pr_err("Not enough memory for the kexec measurement buffer.\n");
> +	ret = ima_allocate_buf_at_kexec_load();
> +	if (ret < 0)
>  		return;
> -	}
>  
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;

-- 
thanks,

Mimi

