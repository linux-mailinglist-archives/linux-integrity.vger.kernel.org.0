Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71704AD408
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Feb 2022 09:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiBHIxZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Feb 2022 03:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiBHIxY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 03:53:24 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ED3C03FEC0;
        Tue,  8 Feb 2022 00:53:23 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtGwh4xFCzbkKJ;
        Tue,  8 Feb 2022 16:52:20 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 16:53:20 +0800
Message-ID: <e852660c-17fa-cd75-e361-45dd77b8884d@huawei.com>
Date:   Tue, 8 Feb 2022 16:53:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>,
        "xiujianfeng@huawei.com" <xiujianfeng@huawei.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
Subject: Problem with commit ccf11dbaa07b ("evm: Fix memleak in init_desc")
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

I found an issue with commit ccf11dbaa07b ("evm: Fix memleak in init_desc").

This commit tries to free variable "tmp_tfm" if something went wrong 
after the "alloc" label in function init_desc, which would potentially 
cause a user-after-free issue

The codes are as follows:

   1 static struct shash_desc *init_desc(char type, uint8_t hash_algo)
   2 {
   3 	long rc;
   4 	const char *algo;
   5 	struct crypto_shash **tfm, *tmp_tfm = NULL;
   6 	struct shash_desc *desc;
   7
   8 	if (type == EVM_XATTR_HMAC) {
   9 		if (!(evm_initialized & EVM_INIT_HMAC)) {
  10 			pr_err_once("HMAC key is not set\n");
  11 			return ERR_PTR(-ENOKEY);
  12 		}
  13 		tfm = &hmac_tfm;
  14 		algo = evm_hmac;
  15 	} else {
  16 		if (hash_algo >= HASH_ALGO__LAST)
  17 			return ERR_PTR(-EINVAL);
  18
  19 		tfm = &evm_tfm[hash_algo];
  20 		algo = hash_algo_name[hash_algo];
  21 	}
  22
  23 	if (*tfm)
  24 		goto alloc;
  25 	mutex_lock(&mutex);
  26 	if (*tfm)
  27 		goto unlock;
  28
  29 	tmp_tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
  30 	if (IS_ERR(tmp_tfm)) {
  31 		pr_err("Can not allocate %s (reason: %ld)\n", algo,
  32 		       PTR_ERR(tmp_tfm));
  33 		mutex_unlock(&mutex);
  34 		return ERR_CAST(tmp_tfm);
  35 	}
  36 	if (type == EVM_XATTR_HMAC) {
  37 		rc = crypto_shash_setkey(tmp_tfm, evmkey, evmkey_len);
  38 		if (rc) {
  39 			crypto_free_shash(tmp_tfm);
  40 			⋅mutex_unlock(&mutex);
  41 			return ERR_PTR(rc);
  42 		}
  43 	}
  44 	*tfm = tmp_tfm;
  45 unlock:
  46 	mutex_unlock(&mutex);
  47 alloc:
  48 	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
  49 			GFP_KERNEL);
  50 	if (!desc) {
  51 		crypto_free_shash(tmp_tfm);
  52 		return ERR_PTR(-ENOMEM);
  53 	}
  54
  55 	desc->tfm = *tfm;
  56
  57 	rc = crypto_shash_init(desc);
  58 	if (rc) {
  59 		crypto_free_shash(tmp_tfm);
  60 		kfree(desc);
  61 		return ERR_PTR(rc);
  62 	}
  63 	return desc;
  64 }

As we can see, variable *tfm points to one of the two global variable 
hmac_tfm or evm_tfm[hash_algo]. tmp_tfm is used as an intermediate 
variable for initializing these global variables. Freeing tmp_tfm after 
line 44 would invalidate these global variables and potentially cause a 
user-after-free issue.

I think this commit should be reverted.

Reference: commit 843385694721 ("evm: Fix a small race in init_desc()")

-- 
Best
GUO Zihua
