Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213406582DD
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Dec 2022 17:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiL1QnI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Dec 2022 11:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiL1Qm3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Dec 2022 11:42:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5E1D327
        for <linux-integrity@vger.kernel.org>; Wed, 28 Dec 2022 08:36:52 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSG8QgH008668;
        Wed, 28 Dec 2022 16:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rKcVcaf2bsYqevUHNvUW4KfC+7BbrKrGzDl9Fd0iVkU=;
 b=lJO7R/XiG9RYMrtbHOU9/+x0rT+xMfWaHsybcYT62f6rPM4rbpveliSqVTZGF4MI6WbS
 hSbKLAO3I0qOE4XbtwZgSe8bDwUE1Twn3tMn0LOMFeEWtVi/w8JmXMN5VHvbYU/jfhoe
 iKEer1hQ0tGzFB3XwRgcBJCaEf6aOnyfVChNVQ+eq4vGLKnkOf5sGc2aagewKTfd5yx/
 64xDFuDnpbQBgoJapTl5vuGZQTQeYL/fchy3KrXKcjzNby1DvPZrB3SEmSHLavHVfNtg
 3GcVIrIk3e1lGpVRMHCzYN65ISGAXgpl7YagvQcq4kPGdCzLULUWr56XZAn8MTTt5TMI QA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mramv82mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 16:35:57 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSFn0xV007796;
        Wed, 28 Dec 2022 16:35:56 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3mns28namk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 16:35:56 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BSGZtKH5505644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Dec 2022 16:35:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24E9D5804C;
        Wed, 28 Dec 2022 16:35:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCB9258052;
        Wed, 28 Dec 2022 16:35:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Dec 2022 16:35:54 +0000 (GMT)
Message-ID: <67c54e03-fcaa-acfa-2f8b-f14bcab81d68@linux.ibm.com>
Date:   Wed, 28 Dec 2022 11:35:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v2] ima: fix possible memory leak in cache allocating
 for namespace
Content-Language: en-US
To:     Denis Semakin <denis.semakin@huawei.com>,
        linux-integrity@vger.kernel.org
Cc:     denis.semakin@huawei-partners.com
References: <20221224070545.349944-1-denis.semakin@huawei.com>
 <20221226024335.767587-1-denis.semakin@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221226024335.767587-1-denis.semakin@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rTejHVQnMB3uF8_cFBqJXTUvZDBzUht6
X-Proofpoint-GUID: rTejHVQnMB3uF8_cFBqJXTUvZDBzUht6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_13,2022-12-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212280142
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 12/25/22 21:43, Denis Semakin wrote:
> There is a KMEM_CACHE(); macro which calls kmem_cache_create() function.
> The default workflow is to call:
> kmem_cache_create();
> kmem_cache_alloc();
> kmem_cache_free();
> kmem_cache_destroy();
> 
> But here if register_blocking_lsm_notifier() return an error then
> kmem_cache_destroy() will never calls which can lead a memory leak I suppose.
> 
> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
> Signed-off-by: Ilya Hanov <ilya.hanov@huawei-partners.com>
> ---
>   security/integrity/ima/ima_init_ima_ns.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index 1eaa6ceee2ee..5c850b740ae6 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -43,12 +43,16 @@ int ima_init_namespace(struct ima_namespace *ns)
>   		ret = register_blocking_lsm_notifier
>   						(&ns->ima_lsm_policy_notifier);
>   		if (ret)
> -			return ret;
> +			goto destroy_cache;
>   	}
>   
>   	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
>   
>   	return 0;
> +
> +destroy_cache:
> +	kmem_cache_destroy(ns->ns_status_cache);
> +	return ret;
>   }
>   
>   int __init ima_ns_init(void)

Since it doesn't make sense for me to carry a fix patch in this series I will merge this patch into the respective patch.

Thanks,
    Stefan
