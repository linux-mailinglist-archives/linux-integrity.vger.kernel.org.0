Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813294CB4AA
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Mar 2022 03:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiCCCEL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 21:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiCCCEK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 21:04:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3375113F93;
        Wed,  2 Mar 2022 18:03:25 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2230RrMT031932;
        Thu, 3 Mar 2022 02:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=T9C3xmYlT8DnXDMis629GMjvTaHYpaVaSTrwiCNNBUI=;
 b=MRrK+1g+2hWRsc4lFRz3D6cvJdYsMUVTT/zrPVqZUZZ0mwA/9NpFKygo8c9vxbxQaTqc
 gN0AvK62btQ0Ey35M+dUxagHc3GuG7TznCo4hJrsVyWH2WKJZPhe2dmeAh7WfpSqUW6G
 V7vbaXGVupNyB74WEFkwLWTLYZrZXTFJB+82ImgKpeXvxaijDeQnzeYdmOi0qMJDIqTN
 4EhvRvro/h7rs6r4dhF4vh1Uy+RhCikeFeOPRehWWauFVt+Ol+Jn0IfSiP34zQTkxYuw
 t1RmhOpvljBoduZnPi4oP3TpzM437e7MMvWpS1ptiMH6Bqex9FdtN92Oi6YQNeImgRV/ VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejd9wr61j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 02:03:20 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2231Zg3d017255;
        Thu, 3 Mar 2022 02:03:19 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejd9wr619-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 02:03:19 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2231lTJf014593;
        Thu, 3 Mar 2022 02:03:18 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3ejjuw8qh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 02:03:18 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22323HSY18678100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 02:03:17 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B955BE05B;
        Thu,  3 Mar 2022 02:03:17 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B83DBE056;
        Thu,  3 Mar 2022 02:03:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 02:03:16 +0000 (GMT)
Message-ID: <45d5a510-eca8-f06f-8d6c-d8bbd41a4b23@linux.ibm.com>
Date:   Wed, 2 Mar 2022 21:03:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] tpm: Fix crash on tmprm release
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210615091410.17007-1-vincent.whitchurch@axis.com>
 <20210615091410.17007-2-vincent.whitchurch@axis.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20210615091410.17007-2-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7jfS3NTJ8O0mqLwK46GFexoA3_U82CVy
X-Proofpoint-GUID: WCP-pySGymS1pk_eDSaigx4BD1KLD6gC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/15/21 05:14, Vincent Whitchurch wrote:
> If the tpm_tis module is removed (or a system shutdown is triggered)
> while the tpmrm device is use, the kernel crashes due to chip->ops being
> NULL:
>
>   # exec 3<>/dev/tpmrm0
>   # rmmod tpm_tis
>   # exit
>   ==================================================================
>   BUG: KASAN: null-ptr-deref in tpm_chip_start+0x2d/0x120 [tpm]
>   Read of size 8 at addr 0000000000000060 by task sh/994
>
>   Call Trace:
>    kasan_report.cold.13+0x10f/0x111
>    tpm_chip_start+0x2d/0x120 [tpm]
>    tpm2_del_space+0x2c/0xa0 [tpm]
>    tpmrm_release+0x3f/0x50 [tpm]
>    __fput+0x110/0x3c0
>    task_work_run+0x94/0xd0
>    do_exit+0x683/0x13e0
>    do_group_exit+0x8b/0x140
>    do_syscall_64+0x3c/0x80
>   ==================================================================
>
> Fix this by making tpm2_del_space() use tpm_try_get_ops().  The latter
> already includes the calls to tpm_chip_start() and tpm_chip_stop().
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>


As a follow-up to this message here: https://lkml.org/lkml/2022/3/1/552


Tested-by: Stefan Berger <stefanb@linux.ibm.com>




> ---
>   drivers/char/tpm/tpm2-space.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 784b8b3cb903..e1111261021f 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -58,12 +58,10 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
>   
>   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>   {
> -	mutex_lock(&chip->tpm_mutex);
> -	if (!tpm_chip_start(chip)) {
> +	if (!tpm_try_get_ops(chip)) {
>   		tpm2_flush_sessions(chip, space);
> -		tpm_chip_stop(chip);
> +		tpm_put_ops(chip);
>   	}
> -	mutex_unlock(&chip->tpm_mutex);
>   	kfree(space->context_buf);
>   	kfree(space->session_buf);
>   }
