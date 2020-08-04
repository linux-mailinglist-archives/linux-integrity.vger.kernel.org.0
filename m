Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D5523BC89
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgHDOp7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 10:45:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58806 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgHDOp6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 10:45:58 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 17FAC72CCE9;
        Tue,  4 Aug 2020 17:45:55 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 098A14A4AEE;
        Tue,  4 Aug 2020 17:45:55 +0300 (MSK)
Date:   Tue, 4 Aug 2020 17:45:54 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH v1 5/5] ima-evm-utils: travis: openssl
 gost engine
Message-ID: <20200804144554.6y3c44popmu6nha7@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <70b421b26c7073dcc7d9b8f210ba2900ecf2b8d3.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <70b421b26c7073dcc7d9b8f210ba2900ecf2b8d3.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Aug 04, 2020 at 08:05:31AM -0400, Mimi Zohar wrote:
> The openssl version might not have gost openssl engine support.
> Download from source, rebuild and install local version.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .travis.yml                  | 10 ++++++++++
>  tests/install-gost-engine.sh | 10 ++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100755 tests/install-gost-engine.sh
> 
> diff --git a/.travis.yml b/.travis.yml
> index 11a827c02f0a..887f6bbea9b9 100644
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
> @@ -30,6 +37,9 @@ install:
>  script:
>     - export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib;
>     - export PATH=$PATH:/usr/local/bin;
> +   - if [ "${SSL}" = "openssl" ]; then
> +        export OPENSSL_ENGINES="$OPENSSL_ENGINES:$PWD/engines/bin";

Should be `export OPENSSL_ENGINES=$PWD/engines/bin` since
OPENSSL_ENGINES is not PATH-like variable, but just a path to engines
dir.

Thanks,

> +     fi
>     - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check;
>  
>     - tail -3 tests/ima_hash.log;
> diff --git a/tests/install-gost-engine.sh b/tests/install-gost-engine.sh
> new file mode 100755
> index 000000000000..2563aa4953f7
> --- /dev/null
> +++ b/tests/install-gost-engine.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +
> +openssl version
> +
> +git clone --branch openssl_1_1_0 https://github.com/gost-engine/engine.git
> +cd engine
> +cmake .
> +cmake --build .
> +# note: install target is missing, later set the environment variable.
> +cd ..
> -- 
> 2.18.4
> 
