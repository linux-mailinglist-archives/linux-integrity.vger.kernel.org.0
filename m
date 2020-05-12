Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E69E1CF35D
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 13:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgELLb4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 07:31:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbgELLb4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 07:31:56 -0400
Received: from lhreml734-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 93B077B62A5966C73782;
        Tue, 12 May 2020 12:31:54 +0100 (IST)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml734-chm.china.huawei.com (10.201.108.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 12 May 2020 12:31:54 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 12 May 2020 13:31:53 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 12 May 2020 13:31:53 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [bug report] evm: Check also if *tfm is an error pointer in
 init_desc()
Thread-Topic: [bug report] evm: Check also if *tfm is an error pointer in
 init_desc()
Thread-Index: AQHWKEtaMY8eDHenCUWhAoTwHpVMaaikTD1Q
Date:   Tue, 12 May 2020 11:31:53 +0000
Message-ID: <267804d00f2e457186509a6ae40c9c7f@huawei.com>
References: <20200512104809.GA262740@mwanda>
In-Reply-To: <20200512104809.GA262740@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.12.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, May 12, 2020 12:48 PM
> 
> Hello Roberto Sassu,
> 
> The patch 53de3b080d5e: "evm: Check also if *tfm is an error pointer
> in init_desc()" from Apr 27, 2020, leads to the following static
> checker warning:
> 
> 	security/integrity/evm/evm_crypto.c:119 init_desc()
> 	error: '*tfm' dereferencing possible ERR_PTR()
> 
> security/integrity/evm/evm_crypto.c
>     89
>     90                  tfm = &evm_tfm[hash_algo];
>     91                  algo = hash_algo_name[hash_algo];
>     92          }
>     93
>     94          if (IS_ERR_OR_NULL(*tfm)) {
> 
> This used to be a "if (!*tfm)" check.
> 
>     95                  mutex_lock(&mutex);
>     96                  if (*tfm)
>     97                          goto out;
> 
> Then we test again with the lock held.  But in the new code if "*tfm"
> is an error pointer then we jump directly to the unlock and crash on the
> next line.  I can't see how the commit would fix anything.

Hello Dan

you are right. The fix should be applied in both places.

if (!IS_ERR_OR_NULL(*tfm))
	goto out;

>     98                  *tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
>     99                  if (IS_ERR(*tfm)) {
>    100                          rc = PTR_ERR(*tfm);
>    101                          pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
>    102                          *tfm = NULL;
>    103                          mutex_unlock(&mutex);
>    104                          return ERR_PTR(rc);
>    105                  }
>    106                  if (type == EVM_XATTR_HMAC) {
>    107                          rc = crypto_shash_setkey(*tfm, evmkey, evmkey_len);
>    108                          if (rc) {
>    109                                  crypto_free_shash(*tfm);
>    110                                  *tfm = NULL;
>    111                                  mutex_unlock(&mutex);
>    112                                  return ERR_PTR(rc);
>    113                          }
>    114                  }
>    115  out:
>    116                  mutex_unlock(&mutex);
>    117          }
>    118
>    119          desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
>                                                                      ^^^^
> I don't understand how using *tfm outside of a lock is safe at all
> anyway.

I think the purpose of the mutex is just to  prevent two concurrent
allocations. Later, it should not be a problem, as *tfm is never freed.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli


>    120                          GFP_KERNEL);
>    121          if (!desc)
>    122                  return ERR_PTR(-ENOMEM);
>    123
> 
> regards,
> dan carpenter
