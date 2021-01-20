Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03202FC962
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 04:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbhATDrh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Jan 2021 22:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbhATDpT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jan 2021 22:45:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C867E2310D;
        Wed, 20 Jan 2021 03:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611114276;
        bh=o4dFhnmo8NNilWpjqXo1M/kBGFykKAEc+Gsy/1MMNaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bR31vcP6Ka8YVuRYmX7LQWSRt52QRzsKnPHqbssGd85Xk1ZY/1urVHIQGeiOOkFdD
         l/Fvxd1f8vlKI22JxEiRMlU5omAZq0t5i97eIWDXvRr/2zvYZxga+G6p8YOvUgJ4Qw
         9+IG9kcPd585nnH9N6I+FHPXIyv+89yajnqq+Msy0PSi8u0AU7N5UInvOPNVEhxxLP
         vl4RNsgI7QQ0UmX32It99X/QE6XShwlZIb057E+eczkXn03fhBxidPiPAEKhetyvoi
         /0un8sdQWAOGA5Uag2tMZ+3v85shMkAg+N7KqhSo8Q5q78AcNklE8eWVPMcK741Gyd
         XB2u0VNX0CtVA==
Date:   Wed, 20 Jan 2021 05:44:30 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH v3 03/10] PKCS#7: Fix missing include
Message-ID: <YAenHl0Zk8BfQfpi@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-4-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-4-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:19:02PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add missing linux/types.h for size_t.
> 
> [DH: Changed from stddef.h]
> 
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Ben Boeckel <mathstuf@gmail.com>
> ---

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> 
> Changes since v2:
> * Cherry-pick v1 patch from
>   https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
>   to rebase on v5.11-rc3.
> ---
>  include/linux/verification.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index 911ab7c2b1ab..a655923335ae 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -8,6 +8,8 @@
>  #ifndef _LINUX_VERIFICATION_H
>  #define _LINUX_VERIFICATION_H
>  
> +#include <linux/types.h>
> +
>  /*
>   * Indicate that both builtin trusted keys and secondary trusted keys
>   * should be used.
> -- 
> 2.30.0
> 
