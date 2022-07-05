Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311F56717B
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jul 2022 16:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiGEOtm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jul 2022 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGEOtm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jul 2022 10:49:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29935A3
        for <linux-integrity@vger.kernel.org>; Tue,  5 Jul 2022 07:49:39 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265E4xX1001183
        for <linux-integrity@vger.kernel.org>; Tue, 5 Jul 2022 14:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=E1LxBD9dwmi19Mr1W6Z0tEpo+bbnDzw/CweEnLL4WL4=;
 b=FI+7ARcpaPuRdMj3ST+ZMPcJMqT1KXU7V853ot4uCzOLqV7sQ80PKX89CC2SvKfDqmpY
 N1vSeIc2GVgr/+y7stZ74agPBjh0o7qVPAZPi7oOuB+02132uryDSKK8DEb9WcoRjch9
 4m0/yNJDI4CzzHOwE5U+acj2ANE169j0gpaLw5KN26g5n7kOHAAUxOLbEwUGD7fSHeyV
 ctecUj/3Us0RIJ1vfneYhkutbPbFpt/w5FwToHMlAojYBjmJ4+b+FRdBj5pMVKuao5zT
 SviLMnqsW9wKdzJaVU5+8jDqtKfpFqlLk3w8O7Z2DQJdYDgx69Qxb+fh5EQsqzQaOUiS RA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4p66th6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jul 2022 14:49:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 265EaDQL029510
        for <linux-integrity@vger.kernel.org>; Tue, 5 Jul 2022 14:49:38 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3h2dn9wjfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jul 2022 14:49:38 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 265Ena4633751408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jul 2022 14:49:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A12016E056;
        Tue,  5 Jul 2022 14:49:36 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 716EA6E04E;
        Tue,  5 Jul 2022 14:49:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jul 2022 14:49:36 +0000 (GMT)
Message-ID: <2cc5f904-7594-b60a-670d-aea7b603765a@linux.ibm.com>
Date:   Tue, 5 Jul 2022 10:49:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] ima: fix violation measurement list record
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20220705141035.1101598-1-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220705141035.1101598-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KzTTd8rIKFPfw4enk0RbZ1s3yFj4vPvp
X-Proofpoint-GUID: KzTTd8rIKFPfw4enk0RbZ1s3yFj4vPvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207050062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/5/22 10:10, Mimi Zohar wrote:
> Although the violation digest in the IMA measurement list is always
> zeroes, the size of the digest should be based on the hash algorithm.
> Until recently the hash algorithm was hard coded to sha1.  Fix the
> violation digest size included in the IMA measurement list.
> 
> This is just a cosmetic change which should not affect attestation.
> 
> Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> Fixes: 09091c44cb73 ("ima: use IMA default hash algorithm for integrity violations")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   security/integrity/ima/ima_template_lib.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index c877f01a5471..34a8cabe09b1 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -324,9 +324,9 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
>   		/*
>   		 * If digest is NULL, the event being recorded is a violation.
>   		 * Make room for the digest by increasing the offset of
> -		 * IMA_DIGEST_SIZE.
> +		 * hash algorithm digest size.
>   		 */
> -		offset += IMA_DIGEST_SIZE;
> +		offset += hash_digest_size[hash_algo];
>   
>   	return ima_write_template_field_data(buffer, offset + digestsize,
>   					     fmt, field_data);
