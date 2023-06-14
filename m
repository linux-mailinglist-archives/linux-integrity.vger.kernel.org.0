Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCFF73064C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jun 2023 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjFNRsM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jun 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbjFNRsK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jun 2023 13:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499392118;
        Wed, 14 Jun 2023 10:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D304163CF5;
        Wed, 14 Jun 2023 17:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D56C433C0;
        Wed, 14 Jun 2023 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686764888;
        bh=YrAZvPKVQGbC5dGB/a7wbi3mgxdY3L1+JQfpWxM895Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+LVNb6RE7vuGzsqCMKRrg9AGs1i6Ved90j3vfM9wp7FT2fspGjtY/o+p8Nqk3Aht
         ZpdfeIr3XnnA3iE+GcgGHv+bMwoFYWlrqAjSdET106QCi7zevg5RviAlbWNBKQBgQP
         EubB4Bte2NrONa0iGhIJ21W1qb/TMhokTzqADHSBXLaENGQvvsAjizHetVEQPFMyoO
         0siWQEcwMQKqdrU4Q44i1Jw6B2yqpEAuYqaGqjm5WRo2dpqgnmYedKHz8YdOh73qwC
         QhkHMzY71MIkQQuSA+m+7e+5QNoaIpxSPT7MpOy8F/P0uixOYAQODNMhq7PoT42+5U
         Vi04DznalRbtQ==
Date:   Wed, 14 Jun 2023 10:48:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Alexander Larsson <alexl@redhat.com>
Subject: Re: [PATCH] fsverity: rework fsverity_get_digest() again
Message-ID: <20230614174805.GD1146@sol.localdomain>
References: <20230612190047.59755-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612190047.59755-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 12, 2023 at 12:00:47PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Address several issues with the calling convention and documentation of
> fsverity_get_digest():
> 
> - Make it provide the hash algorithm as either a FS_VERITY_HASH_ALG_*
>   value or HASH_ALGO_* value, at the caller's choice, rather than only a
>   HASH_ALGO_* value as it did before.  This allows callers to work with
>   the fsverity native algorithm numbers if they want to.  HASH_ALGO_* is
>   what IMA uses, but other users (e.g. overlayfs) should use
>   FS_VERITY_HASH_ALG_* to match fsverity-utils and the fsverity UAPI.
> 
> - Make it return the digest size so that it doesn't need to be looked up
>   separately.  Use the return value for this, since 0 works nicely for
>   the "file doesn't have fsverity enabled" case.  This also makes it
>   clear that no other errors are possible.
> 
> - Rename the 'digest' parameter to 'raw_digest' and clearly document
>   that it is only useful in combination with the algorithm ID.  This
>   hopefully clears up a point of confusion.
> 
> - Export it to modules, since overlayfs will need it for checking the
>   fsverity digests of lowerdata files
>   (https://lore.kernel.org/r/dd294a44e8f401e6b5140029d8355f88748cd8fd.1686565330.git.alexl@redhat.com).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/measure.c              | 37 ++++++++++++++++++++++----------
>  include/linux/fsverity.h         | 14 +++++++-----
>  security/integrity/ima/ima_api.c | 31 +++++++++++---------------
>  3 files changed, 47 insertions(+), 35 deletions(-)
> 

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

- Eric
