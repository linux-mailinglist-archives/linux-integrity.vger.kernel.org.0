Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20111602E07
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Oct 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiJROLP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Oct 2022 10:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiJROK5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Oct 2022 10:10:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD685647D2;
        Tue, 18 Oct 2022 07:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC3D5B81F70;
        Tue, 18 Oct 2022 14:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15560C433C1;
        Tue, 18 Oct 2022 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666102243;
        bh=GZeQhv33D3zVDt2g8J7jPKYmYI7gz3wmR3KSKFf0vnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGIhmEWaQ5FBxgU4u024LOBNRwMkOMH4NXh5l3nxCa9p9kL6rgLm1hwQBlnoRVbr9
         pNf86TL9ccIPRc9Z6xrM8Eik0t0ZCjBZu1xhNBF2lPtfUX6XKkjq2Esz+oZCEgIQ6B
         R6nyhjMgr8KnMVOIj+QCAcjETjzff9eMhLT3w/CoJdn/NCRTPNy7EkvvXfUSVslyRv
         h11S73PY3I2B51V72f8i1UrHR062I4g/yZMhA04yVx4BMLzkOKJVMgy5uTSZ11FVCT
         hn+81PKB8KuGAZsFRSulGEv0fbNKx3M9jm+tK4/GR7M2xNpxZIGk9XJsOiT+xmCyLB
         PB/yAg9vRgXdA==
Date:   Tue, 18 Oct 2022 16:10:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 6/9] fs: Introduce file_to_perms() helper
Message-ID: <20221018141037.zzpfjzutqbutbpiy@wittgenstein>
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221013223654.659758-6-keescook@chromium.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 13, 2022 at 03:36:51PM -0700, Kees Cook wrote:
> Extract the logic used by LSM file hooks to be able to reconstruct the
> access mode permissions from an open.
> 
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fs.h               | 22 ++++++++++++++++++++++
>  security/apparmor/include/file.h | 18 ++++--------------
>  2 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9eced4cc286e..814f10d4132e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -993,6 +993,28 @@ static inline struct file *get_file(struct file *f)
>  #define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
>  #define file_count(x)	atomic_long_read(&(x)->f_count)
>  
> +/* Calculate the basic MAY_* flags needed for a given file. */
> +static inline u8 file_to_perms(struct file *file)

As long as there aren't multiple users of this and especially none in
the vfs proper please don't move this into fs.h. It's overloaded enough
as it is and we have vague plans on splitting it further in the future.
