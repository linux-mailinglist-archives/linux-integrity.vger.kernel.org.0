Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9283443995
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Nov 2021 00:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhKBX0c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Nov 2021 19:26:32 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58046 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhKBX0b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Nov 2021 19:26:31 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D54C172C8B8;
        Wed,  3 Nov 2021 02:23:54 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 914F14A46EC;
        Wed,  3 Nov 2021 02:23:54 +0300 (MSK)
Date:   Wed, 3 Nov 2021 02:23:54 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH ima-evm-utils] travis: use alt:sisyphus from docker.io
Message-ID: <20211102232354.a7y64ogsjs23beja@altlinux.org>
References: <20211102231742.191215-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211102231742.191215-1-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Nov 02, 2021 at 07:17:42PM -0400, Mimi Zohar wrote:
> Instead of returning an image, it prompts for a response.  Hardcode
> to use docker.io.
> 
>  Please select an image:
>   ▸ docker.io/library/alt:sisyphus
>     quay.io/alt:sisyphus
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .travis.yml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 42853e16bfee..3836befe0bae 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -68,7 +68,7 @@ matrix:
>            compiler: gcc
>  
>          - os: linux
> -          env: DISTRO=alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
> +          env: REPO="docker.io/library" DISTRO=${REPO}/alt:sisyphus TSS=libtpm2-tss-devel CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"

I wonder why podman is used in this case.

Thanks,

>            compiler: gcc
>  
>  before_install:
> @@ -92,6 +92,7 @@ before_install:
>      - $CONTAINER build $CONTAINER_ARGS -t ima-evm-utils .
>  
>  script:
> -    - INSTALL="${DISTRO%%:*}"
> +    - INSTALL="${DISTRO#${REPO}/}"
> +    - INSTALL="${INSTALL%%:*}"
>      - INSTALL="${INSTALL%%/*}"
>      - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ "$COMPILE_SSL" ]; then COMPILE_SSL="$COMPILE_SSL" ./tests/install-openssl3.sh; fi && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
> -- 
> 2.27.0
