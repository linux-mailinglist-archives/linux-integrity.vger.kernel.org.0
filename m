Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFFC4AB641
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Feb 2022 09:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbiBGHxd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Feb 2022 02:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbiBGHpQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Feb 2022 02:45:16 -0500
Received: from out199-16.us.a.mail.aliyun.com (out199-16.us.a.mail.aliyun.com [47.90.199.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33104C043181;
        Sun,  6 Feb 2022 23:45:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V3leFSM_1644219908;
Received: from 30.240.99.213(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V3leFSM_1644219908)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 15:45:09 +0800
Message-ID: <dada6beb-bc68-4fe0-82ad-ac502e8c1512@linux.alibaba.com>
Date:   Mon, 7 Feb 2022 15:45:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2] Fix bugs in public_key_verify_signature()
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20220201003414.55380-1-ebiggers@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20220201003414.55380-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On 2/1/22 8:34 AM, Eric Biggers wrote:
> This patchset fixes some bugs in public_key_verify_signature() where it
> could be tricked into using the wrong algorithm, as was discussed at
> https://lore.kernel.org/linux-integrity/20211202215507.298415-1-zohar@linux.ibm.com/T/#t
> 
> I'd appreciate it if the people who care about each of the supported
> public key algorithms (RSA, ECDSA, ECRDSA, and SM2) would test this
> patchset to make sure it still works for their use case(s).  I've tested
> that X.509 and PKCS#7 with RSA still work.
> 
> Note, I have *not* included a fix for SM2 being implemented incorrectly.
> That is another bug that I pointed out in the above thread.  I think
> that bug is for the people who actually care about SM2.
> 
> This applies to v5.17-rc2.
> 

Sorry for the late reply, thanks for your work.

I did the test and the x509 certificate for SM2-with-SM3 is working
fine.

Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Regarding the algorithm information in the signature data used by SM2,
I will add a patch to fix this issue, thanks for pointing it out.

Best regards,
Tianjia

> Eric Biggers (2):
>    KEYS: asymmetric: enforce that sig algo matches key algo
>    KEYS: asymmetric: properly validate hash_algo and encoding
> 
>   crypto/asymmetric_keys/pkcs7_verify.c    |   6 --
>   crypto/asymmetric_keys/public_key.c      | 126 ++++++++++++++++-------
>   crypto/asymmetric_keys/x509_public_key.c |   6 --
>   3 files changed, 91 insertions(+), 47 deletions(-)
> 
> 
> base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
