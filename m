Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C426B3CFAE7
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhGTNBS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 09:01:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35464 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbhGTNBN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 09:01:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 642A92245E;
        Tue, 20 Jul 2021 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626788510;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dJzpmvMbuQtybWGdEcNXhkIiL9wrfhQ4wBofwDOAqcI=;
        b=HAPDqAqFCVXnttKdTGrfqkwRrPDjCSASHkZWiBWl7MMQpqJArhc+c9ZllPaGORFvthWOdW
        TIOZs939F3aBAYYIsbN7C1HqafCSDoL/lZZXQDMAHAwxRjqxg3SXSyqRxjrNlZvL36qTfe
        C+JhGfC7InKpl0IgeDvd9FiIdxVp+v0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626788510;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dJzpmvMbuQtybWGdEcNXhkIiL9wrfhQ4wBofwDOAqcI=;
        b=i4fGg0y8TX/66DF/Q9LQ1a3B3TvxxBxlBXHGYigMwOptJMMrqBN7cPkpXzwRuaBjcCsLrt
        CW7gkDfBKpCy8WAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 20E8713B87;
        Tue, 20 Jul 2021 13:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ogosBp7S9mC9dwAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Tue, 20 Jul 2021 13:41:50 +0000
Date:   Tue, 20 Jul 2021 15:41:48 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v6] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
Message-ID: <YPbSnDejnYcqY2Ib@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210720075153.17158-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720075153.17158-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

few notes below, feel free to completely ignore it.

...
> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> index 088c041..b890481 100644
> --- a/.github/workflows/ci.yml
> +++ b/.github/workflows/ci.yml
> @@ -17,6 +17,7 @@ jobs:
>                ARCH: i386
>                TSS: tpm2-tss
>                VARIANT: i386
> +              COMPILE_SSL: openssl-3
I'd either put here value openssl-3.0.0-beta1 and pass it to
./tests/install-openssl3.sh or put value as true. Because why define version in
yaml and also in the script? (sooner or later these two will not match).

>            # cross compilation builds
>            - container: "debian:stable"
> @@ -51,6 +52,7 @@ jobs:
>              env:
>                CC: clang
>                TSS: ibmtss
> +              COMPILE_SSL: openssl-3

>            - container: "opensuse/leap"
>              env:
> @@ -61,6 +63,7 @@ jobs:
>              env:
>                CC: gcc
>                TSS: ibmtss
> +              COMPILE_SSL: openssl-3

>            - container: "ubuntu:xenial"
>              env:
> @@ -115,6 +118,7 @@ jobs:
>          INSTALL="${INSTALL%%/*}"
>          if [ "$VARIANT" ]; then ARCH="$ARCH" ./ci/$INSTALL.$VARIANT.sh; fi
>          ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
> +        if [ "$COMPILE_SSL" ]; then ./tests/install-openssl3.sh; fi

>      - name: Build swtpm
>        run: |
> @@ -128,5 +132,8 @@ jobs:
>      - name: Compiler version
>        run: $CC --version

> +    - name: Default OpenSSL version
> +      run: openssl version
you should run this only on native build:

         run: [ "$VARIANT" != "cross-compile" ] && openssl version

Also aren't ve interested at the version which is actually being used for
compilation?

Also we don't print this info for Travis CI.

> +
>      - name: Compile
>        run: CC="$CC" VARIANT="$VARIANT" ./build.sh
> diff --git a/.travis.yml b/.travis.yml
> index 7a76273..a73f20e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -9,7 +9,7 @@ matrix:
>      include:
>          # 32 bit build
>          - os: linux
> -          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss
> +          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL: openssl-3
>            compiler: gcc

>          # cross compilation builds
> @@ -32,7 +32,7 @@ matrix:

>          # glibc (gcc/clang)
>          - os: linux
> -          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host"
> +          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host" COMPILE_SSL: openssl-3
>            compiler: clang

>          - os: linux
> @@ -40,7 +40,7 @@ matrix:
>            compiler: gcc

>          - os: linux
> -          env: DISTRO=ubuntu:groovy TSS=ibmtss
> +          env: DISTRO=ubuntu:groovy TSS=ibmtss COMPILE_SSL: openssl-3
>            compiler: gcc

>          - os: linux
> @@ -97,4 +97,4 @@ before_install:
>  script:
>      - INSTALL="${DISTRO%%:*}"
>      - INSTALL="${INSTALL%%/*}"
> -    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
> +    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ "$COMPILE_SSL" ]; then ./tests/install-openssl3.sh; fi && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 19f1041..8e96157 100644
...
> --- a/tests/gen-keys.sh
> +++ b/tests/gen-keys.sh
> @@ -131,6 +131,31 @@ for m in \
>      fi
>  done

> +# SM2, If openssl 3.0 is installed, gen SM2 keys using
> +if [ -x /opt/openssl3/bin/openssl ]; then
> +  (PATH=/opt/openssl3/bin:$PATH LD_LIBRARY_PATH=/opt/openssl3/lib
> +  for curve in sm2; do
I'd just export PATH and LD_LIBRARY_PATH than wrap them in ().
> +    if [ "$1" = clean ] || [ "$1" = force ]; then
> +      rm -f test-$curve.cer test-$curve.key test-$curve.pub
> +    fi
> +    if [ "$1" = clean ]; then
> +      continue
> +    fi
> +    if [ ! -e test-$curve.key ]; then
> +      log openssl req -verbose -new -nodes -utf8 -days 10000 -batch -x509 \
> +        -sm3 -sigopt "distid:1234567812345678" \
> +        -config test-ca.conf \
> +        -copy_extensions copyall \
> +        -newkey $curve \
> +        -out test-$curve.cer -outform DER \
> +        -keyout test-$curve.key
> +      if [ -s test-$curve.key ]; then
> +        log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
> +      fi
> +    fi
> +  done)
> +fi
...

> --- /dev/null
> +++ b/tests/install-openssl3.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +
> +set -ex
> +
> +# 3.0.0-beta1 is the latest version in July 2021
I'd define a variable and use it.
version="openssl-3.0.0-beta1"


Kind regards,
Petr

> +wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0-beta1.tar.gz
> +tar --no-same-owner -xzf openssl-3.0.0-beta1.tar.gz
> +cd openssl-openssl-3.0.0-beta1
> +
> +./Configure --prefix=/opt/openssl3 --openssldir=/opt/openssl3/ssl
> +make -j$(nproc)
> +# only install apps and library
> +sudo make install_sw
> +
> +cd ..
> +rm -rf openssl-3.0.0-beta1.tar.gz
> +rm -rf openssl-openssl-3.0.0-beta1
...
