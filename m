Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F259545A57
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 05:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiFJDNo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 23:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDNo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 23:13:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7385930AB5B;
        Thu,  9 Jun 2022 20:13:41 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LK5dC0qjDzDqjc;
        Fri, 10 Jun 2022 11:13:19 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 11:13:39 +0800
Subject: Re: [PATCH -next] Revert "evm: Fix memleak in init_desc"
From:   xiujianfeng <xiujianfeng@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220527111726.195825-1-xiujianfeng@huawei.com>
Message-ID: <c34789ad-0a3e-c534-8a74-28c3068602a1@huawei.com>
Date:   Fri, 10 Jun 2022 11:13:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220527111726.195825-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, ping....

ÔÚ 2022/5/27 19:17, Xiu Jianfeng Ð´µÀ:
> This reverts commit ccf11dbaa07b328fa469415c362d33459c140a37.
>
> Commit ccf11dbaa07b ("evm: Fix memleak in init_desc") said there is
> memleak in init_desc. That may be incorrect, as we can see, tmp_tfm is
> saved in one of the two global variables hmac_tfm or evm_tfm[hash_algo],
> then if init_desc is called next time, there is no need to alloc tfm
> again, so in the error path of kmalloc desc or crypto_shash_init(desc),
> It is not a problem without freeing tmp_tfm.
>
> And also that commit did not reset the global variable to NULL after
> freeing tmp_tfm and this makes *tfm a dangling pointer which may cause a
> UAF issue.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   security/integrity/evm/evm_crypto.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index a733aff02006..708de9656bbd 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -75,7 +75,7 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
>   {
>   	long rc;
>   	const char *algo;
> -	struct crypto_shash **tfm, *tmp_tfm = NULL;
> +	struct crypto_shash **tfm, *tmp_tfm;
>   	struct shash_desc *desc;
>   
>   	if (type == EVM_XATTR_HMAC) {
> @@ -120,16 +120,13 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
>   alloc:
>   	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
>   			GFP_KERNEL);
> -	if (!desc) {
> -		crypto_free_shash(tmp_tfm);
> +	if (!desc)
>   		return ERR_PTR(-ENOMEM);
> -	}
>   
>   	desc->tfm = *tfm;
>   
>   	rc = crypto_shash_init(desc);
>   	if (rc) {
> -		crypto_free_shash(tmp_tfm);
>   		kfree(desc);
>   		return ERR_PTR(rc);
>   	}
