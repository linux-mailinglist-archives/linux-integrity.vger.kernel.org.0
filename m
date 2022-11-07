Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C701261F40E
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Nov 2022 14:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiKGNMU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Nov 2022 08:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiKGNMU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Nov 2022 08:12:20 -0500
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F91C429
        for <linux-integrity@vger.kernel.org>; Mon,  7 Nov 2022 05:12:19 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4N5Wq32j5GzMpqsG;
        Mon,  7 Nov 2022 14:12:15 +0100 (CET)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4N5Wq22b21zy8;
        Mon,  7 Nov 2022 14:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1667826735;
        bh=ogv1+vns4rwJNA++R69lZzH0fX4ZziizzJbx9zelCzc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VbS4/VdMRvoiR4R/DPzce5YO/bNFNZ2z4S3DvPuY3yq5aLOvKr4ga49L49OpXrxF8
         SCh2qAdjw/LIP0uwiy26PdwUl/sse2AzMLyQZOdbuETSYDW4GWHDkrF4EBMrsE+Qth
         SQLgClXpRnQoDDyf7XUwtW5GZWHwFPEfYAP63O/s=
Message-ID: <3b997266-067c-975c-911a-da146fe9033a@digikod.net>
Date:   Mon, 7 Nov 2022 14:12:13 +0100
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH] certs: Prevent spurious errors on repeated blacklisting
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20221104014704.3469-1-linux@weissschuh.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221104014704.3469-1-linux@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is a follow-up of 
https://lore.kernel.org/r/c8c65713-5cda-43ad-8018-20f2e32e4432@t-8ch.de

Added Jarkko, Mark Pearson, Eric Snowberg and more ML in Cc.


On 04/11/2022 02:47, Thomas Weißschuh wrote:
> When the blacklist keyring was changed to allow updates from the root
> user it gained an ->update() function that disallows all updates.
> When the a hash is blacklisted multiple times from the builtin or
> firmware-provided blacklist this spams prominent logs during boot:
> 
> [    0.890814] blacklist: Problem blacklisting hash (-13)
> 
> As all these repeated calls to mark_raw_hash_blacklisted() would create
> the same keyring entry again anyways these errors can be safely ignored.

These errors can indeed be safely ignored, however they highlight issues 
with some firmware vendors not checking nor optimizing their blocked 
hashes. This raises security concerns, and it should be fixed by 
firmware vendors.

> 
> Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   certs/blacklist.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 41f10601cc72..5f7f2882ced7 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -191,7 +191,9 @@ static int mark_raw_hash_blacklisted(const char *hash)
>   				   BLACKLIST_KEY_PERM,
>   				   KEY_ALLOC_NOT_IN_QUOTA |
>   				   KEY_ALLOC_BUILT_IN);
> -	if (IS_ERR(key)) {
> +
> +	/* Blacklisting the same hash twice fails but would be idempotent */
> +	if (IS_ERR(key) && PTR_ERR(key) != -EACCES) {

We should not hide EACCES errors. This logs issues, which is correct for 
duplicate hashes, and can help firmware vendors to fix their database. 
I'd really like to see a different log message instead: change the 
duplicate entry error code from EACCES to EEXIST, and call pr_warn for 
this specific case.


>   		pr_err("Problem blacklisting hash (%ld)\n", PTR_ERR(key));
>   		return PTR_ERR(key);
>   	}
> 
> base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
