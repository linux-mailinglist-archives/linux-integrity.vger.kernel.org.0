Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279C360BEAC
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 01:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJXXdw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Oct 2022 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJXXdW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Oct 2022 19:33:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04EE2E25FF
        for <linux-integrity@vger.kernel.org>; Mon, 24 Oct 2022 14:54:10 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OLBPXa032401;
        Mon, 24 Oct 2022 21:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+1AZn5rL2gnxunXpJxbaqs+ALF861H8JT2o7OB5DhgY=;
 b=iKXWBB8plNwjZIoreuFVrUxCmg4Od3vs2WYEl2CUStmZodw1qBWWQf2Quj5eAVIOrepJ
 WkEbgHn2T8wyEyiClwfSqxsa0U2Ez9V2R9IdyBK8sobUjuwqgzTU4crP0OIlDYqDHa9S
 jwTTAYIIa4oouSlxrfvZ2k9XgF2XQ7fSbcpUcmvM5kId0TVGYKzdb/U8XB4CAMUfY7Qo
 vOxhDFj4tYy7LI4QRvTTY4A7V+hxQXPLMA1Mi6EKJyUux+T3Ssv7ND96G1gdEnMuWCWt
 MwpN/ePZK9J5ZvNP5mRr06rdVNBXAATII29OOZ0n/dP/oWuF0Dd2L98APpzMItoH7odw pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ke1w9tbs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 21:54:00 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29OLox2A022006;
        Mon, 24 Oct 2022 21:53:59 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ke1w9tbrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 21:53:59 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OLpCUx027710;
        Mon, 24 Oct 2022 21:53:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 3kc85a66gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 21:53:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OLrwXl38928878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 21:53:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B95458043;
        Mon, 24 Oct 2022 21:53:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 055FB58059;
        Mon, 24 Oct 2022 21:53:57 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 21:53:56 +0000 (GMT)
Message-ID: <8e44d9d8-fcb6-c6a5-6ee6-068ebc5a72a8@linux.ibm.com>
Date:   Mon, 24 Oct 2022 17:53:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ima: Fix a potential null pointer access problem in
 ima_restore_measurement_list
Content-Language: en-US
To:     luhuaxin1@huawei.com, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
References: <20221016122047.16788-1-luhuaxin1@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221016122047.16788-1-luhuaxin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u6jkstf1HshA4jsBfFvaY-Q4gPMNyCkK
X-Proofpoint-GUID: Z1I9PwOuEaUAZ0idpCnaubwpKHrstZE3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 clxscore=1011 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/16/22 08:20, luhuaxin1@huawei.com wrote:
> From: Huaxin Lu <luhuaxin1@huawei.com>
> 
> In restore_template_fmt, when kstrdup fails, a non-NULL value will still
> be returned, which causes a NULL pointer access in template_desc_init_fields.
> 
> Co-authored-by: Jiaming Li <lijiaming30@huawei.com>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
> ---
>   security/integrity/ima/ima_template.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 07398f5..f81d4b2 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -295,8 +295,11 @@ static struct ima_template_desc *restore_template_fmt(char *template_name)
>   
>   	template_desc->name = "";
>   	template_desc->fmt = kstrdup(template_name, GFP_KERNEL);
> -	if (!template_desc->fmt)
> +	if (!template_desc->fmt) {
> +		kfree(template_desc);
> +		template_desc = NULL;
>   		goto out;
> +	}
>   
>   	spin_lock(&template_list);
>   	list_add_tail_rcu(&template_desc->list, &defined_templates);


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
