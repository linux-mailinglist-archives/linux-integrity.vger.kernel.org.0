Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2061555B
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 23:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiKAWzW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiKAWzW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 18:55:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BFA10071
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 15:55:20 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1MabjO032745;
        Tue, 1 Nov 2022 22:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=r3X6dVQv+uOs7k+5p9p5CdAqc+FHNn8t6KcN4utkgFM=;
 b=hGQDnt/Th7CGlobjt9DR8VeQ6o5a24+iup+fQfx6hC14QkG38MLLepwfILOX+1N+rp6L
 NteWgmpVuUVZZSi/f8fWxfxA8L3fAnO6SIFnNG1UtYI3jOb52Bof1f1aLNNXIrkrwtco
 X6PdHG2DovskEZgl9xHuCY5q6BS2gjU9oPh2IewExVtRqL7Ll55EUNcRUsxGGpPdJYMS
 2xK7ko6mlZr7TgN8XUWFA1Xc3tuXhoBhoGFx2BU+z23pwrb6gED7MholRpQ+tptQ116Q
 isDP/cNOybbUSOucyKWQuimSwZ0tgR6x5gANq+pTyNWhZG9tNHv1e3ZCtX45l4hfwtoc xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtw3mdwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 22:55:15 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A1McVFP009055;
        Tue, 1 Nov 2022 22:55:15 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjtw3mdw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 22:55:15 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1MoNet031154;
        Tue, 1 Nov 2022 22:55:13 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 3kgut9pxsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 22:55:13 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1MtCqS64029088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 22:55:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5097358063;
        Tue,  1 Nov 2022 22:55:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7CA55805D;
        Tue,  1 Nov 2022 22:55:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.106.109])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 22:55:11 +0000 (GMT)
Message-ID: <be3cceef770591bd56ef1816607daf1e4b2debb2.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix a potential null pointer access problem in
 ima_restore_measurement_list
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     luhuaxin1@huawei.com, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com
Date:   Tue, 01 Nov 2022 18:55:11 -0400
In-Reply-To: <20221016122047.16788-1-luhuaxin1@huawei.com>
References: <20221016122047.16788-1-luhuaxin1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lremk8lRfUqVoutWpagmZ4-4_hs_G2Tn
X-Proofpoint-GUID: OrC45LiVljFJscdzyLEjIHy6cLbXHbr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010153
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Huaxin,

Thank you for the patch.

On Sun, 2022-10-16 at 20:20 +0800, luhuaxin1@huawei.com wrote:
> From: Huaxin Lu <luhuaxin1@huawei.com>
> 
> In restore_template_fmt, when kstrdup fails, a non-NULL value will still
> be returned, which causes a NULL pointer access in template_desc_init_fields.
> 
> Co-authored-by: Jiaming Li <lijiaming30@huawei.com>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>

scripts/checkpatch.pl complains:
-  The "Subject:" line being too long.  Refer to "summary phrase"  in
Documentation/process/submitting-patches.rst.
- Instead of "Co-authored-by" submitting-patches suggests "Co-
developed-by".

In addition, the patch author and your mailer need to be sync.  Please
fix your mailer so that the "From:" line is unnecessary.

Otherwise,
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/integrity/ima/ima_template.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 07398f5..f81d4b2 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -295,8 +295,11 @@ static struct ima_template_desc *restore_template_fmt(char *template_name)
>  
>  	template_desc->name = "";
>  	template_desc->fmt = kstrdup(template_name, GFP_KERNEL);
> -	if (!template_desc->fmt)
> +	if (!template_desc->fmt) {
> +		kfree(template_desc);
> +		template_desc = NULL;
>  		goto out;
> +	}
>  
>  	spin_lock(&template_list);
>  	list_add_tail_rcu(&template_desc->list, &defined_templates);




