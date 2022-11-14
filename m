Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5455F6277E0
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 09:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbiKNIiC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Nov 2022 03:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiKNIiC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Nov 2022 03:38:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743401C10E;
        Mon, 14 Nov 2022 00:38:01 -0800 (PST)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9jNp58WtzHvwM;
        Mon, 14 Nov 2022 16:37:30 +0800 (CST)
Received: from frapeml500005.china.huawei.com (7.182.85.13) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 16:37:58 +0800
Received: from frapeml500005.china.huawei.com ([7.182.85.13]) by
 frapeml500005.china.huawei.com ([7.182.85.13]) with mapi id 15.01.2375.031;
 Mon, 14 Nov 2022 09:37:57 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Xiujianfeng <xiujianfeng@huawei.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "roberto.sassu@polito.it" <roberto.sassu@polito.it>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ima: Fix misuse of dereference of pointer in
 template_desc_init_fields()
Thread-Topic: [PATCH] ima: Fix misuse of dereference of pointer in
 template_desc_init_fields()
Thread-Index: AQHY9nmHvrnDarYK/E2x2ibr+a0VfK4+GPqQ
Date:   Mon, 14 Nov 2022 08:37:57 +0000
Message-ID: <55100c2e550b4649b5a751ca4596fe7c@huawei.com>
References: <20221112092719.224888-1-xiujianfeng@huawei.com>
In-Reply-To: <20221112092719.224888-1-xiujianfeng@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Xiujianfeng
> Sent: Saturday, November 12, 2022 10:27 AM
> The input parameter @fields is type of struct ima_template_field ***, so
> when allocates array memory for @fields, the size of element should be
> sizeof(**field) instead of sizeof(*field).
> 
> Actually the original code would not cause any runtime error, but it's
> better to make it logically right.
> 
> Fixes: adf53a778a0a ("ima: new templates management mechanism")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
>  security/integrity/ima/ima_template.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_template.c
> b/security/integrity/ima/ima_template.c
> index 49f0626928a1..04c49f05cb74 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -245,11 +245,11 @@ int template_desc_init_fields(const char
> *template_fmt,
>  	}
> 
>  	if (fields && num_fields) {
> -		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
> +		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
>  		if (*fields == NULL)
>  			return -ENOMEM;
> 
> -		memcpy(*fields, found_fields, i * sizeof(*fields));
> +		memcpy(*fields, found_fields, i * sizeof(**fields));
>  		*num_fields = i;
>  	}
> 
> --
> 2.17.1

