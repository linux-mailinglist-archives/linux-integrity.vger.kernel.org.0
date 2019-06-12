Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A42F42719
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jun 2019 15:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439374AbfFLNL2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jun 2019 09:11:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33003 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439360AbfFLNL2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 09:11:28 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DCF37E5B2385AE93A864;
        Wed, 12 Jun 2019 14:11:26 +0100 (IST)
Received: from [10.220.96.108] (10.220.96.108) by smtpsuk.huawei.com
 (10.201.108.35) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 12 Jun
 2019 14:11:20 +0100
Subject: Re: [PATCH v3 0/2] ima/evm fixes for v5.2
To:     Janne Karhunen <janne.karhunen@gmail.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20190606112620.26488-1-roberto.sassu@huawei.com>
 <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <d9efe3c7-20dd-bbb0-40d8-40f69cba5b88@huawei.com>
Date:   Wed, 12 Jun 2019 15:11:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcraYOw9B3RFu3_DbJs9nPT87AtQEptC7zF4kAu4FP8YhxA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.220.96.108]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/12/2019 1:28 PM, Janne Karhunen wrote:
> On Thu, Jun 6, 2019 at 3:27 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>>
>> Previous versions included the patch 'ima: don't ignore INTEGRITY_UNKNOWN
>> EVM status'. However, I realized that this patch cannot be accepted alone
>> because IMA-Appraisal would deny access to new files created during the
>> boot.
> 
> The early initialization logic seems to have been changing, the
> original one as I have understood it:
> - before initialization
>    - allow reading anything without security.ima
>    - deny reading anything with security.ima

These two should be probably inverted: deny..., allow...


>    - allow all writes

Allow writing anything with security.ima
Allow writing new files


> - after initialization
>    - deny reading|writing anything without security.ima
>    - deny reading|writing anything invalid
>    - allow everything else
> 
> The logic is pretty handy as it even creates additional layer of
> security around the early initialization files as they become
> unreadable after use.

What if they should be legitimately used after the HMAC key is unsealed
and before switching to the persistent root file system?


> Now, if we initialize the system with a random key like in your patch,
> this logic is to change quite drastically? It sounds to me the
> userland may actually break, all the userland initialization files in
> the existing ima configurations that do not use digsigs would become
> unreadable given that the random key is put in? Remember, those files
> can be protected via other means (most commonly signed ramdisk).

No, the first patch is about adding the ability to verify files created
during each boot. For any other file, EVM returns INTEGRITY_UNKNOWN as
before. The second patch changes the behavior, as INTEGRITY_UNKNOWN is
considered as an error for the enforce-evm appraisal mode. The second
patch aims at making the system more secure, as no file would be
accessible unless it is verified.

It is true that configurations without digsigs won't work anymore but
the alternative is accepting any file until the HMAC key is unsealed.

Signing the ramdisk is for sure a possibility, but IMA would be
sufficient to provide integrity protection as it checks any file in the
ram disk.

Unfortunately I found an issue in patch 1/2. These changes should be
applied:

--
diff --git a/security/integrity/evm/evm_main.c 
b/security/integrity/evm/evm_main.c
index faa4a02a3139..f4af595678fe 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -310,10 +310,14 @@ EXPORT_SYMBOL_GPL(evm_verifyxattr);
  static enum integrity_status evm_verify_current_integrity(struct 
dentry *dentry)
  {
         struct inode *inode = d_backing_inode(dentry);
+       int rc;

         if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
                 return 0;
-       return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
+       rc = evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
+       if (rc == INTEGRITY_UNKNOWN && !evm_persistent_key_loaded())
+               return 0;
+       return rc;
  }

  /*
--

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
