Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA71F5B900A
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiINVVQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiINVVP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 17:21:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337511FCE1
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 14:21:14 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EKVOMJ020197;
        Wed, 14 Sep 2022 21:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e2fAz9PHrcB8ZfX2pFm5xu583h6h5hhWUAhHLnMXlKg=;
 b=pFomN9z675GAoOWGD6q8F8Dlz0KHjoaHejXcU5bDJ9+kc1DSQLCFoim+3sC5VxUDu0RV
 oMJ91C5WE9KBlwedgfq26FNdbSFeg5T0/EEt9oiuhz3loGMuBPWTC0VSmkSoRDyXt0XN
 IMf9Hceeg5qeT+DW3A+/I9LcLrf35Dp+5slt1igvigJEStuvr+yZIbOGQ6rKRL9o5uv8
 Sp9YSZ9hV4DSKg+qROF6orTjj2dyZow7IMxsmHmVRBMoZbqhk4CQYntAKCCqBq34M3vP
 FG3EmQR10HJgTfPY8CJquB+SojJrVFE5zznk1JxaJvQyfvQrLZ7KdiRjgiqv4pbPzXjO Fw== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkm0950wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:21:10 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28EL5h7A030643;
        Wed, 14 Sep 2022 21:21:09 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3jjypu70fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:21:09 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28ELL8w315139446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 21:21:08 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 361B3C6057;
        Wed, 14 Sep 2022 21:21:07 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F01F0C605A;
        Wed, 14 Sep 2022 21:21:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 21:21:06 +0000 (GMT)
Message-ID: <4354a45a-406c-fd33-fd4c-be5769652537@linux.ibm.com>
Date:   Wed, 14 Sep 2022 17:21:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils 4/4] Fix tpm2_pcr_supported() output
 messages
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
 <20220914142225.1381077-5-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220914142225.1381077-5-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pInl3HOccnTYnln69VFYfhNhzHbphdnp
X-Proofpoint-ORIG-GUID: pInl3HOccnTYnln69VFYfhNhzHbphdnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_09,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209140101
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/14/22 10:22, Mimi Zohar wrote:
> Remove unnecessary path check in pcr_ibmtss.c and update the syntax
> in the other.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/pcr_ibmtss.c     | 12 +-----------
>   src/pcr_tsspcrread.c |  4 ++--
>   2 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/src/pcr_ibmtss.c b/src/pcr_ibmtss.c
> index b8700ddd5da8..6b38d280e80c 100644
> --- a/src/pcr_ibmtss.c
> +++ b/src/pcr_ibmtss.c
> @@ -20,21 +20,11 @@
>   #undef MAX_DIGEST_SIZE	/* imaevm uses a different value than the TSS */
>   #include <ibmtss/tss.h>
>   
> -#define CMD "tsspcrread"
> -
> -static char path[PATH_MAX];
> -
>   int tpm2_pcr_supported(void)
>   {
>   	if (imaevm_params.verbose > LOG_INFO)
> -		log_info("Using %s to read PCRs.\n", CMD);
> -
> -	if (get_cmd_path(CMD, path, sizeof(path))) {
> -		log_debug("Couldn't find '%s' in $PATH\n", CMD);
> -		return 0;
> -	}
> +		log_info("Using ibmtss to read PCRs.\n");
>   
> -	log_debug("Found '%s' in $PATH\n", CMD);
>   	return 1;
>   }
>   
> diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
> index 95048f8a5469..39ff8f7fc14d 100644
> --- a/src/pcr_tsspcrread.c
> +++ b/src/pcr_tsspcrread.c
> @@ -60,11 +60,11 @@ int tpm2_pcr_supported(void)
>   		log_info("Using %s to read PCRs.\n", CMD);
>   
>   	if (get_cmd_path(CMD, path, sizeof(path))) {
> -		log_debug("Couldn't find '%s' in $PATH\n", CMD);
> +		log_info("Couldn't find '%s' in %s\n", CMD, path);
>   		return 0;
>   	}
>   
> -	log_debug("Found '%s' in $PATH\n", CMD);
> +	log_debug("Found '%s' in %s\n", CMD, path);
>   	return 1;
>   }
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
