Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E777A5B9016
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiINV2Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 17:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINV2O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 17:28:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734F6C763
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 14:28:14 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EKVTF6020440;
        Wed, 14 Sep 2022 21:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wJMN93Ro4NKI3m/w/RGce0Sywe5IrsOi4VvghRiFYb0=;
 b=d/foZMxJjtaXD7WG2/l5qsyuvvlgDZwgK7eScZmqcMmimXBSdzWthB9q7V81fO354Ac+
 NWWhtZeGjF+c6Hav2rfdLbIDoc3hb5dWkPi6HdkYEMRoeJozIBa+xoDc9Bls2C0sVit6
 8MDN7SJ9yT+RdsAs/mxC/M1sZ2isf3vqMOv+zzzC9brlNGFFM40rbZxoY+KudLGFJSLj
 Y7bQRoyEUvV0suIGbPrCJmczWLz/4gLYcthSqMqJjwbclSLxiUw/LSut0usprZuHYO7e
 v7wSTZogUpQM9flAAcj79qUGd6VetnbbcUo1W9iIKyovG5m8y6HpZhQXIwQPEYaCONnE uA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkm095679-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:28:11 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28ELKJQN003132;
        Wed, 14 Sep 2022 21:28:10 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3jjy2e785t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 21:28:10 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28ELS94M5636660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 21:28:09 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48D032805C;
        Wed, 14 Sep 2022 21:28:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29D212805A;
        Wed, 14 Sep 2022 21:28:09 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 21:28:09 +0000 (GMT)
Message-ID: <10d64a8e-b357-3feb-6777-0d3ea970290f@linux.ibm.com>
Date:   Wed, 14 Sep 2022 17:28:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils 2/4] Define and verify the template data
 length upper bounds
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
 <20220914142225.1381077-3-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220914142225.1381077-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zYxNGU5nvPm-JFG0gn5unpV9wah0Ppeo
X-Proofpoint-ORIG-GUID: zYxNGU5nvPm-JFG0gn5unpV9wah0Ppeo
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
> The template data length is variable, based on the template format.
> Define some sort of upper bounds.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c |  3 ++-
>   src/imaevm.h | 10 ++++++++++
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index bcf724c828f7..9ab804fee37a 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2189,7 +2189,8 @@ static int ima_measurement(const char *file)
>   				log_err("Unable to read template length\n");
>   				goto out;
>   			}
> -			if (entry.template_len == 0) {
> +			if (entry.template_len == 0 ||
> +			    entry.template_len > MAX_TEMPLATE_SIZE) {
>   				log_err("Invalid template data len\n");
>   				goto out;
>   			}
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 8114bd051514..c43312d01dec 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -91,6 +91,16 @@
>   #define MAX_DIGEST_SIZE		64
>   #define MAX_SIGNATURE_SIZE	1024
>   
> +/*
> + * The maximum template data size is dependent on the template format. For
> + * example the 'ima-modsig' template includes two signatures - one for the
> + * entire file, the other without the appended signature - and other fields
> + * (e.g. file digest, file name, file digest without the appended signature).
> + *
> + * Other template formats are much smaller.
> + */
> +#define MAX_TEMPLATE_SIZE	(MAX_SIGNATURE_SIZE * 4)

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> +
>   #define __packed __attribute__((packed))
>   
>   enum evm_ima_xattr_type {
