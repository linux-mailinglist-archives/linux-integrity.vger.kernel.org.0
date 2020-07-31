Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C0E234B5D
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGaS4g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:56:36 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52948 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgGaS4g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:56:36 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F306972CCDC;
        Fri, 31 Jul 2020 21:56:33 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D4FDB4A4AE7;
        Fri, 31 Jul 2020 21:56:33 +0300 (MSK)
Date:   Fri, 31 Jul 2020 21:56:33 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200731182408.696931-6-zohar@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Fri, Jul 31, 2020 at 02:24:08PM -0400, Mimi Zohar wrote:
> The openssl version on travis doesn't have gost openssl engine support.
> Download from source, rebuild and install local version.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .travis.yml                  |  7 +++++++
>  tests/install-gost-engine.sh | 10 ++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100755 tests/install-gost-engine.sh
> 
> diff --git a/.travis.yml b/.travis.yml
> index 11a827c02f0a..f5fb2c1da448 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -15,6 +15,13 @@ matrix:
>     include:
>       - env: TSS=ibmtss
>       - env: TSS=tpm2-tss
> +
> +before_install:
> +   - if [ "${SSL}" = "openssl" ]; then
> +        ./tests/install-gost-engine.sh;
> +        openssl version;
> +     fi
> +
>  install:
>     - if [ "${TSS}" = "tpm2-tss" ]; then
>             sudo apt-get install lcov pandoc autoconf-archive liburiparser-dev;
> diff --git a/tests/install-gost-engine.sh b/tests/install-gost-engine.sh
> new file mode 100755
> index 000000000000..01bcf2c3bc21
> --- /dev/null
> +++ b/tests/install-gost-engine.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +
> +openssl version
> +
> +git clone https://github.com/gost-engine/engine.git

gost-engine master branch corresponds to openssl-3.0 which is probably
not on Travis systems yet. I think branch `openssl_1_1_0` should be used.

  git clone --branch openssl_1_1_0 https://github.com/gost-engine/engine.git

Thanks,

> +cd engine
> +#cmake -DOPENSSL_INCLUDE_DIR=/usr/local/include/openssl -DOPENSSL_SSL_LIBRARY=/usr/local/lib64/libss.so -DOPENSSL_CRYPTO_LIBRARY=/usr/local/lib64/libcrypto.so -DOPENSSL_ENGINES_DIR=/usr/local/lib64/engines-1.1 .
> +cmake .
> +sudo make install
> +cd ..
> -- 
> 2.18.4
