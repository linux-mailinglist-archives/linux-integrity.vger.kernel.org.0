Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570A84F62C8
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 17:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbiDFPK4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbiDFPKq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 11:10:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2DFFFB5;
        Wed,  6 Apr 2022 05:10:48 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236BgTjv003534;
        Wed, 6 Apr 2022 12:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BmKJuJMODVttv+/lBaYf3hGEbzzMxoGNKuLFEm/ZpD4=;
 b=cQs2TctgJZPet3Mwn7W4WiuDwIeZipc+5OoPbN0Lgj4yIq5IBE5X83K+XKhqMk3rixx1
 pQF0vw7KGo9vAR0vTvqMmagDcjerpMR+XVGGjWX36rc/zE7A3VPLc43zyM0jPGMaCgru
 FKJZG5c4uWdXBEuoVKT2rTnLKzW/k0j+AndLlJzqSU8N48WesLv7VSk9rXoWa40gbgST
 HJqEZVVwqBKGycbW8x0K6Kc/pLQgCaR2X4vByGv6vaUgOMxa8GJbhVV6JI1c2lz5+fw7
 422zsRb26fERlbTur4yWmiJ7REHPbjUYXDPzAVedMJR+W10kT1cRJwzZgqQEtkIqOja3 /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f94js7nh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 12:08:59 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 236BqC5Q010819;
        Wed, 6 Apr 2022 12:08:59 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f94js7ng2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 12:08:59 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236C3Hsg002663;
        Wed, 6 Apr 2022 12:08:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3f6e48xcvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 12:08:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236C8sEn35324370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 12:08:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D0A352050;
        Wed,  6 Apr 2022 12:08:54 +0000 (GMT)
Received: from sig-9-65-95-173.ibm.com (unknown [9.65.95.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7ED485204F;
        Wed,  6 Apr 2022 12:08:53 +0000 (GMT)
Message-ID: <35c38676a8b464a0fb7e4842de5108e08cb53380.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: remove the IMA_TEMPLATE Kconfig option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Apr 2022 08:08:52 -0400
In-Reply-To: <20220406061624.173584-1-guozihua@huawei.com>
References: <20220406061624.173584-1-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zpShxX2sIuoOT1E96ea0mOmgaXLBxued
X-Proofpoint-GUID: 8WkfBX0dsUk2htx-JqrPoZZgst7KIBa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_04,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-04-06 at 14:16 +0800, GUO Zihua wrote:
> It is discovered thatO allowing template "ima" as the compiled default
> would cause the following issue: the boot command line option
> "ima_hash=" must be behind "ima_template=", otherwise "ima_hash=" might
> be rejected.

The format of a proper patch description describes the current status,
provides a succinct problem description, followed by the solution.

The original 'ima' measurement list template contains a hash, defined
as 20 bytes, and a null terminated pathname, limited to 255
characters.  Other measurement list templates permit both larger hashes
and longer pathnames.  When the "ima" template is configured as the
default, a new measurement list template (ima_template=) must be
specified before specifying a larger hash algorithm (ima_hash=) on the
boot command line.

To avoid this boot command line ordering issue, remove the legacy "ima"
template configuration option, allowing it to still be specified on the
boot command line.

> 
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
> With template "ima" removed from the compiled default, we ensure that
> the default tempalte would at least be "ima-ng" which allows for
> basically any hash algorithm. Users who needs to use "ima" template
> could still do it by specifying "ima_template=ima" in boot command line.
> 
> This change would not break the algorithm compatibility checking for
> IMA.
> 
> Fixes: 4286587dccd43 ("ima: add Kconfig default measurement list template")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> ---
>  security/integrity/ima/Kconfig | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index f3a9cc201c8c..f392cac7a7d1 100644
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

Other than perhaps changing "contains" to "contained", there's no
reason for changing the text.  Adding an additional line is fine - The
configured default template can be replaced by specifying
"ima_template="  on the boot command line.

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
> @@ -102,19 +98,19 @@ choice
>  
>  	config IMA_DEFAULT_HASH_SHA256
>  		bool "SHA256"
> -		depends on CRYPTO_SHA256=y && !IMA_TEMPLATE
> +		depends on CRYPTO_SHA256=y
>  
>  	config IMA_DEFAULT_HASH_SHA512
>  		bool "SHA512"
> -		depends on CRYPTO_SHA512=y && !IMA_TEMPLATE
> +		depends on CRYPTO_SHA512=y
>  
>  	config IMA_DEFAULT_HASH_WP512
>  		bool "WP512"
> -		depends on CRYPTO_WP512=y && !IMA_TEMPLATE
> +		depends on CRYPTO_WP512=y
>  
>  	config IMA_DEFAULT_HASH_SM3
>  		bool "SM3"
> -		depends on CRYPTO_SM3=y && !IMA_TEMPLATE
> +		depends on CRYPTO_SM3=y
>  endchoice
>  
>  config IMA_DEFAULT_HASH


