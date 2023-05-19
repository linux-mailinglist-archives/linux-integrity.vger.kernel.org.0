Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDC70A294
	for <lists+linux-integrity@lfdr.de>; Sat, 20 May 2023 00:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjESWAw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 May 2023 18:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESWAv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 May 2023 18:00:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D5B1;
        Fri, 19 May 2023 15:00:49 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JLhFa9015362;
        Fri, 19 May 2023 22:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wnvNsv1icuwL1D/NTAiU+oUoyuZDdRtvGjXWiWLxUBU=;
 b=aRabyg28XSHuUC7ki6C7dggI7q++T+f+38ZqXb+fy7mc4Gtzcblr59ycrM6KyTihq4MR
 4bFSvOFJvGMlPsZhUYO9h9kqOk6kj16rO3UFbUDk7Fd/dajLTdaUfKFmKlzF3rTqWVlJ
 vHGIh6QLb3YXQbE9vTP/v8KoDX/MQRZ2dCunQkI6so9nwGtDxRM2KSUP3TLrmgczeLeV
 Z8k4BJvhBmREWTmTYj55k/qHc+wjPFVGCpYnPE65KVea73RJde4UxiOrNzBzaBziLjts
 FoGDDnF48SJYBjEx6iVB/f8SaOVEui5uUk+gLn5emEcve/cHE3xn7NTczmGlZ+Kkq+pz lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qph938b0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 22:00:43 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34JLxEZj027664;
        Fri, 19 May 2023 22:00:43 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qph938b0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 22:00:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34JK7h8O017930;
        Fri, 19 May 2023 22:00:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qj265s01k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 22:00:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JM0eYq39059838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 22:00:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 980A558068;
        Fri, 19 May 2023 22:00:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7F4658066;
        Fri, 19 May 2023 22:00:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 19 May 2023 22:00:39 +0000 (GMT)
Message-ID: <2dfb8122-2304-8f2e-9059-61b0dcb79ab6@linux.ibm.com>
Date:   Fri, 19 May 2023 18:00:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] tpm: tpm_vtpm_proxy: fix a race condition in
 /dev/vtpmx creation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230515222554.2783592-1-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230515222554.2783592-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bDS-H2UweQNxSI3FShZJ-7Mcw4sKlolj
X-Proofpoint-GUID: NBhnOWMVWBTTrNd9MU56zMnWFvvKaDG4
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190187
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/15/23 18:25, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> 
> /dev/vtpmx is made visible before 'workqueue' is initialized, which can
> lead to a memory corruption in the worst case scenario.
> 
> Address this by initializing 'workqueue' as the very first step of the
> driver initialization.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> ---
> v2:
> - Replace vtpmx_cleanup() with destroy_workqueue():
>    https://lore.kernel.org/linux-integrity/CSLCEYDKKWWE.36POIXVT65SLE@suppilovahvero/
> - Fix typo:
>    https://lore.kernel.org/linux-integrity/4651cf1c-423d-05c2-b4c3-9d829a2eadf4@linux.ibm.com/
> ---
>   drivers/char/tpm/tpm_vtpm_proxy.c | 30 +++++++-----------------------
>   1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 5c865987ba5c..30e953988cab 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -683,37 +683,21 @@ static struct miscdevice vtpmx_miscdev = {
>   	.fops = &vtpmx_fops,
>   };
>   
> -static int vtpmx_init(void)
> -{
> -	return misc_register(&vtpmx_miscdev);
> -}
> -
> -static void vtpmx_cleanup(void)
> -{
> -	misc_deregister(&vtpmx_miscdev);
> -}
> -
>   static int __init vtpm_module_init(void)
>   {
>   	int rc;
>   
> -	rc = vtpmx_init();
> -	if (rc) {
> -		pr_err("couldn't create vtpmx device\n");
> -		return rc;
> -	}
> -
>   	workqueue = create_workqueue("tpm-vtpm");
>   	if (!workqueue) {
>   		pr_err("couldn't create workqueue\n");
> -		rc = -ENOMEM;
> -		goto err_vtpmx_cleanup;
> +		return -ENOMEM;
>   	}
>   
> -	return 0;
> -
> -err_vtpmx_cleanup:
> -	vtpmx_cleanup();
> +	rc = misc_register(&vtpmx_miscdev);
> +	if (rc) {
> +		pr_err("couldn't create vtpmx device\n");
> +		destroy_workqueue(workqueue);
> +	}
>   
>   	return rc;
>   }
> @@ -721,7 +705,7 @@ static int __init vtpm_module_init(void)
>   static void __exit vtpm_module_exit(void)
>   {
>   	destroy_workqueue(workqueue);
> -	vtpmx_cleanup();
> +	misc_deregister(&vtpmx_miscdev);
>   }
>   
>   module_init(vtpm_module_init);

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
