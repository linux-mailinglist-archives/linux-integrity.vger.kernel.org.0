Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450724E5CAF
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Mar 2022 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244723AbiCXBV6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Mar 2022 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiCXBV5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Mar 2022 21:21:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622C92873;
        Wed, 23 Mar 2022 18:20:25 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KP6mS2V7lzCr3L;
        Thu, 24 Mar 2022 09:18:16 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 09:20:23 +0800
Message-ID: <7831693e-f923-043e-6097-17052eb83f7e@huawei.com>
Date:   Thu, 24 Mar 2022 09:20:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] ima: remove template "ima" as the compiled default
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <roberto.sassu@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiujianfeng@huawei.com>,
        <wangweiyang2@huawei.com>
References: <20220321074737.138002-1-guozihua@huawei.com>
In-Reply-To: <20220321074737.138002-1-guozihua@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/3/21 15:47, GUO Zihua wrote:
> Template "ima" is a legacy template which limits the hash algorithm to
> either sha1 or md5. None of them should be considered "strong" these
> days. Besides, allowing template "ima" as the compiled default would
> also cause the following issue: the cmdline option "ima_hash=" must be
> behind "ima_template=", otherwise "ima_hash=" might be rejected.
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
>   security/integrity/ima/Kconfig | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index f3a9cc201c8c..9513df2ac19e 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -65,14 +65,11 @@ choice
>   	help
>   	  Select the default IMA measurement template.
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
>   	config IMA_NG_TEMPLATE
>   		bool "ima-ng (default)"
>   	config IMA_SIG_TEMPLATE
> @@ -82,7 +79,6 @@ endchoice
>   config IMA_DEFAULT_TEMPLATE
>   	string
>   	depends on IMA
> -	default "ima" if IMA_TEMPLATE
>   	default "ima-ng" if IMA_NG_TEMPLATE
>   	default "ima-sig" if IMA_SIG_TEMPLATE
>   

Hi all,

Any thought on this patch?

Thanks!

-- 
Best
GUO Zihua
