Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB34F1ABE
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Apr 2022 23:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379172AbiDDVS4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 17:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380531AbiDDUYh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 16:24:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B4C36B60;
        Mon,  4 Apr 2022 13:22:39 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234JAKmi006195;
        Mon, 4 Apr 2022 20:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sfw2RrUtmje6BGoULsQ9WojX8/18w10SSX3CBcUtUug=;
 b=FHk85IwWXeICJJHsltU4Mnj2ucXrR/O+B4aqoKOECxHXgFB4U9JMQ4dpGh7SJdGcf3ac
 xqTbwyiZvq+XKo+rDkje/qDdisV8/v1eMyn+/R/VVi1EXdsvrI8Ou25CaYsnygbitBV7
 oPrbIXdJ1IOqN8d08u95JL1VbLKlrwnWfDw0D6toATNVjbgOQlJADJaxunRcrzcI34m9
 J315msLcf+TGth0oLwvQI2Rpd/OHoZjppqWJ22b1G30xERvGVnewT27IM10YUTKBqI1T
 1730DRjfPxpIkSo38bFmP2cwOR3u4xqJKJMK+jLyJz4FlFWrsOuq1+QAtcpBzfCatZLY uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6yupg9e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 20:22:26 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 234KMQXf027173;
        Mon, 4 Apr 2022 20:22:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f6yupg9dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 20:22:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 234KJ58o029900;
        Mon, 4 Apr 2022 20:22:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3f6drhm91e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 20:22:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 234KMLIh50266436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Apr 2022 20:22:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E7E7A4053;
        Mon,  4 Apr 2022 20:22:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D2F2A4040;
        Mon,  4 Apr 2022 20:22:20 +0000 (GMT)
Received: from sig-9-65-92-200.ibm.com (unknown [9.65.92.200])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Apr 2022 20:22:20 +0000 (GMT)
Message-ID: <5c3565f5a46f5728873c9aedd634699ba171fe98.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: remove template "ima" as the compiled default
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiujianfeng@huawei.com,
        wangweiyang2@huawei.com
Date:   Mon, 04 Apr 2022 16:22:19 -0400
In-Reply-To: <20220321074737.138002-1-guozihua@huawei.com>
References: <20220321074737.138002-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pl8UE3lgklOhzRkfLPc-oB8xj5cwxfhv
X-Proofpoint-ORIG-GUID: JwuNMqeC0dx2dXPMiAMUKqbUJwEakXWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Guo,

The Subject line above sounds like the default template is currently
"ima", which it isn't.   Perhaps "ima: remove the IMA_TEMPLATE Kconfig
option" is more accurate.

On Mon, 2022-03-21 at 15:47 +0800, GUO Zihua wrote:
> Template "ima" is a legacy template which limits the hash algorithm to
> either sha1 or md5. None of them should be considered "strong" these
> days. Besides, allowing template "ima" as the compiled default would
> also cause the following issue: the cmdline option "ima_hash=" must be
> behind "ima_template=", otherwise "ima_hash=" might be rejected.
> 

True "ima" is a legacy template, but the purpose of removing the
IMA_TEMPLATE from the Kconfig is to address the remaining boot command
line ordering issue not previously addressed.  This is reasonable
because the "ima" template is limited to SHA1 and MD5.  If someone
still needs to use the "ima" template, "ima_template=ima" could still
be specified on the boot command line.

> The root cause of this issue is that during the processing of ima_hash,
> we would try to check whether the hash algorithm is compatible with the
> template. If the template is not set at the moment we do the check, we
> check the algorithm against the compiled default template. If the
> complied default template is "ima", then we reject any hash algorithm
> other than sha1 and md5.
> 
> For example, if the compiled default template is "ima", and the default
> algorithm is sha1 (which is the current default). In the cmdline, we put
> in "ima_hash=sha256 ima_template=ima-ng". The expected behavior would be
> that ima starts with ima-ng as the template and sha256 as the hash
> algorithm. However, during the processing of "ima_hash=",
> "ima_template=" has not been processed yet, and hash_setup would check
> the configured hash algorithm against the compiled default: ima, and
> reject sha256. So at the end, the hash algorithm that is actually used
> will be sha1.
> 
> With template "ima" removed from the compiled default, we ensure that the
> default tempalte would at least be "ima-ng" which allows for basically
> any hash algorithm.
> 
> This change would not break the algorithm compatibility checking for
> IMA.
> 
> Fixes: 4286587dccd43 ("ima: add Kconfig default measurement list template")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  security/integrity/ima/Kconfig | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index f3a9cc201c8c..9513df2ac19e 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -65,14 +65,11 @@ choice
>  	help
>  	  Select the default IMA measurement template.
>  
> -	  The original 'ima' measurement list template contains a
> -	  hash, defined as 20 bytes, and a null terminated pathname,
> -	  limited to 255 characters.  The 'ima-ng' measurement list
> -	  template permits both larger hash digests and longer
> -	  pathnames.
> -
> -	config IMA_TEMPLATE
> -		bool "ima"
> +	  The 'ima-ng' measurement list template permits various hash
> +	  digests and long pathnames. The compiled default template
> +	  can be overwritten using the kernel command line
> +	  'ima_template=' option.
> +
>  	config IMA_NG_TEMPLATE
>  		bool "ima-ng (default)"
>  	config IMA_SIG_TEMPLATE
> @@ -82,7 +79,6 @@ endchoice
>  config IMA_DEFAULT_TEMPLATE
>  	string
>  	depends on IMA
> -	default "ima" if IMA_TEMPLATE
>  	default "ima-ng" if IMA_NG_TEMPLATE
>  	default "ima-sig" if IMA_SIG_TEMPLATE
>  

The IMA_TEMPLATE definition is removed, but leaves a few references to
it.
-- 
thanks,

Mimi


