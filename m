Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C183F2232
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhHSVUw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 17:20:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46356 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhHSVUv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 17:20:51 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5315C72C8F8;
        Fri, 20 Aug 2021 00:20:13 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 27DF24A46F1;
        Fri, 20 Aug 2021 00:20:13 +0300 (MSK)
Date:   Fri, 20 Aug 2021 00:20:12 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
Message-ID: <20210819212012.uoi4aaxzv4egirkd@altlinux.org>
References: <20210819021136.664597-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210819021136.664597-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 19, 2021 at 05:11:36AM +0300, Vitaly Chikunov wrote:
> After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Change from v1:
> - Do not use setfbuf to disable buffering as this is not proven to be
>   meaningful.
> - Use secure heap for passwords too as suggested by Mimi Zohar.
> - Fallback to OPENSSL_malloc for old OpenSSL as suggested by Mimi Zohar.
> - Simplify logic of calling CRYPTO_secure_malloc_init (call it always on
>   OpenSSL init.)
> - Should be applied after Bruno Meneguele's "evmctl: fix memory leak in
>   get_password" patch v2.
> 
>  src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 118 insertions(+), 25 deletions(-)
> 
> @@ -2651,6 +2721,16 @@ int main(int argc, char *argv[])
>  #endif
>  			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
>  #endif
> +#if OPENSSL_VERSION_NUMBER > 0x10100000
> +	/*
> +	 * This facility is available since OpenSSL_1_1_0-pre1.
> +	 * 'Heap size' 8192 is chosen to be big enough, so that any single key
> +	 * data could fit. 'Heap minsize' 64 is just to be efficient for small
> +	 * buffers.
> +	 */
> +       CRYPTO_secure_malloc_init(8192, 64);
> +#endif

Forgot to check return value of this.

Thanks,

