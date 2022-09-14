Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB905B8B25
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 16:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiINO7N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiINO7L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 10:59:11 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8558673335
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 07:59:10 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7BE9872C90B;
        Wed, 14 Sep 2022 17:59:09 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 6F2A04A46F0;
        Wed, 14 Sep 2022 17:59:09 +0300 (MSK)
Date:   Wed, 14 Sep 2022 17:59:09 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 11/15] Limit configuring OpenSSL engine
 support
Message-ID: <20220914145909.ikgjdlovq5w6lg3a@altlinux.org>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
 <20220914022956.1359218-12-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220914022956.1359218-12-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 13, 2022 at 10:29:52PM -0400, Mimi Zohar wrote:
> If either OPENSSL_NO_DYNAMIC_ENGINE or OPENSSL_NO_ENGINE is defined,
> ima-evm-utils cannot be built with OpenSSL engine support. Disable
> engine support.
> 
> Suggested-by: Vitaly Chikunov <vt@altlinux.org>
> Fixes: 9e08e4495f24 ("Disable use of OpenSSL "engine" support")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  src/imaevm.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/imaevm.h b/src/imaevm.h
> index ebe8c20d566a..8114bd051514 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -52,6 +52,10 @@
>  #include <openssl/engine.h>
>  #endif
>  
> +#if defined(OPENSSL_NO_ENGINE) || defined(OPENSSL_NO_DYNAMIC_ENGINE)
> +#undef CONFIG_ENGINE
> +#endif

Thanks.

Only better it would be to make it prefixed with something like
IMA_EVN_, since CONFIG_ENGINE looks too generic (and we cannot move it
outside of imaevm.h). And perhaps merge this patch with "Disable use of
OpenSSL "engine" support"?

Vitaly,

> +
>  #ifdef USE_FPRINTF
>  #define do_log(level, fmt, args...)	\
>  	({ if (level <= imaevm_params.verbose) fprintf(stderr, fmt, ##args); })
> -- 
> 2.31.1
