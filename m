Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272A75662F4
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jul 2022 08:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGEGLk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jul 2022 02:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEGLh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jul 2022 02:11:37 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670838A1
        for <linux-integrity@vger.kernel.org>; Mon,  4 Jul 2022 23:11:35 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aeda4.dynamic.kabel-deutschland.de [95.90.237.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 574B061EA1923;
        Tue,  5 Jul 2022 08:11:32 +0200 (CEST)
Message-ID: <2330515b-8f1d-a0e9-5577-5b7e16b2e5ca@molgen.mpg.de>
Date:   Tue, 5 Jul 2022 08:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ima: Fix a potential integer overflow in
 ima_appraise_measurement
Content-Language: en-US
To:     luhuaxin1@huawei.com
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
References: <20220705000047.1718-1-luhuaxin1@huawei.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220705000047.1718-1-luhuaxin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear HuaxinLu,


Thank you for the patch.

Am 05.07.22 um 02:00 schrieb luhuaxin1@huawei.com:
> From: HuaxinLu <luhuaxin1@huawei.com>

If these are two names, can you please add a space?

     git config --global user.name "…"
     git commit --amend --author="… <…>" -s

> When the ima-modsig is enabled, the rc passed to evm_verifyxattr() may be
> negative, which may cause the integer overflow problem.
> 
> Signed-off-by: HuaxinLu <luhuaxin1@huawei.com>

Ditto.


Kind regards,

Paul


> ---
>   security/integrity/ima/ima_appraise.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 3fb378017f9d..956fb0f4c006 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -412,7 +412,8 @@ int ima_appraise_measurement(enum ima_hooks func,
>   		goto out;
>   	}
>   
> -	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
> +	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
> +				 rc < 0 ? 0 : rc, iint);
>   	switch (status) {
>   	case INTEGRITY_PASS:
>   	case INTEGRITY_PASS_IMMUTABLE:
