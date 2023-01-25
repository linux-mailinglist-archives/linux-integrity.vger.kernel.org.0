Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DC67B2FB
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 14:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjAYNKF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 08:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAYNKE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 08:10:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA248A39;
        Wed, 25 Jan 2023 05:10:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P241w5FBpz4xN5;
        Thu, 26 Jan 2023 00:09:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1674652197;
        bh=Fwm8ctv+aCNu1LYwfHNIxF2N4IkFJEym+qN9b8CLahU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lNFbFff2B/+4f6CEwrZJlkdL7Wg89pqNa6jlqXE86gaDP07osJlKhAXgJ7PPsVJ7P
         rIP+e3JfSbHKBTSyIRtukysVpTAa1cPdGtDHNY8W6vFSAz8eU9xWYhl1WB9QCDPBQ8
         8QWqiD4xaO6Fa83SzLFtimmjvSNe59I68T5zV2osJSscYqiDVSD1MfTq12uPcMX4FG
         pIlhwukmzXgPvzyUUk3HQ3lzrGbkQpbtno/bdJtTtINvFEgfYJyxh3GOmTkHazquZV
         2yqydn4pJY/gAY1sbX8ooTIPL+shpN8u+NFwihi5Ra7HCmrXTcethT0vHJPV//UUoY
         xd1DMy9d/9S9Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, gjoyce@linux.ibm.com,
        sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        joel@jms.id.au
Subject: Re: [PATCH v4 02/24] powerpc/pseries: Fix alignment of PLPKS
 structures and buffers
In-Reply-To: <20230120074306.1326298-3-ajd@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-3-ajd@linux.ibm.com>
Date:   Thu, 26 Jan 2023 00:09:53 +1100
Message-ID: <87pmb2pxpa.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Andrew Donnellan <ajd@linux.ibm.com> writes:
> A number of structures and buffers passed to PKS hcalls have alignment
> requirements, which could on occasion cause problems:
>
> - Authorisation structures must be 16-byte aligned and must not cross a
>   page boundary
>
> - Label structures must not cross page boundaries
>
> - Password output buffers must not cross page boundaries
>
> Round up the allocations of these structures/buffers to the next power of
> 2 to make sure this happens.

It's not the *next* power of 2, it's the *nearest* power of 2, including
the initial value if it's already a power of 2.

That in conjunction with slab's guarantee that power of 2 sized objects
are naturally aligned, and that the relevant structs are smaller than a
page, is what makes this actually work.

So I think the patch is fine, but the change log and comments probably
need to be a bit clearer.

cheers

> Reported-by: Benjamin Gray <bgray@linux.ibm.com>
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Reviewed-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
> ---
>
> v3: Merge plpks fixes and signed update series with secvar series
>
> v4: Fix typo in commit message
>
>     Move up in series (npiggin)
> ---
>  arch/powerpc/platforms/pseries/plpks.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index 9e85b6d85b0b..a01cf2ff140a 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -126,7 +126,8 @@ static int plpks_gen_password(void)
>  	u8 *password, consumer = PKS_OS_OWNER;
>  	int rc;
>  
> -	password = kzalloc(maxpwsize, GFP_KERNEL);
> +	// The password must not cross a page boundary, so we align to the next power of 2
> +	password = kzalloc(roundup_pow_of_two(maxpwsize), GFP_KERNEL);
>  	if (!password)
>  		return -ENOMEM;
>  
> @@ -162,7 +163,9 @@ static struct plpks_auth *construct_auth(u8 consumer)
>  	if (consumer > PKS_OS_OWNER)
>  		return ERR_PTR(-EINVAL);
>  
> -	auth = kzalloc(struct_size(auth, password, maxpwsize), GFP_KERNEL);
> +	// The auth structure must not cross a page boundary and must be
> +	// 16 byte aligned. We align to the next largest power of 2
> +	auth = kzalloc(roundup_pow_of_two(struct_size(auth, password, maxpwsize)), GFP_KERNEL);
>  	if (!auth)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -196,7 +199,8 @@ static struct label *construct_label(char *component, u8 varos, u8 *name,
>  	if (component && slen > sizeof(label->attr.prefix))
>  		return ERR_PTR(-EINVAL);
>  
> -	label = kzalloc(sizeof(*label), GFP_KERNEL);
> +	// The label structure must not cross a page boundary, so we align to the next power of 2
> +	label = kzalloc(roundup_pow_of_two(sizeof(*label)), GFP_KERNEL);
>  	if (!label)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.39.0
