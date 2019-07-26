Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F875DE0
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 06:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfGZEhW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 00:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfGZEhW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 00:37:22 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D2422BE8;
        Fri, 26 Jul 2019 04:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564115841;
        bh=1nt7q8KxuqRj39ao5XXnNzUnhd9l2e/3yTz4YLjJoXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVBxM/YV8tvQiY8Qz7TwN9/0ZnDu7VgpBpwwwkwyW7i9HzUhRuKogVAVDOy14013F
         LGG4C+p4aZZQzL6s0BJAkmDVCj9w5GHvB+9lKBM3O8kJdvvv4gahecherBfmWvKHKK
         pdn4Heg8oyDdq98B3/8yKc2xXShzOIFt3zFK5cHc=
Date:   Thu, 25 Jul 2019 21:37:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 4/5] IMA: use obj-y for non-modular objects
Message-ID: <20190726043719.GB643@sol.localdomain>
Mail-Followup-To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20190726021058.4212-1-yamada.masahiro@socionext.com>
 <20190726021058.4212-5-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726021058.4212-5-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 26, 2019 at 11:10:57AM +0900, Masahiro Yamada wrote:
> CONFIG_IMA is a boolean option, so none of these objects is linked
> into a module.
> 
> All the objects in this directory are compiled only when CONFIG_IMA=y
> since this directory is guarded by the parent Makefile:
> 
>   obj-$(CONFIG_IMA)                       += ima/
> 
> So, there is no point in creating the composite object, ima.o
> 
> Flatten the code into the obj-$(CONFIG_...) form.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  security/integrity/ima/Makefile | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index d921dc4f9eb0..5517486c9154 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -4,10 +4,8 @@
>  # Measurement Architecture(IMA).
>  #
>  
> -obj-$(CONFIG_IMA) += ima.o
> -
> -ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
> +obj-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
>  	 ima_policy.o ima_template.o ima_template_lib.o
> -ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
> -ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
> +obj-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
> +obj-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
> -- 

This patch changes the kernel command line options

	ima.ahash_minsize
	ima.ahash_bufsize

to
	ima_crypto.ahash_minsize
	ima_crypto.ahash_bufsize

Intentional?

Note that these are documented in
Documentation/admin-guide/kernel-parameters.txt.

- Eric
