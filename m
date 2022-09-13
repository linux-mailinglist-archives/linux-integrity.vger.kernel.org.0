Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF475B7870
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 19:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiIMRmj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 13:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbiIMRmO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 13:42:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A997E029
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 09:35:56 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DGPK7h017197;
        Tue, 13 Sep 2022 16:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XFtSJ3lpO7I6yYaPH4ozw7/gwAlfJcVhk1zv5sxE/tU=;
 b=V/4+B7En2U/zDVUwtG/VHaABk4LJ2G/yHt0mJZrok4aHSnAYUXbgoWcRNvmbZOqhvAnW
 ZT4LN4oHeyu5HhRz0sNMgPCVP3FTEQJ/vaLLDUredfGcpI01VsRPS50PauB7w1oRfi8b
 wC75QUHYRme1JIafZg7XETWOFMZxIS/YhlwZcdpP/knDM1xqCWbqkKo1RM8lnebXBZx1
 LYKV2IkQCbzrMvbdnn2l6PtBNL3i47Nm4CWAqEA3sKJXi8PX/Vroo/VOcGCVoMBGPXqo
 Dc/e9GvomWoTb8pv7XIdh4gmZ9tc8//bSg3PHHUmgWx0itBHR20tyBsGySKXVFBEvMx0 SA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjwcb0exd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:35:51 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DGL0mT011669;
        Tue, 13 Sep 2022 16:35:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3jgj7a56tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:35:49 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DGZnXF53608848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:35:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57ED6B205F;
        Tue, 13 Sep 2022 16:35:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BA12B2064;
        Tue, 13 Sep 2022 16:35:49 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 16:35:49 +0000 (GMT)
Message-ID: <db96f593-b2d0-2286-c0f7-c0801044cdad@linux.ibm.com>
Date:   Tue, 13 Sep 2022 12:35:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2 10/12] Limit the file hash algorithm name
 length
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-11-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220906195021.854090-11-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F4LgjOiSoG6bv_atXSzcE3HnzWTrRk2m
X-Proofpoint-GUID: F4LgjOiSoG6bv_atXSzcE3HnzWTrRk2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130075
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/6/22 15:50, Mimi Zohar wrote:
> Instead of assuming the file hash algorithm is a properly NULL terminated
> string, properly limit the "algo:<hash>" field size.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/evmctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index a497b1a468d6..aac669438a1c 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1602,7 +1602,7 @@ void ima_ng_show(struct template_entry *entry)
>   	total_len -= sizeof(field_len);
>   
>   	algo = (char *)fieldp;
> -	len = strlen(algo) + 1;
> +	len = strnlen(algo, field_len - 1) + 1;
>   	digest_len = field_len - len;
>   	digest = fieldp + len;
>   
