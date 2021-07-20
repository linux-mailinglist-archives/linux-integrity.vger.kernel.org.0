Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CB23CFB1F
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbhGTNHc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 09:07:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36472 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbhGTNGB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 09:06:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 782B82247C;
        Tue, 20 Jul 2021 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626788776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMlrdA+/UMzkPJcXUWkwFUo9AMLnvZgUzGLvDhUlDfY=;
        b=HosdR5jIU3MjRpOJlGOLT4jg2q3PuJISXAts3JkjIVGkT3g+yc7iRiRoSp5MYkW44i5IVM
        cT+DdM1PvSExkBRLeS6JdR2xhXl98dNStlwrz6T/lP/5797Ml8BExTumeF/DLk2s4wg+jc
        awj2di14prwbYkdFp6/F3avoaijobRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626788776;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uMlrdA+/UMzkPJcXUWkwFUo9AMLnvZgUzGLvDhUlDfY=;
        b=Zz+M550mtZjTHVh14OESAgzpkMvMvueKjJjc8jtPgkGNBeOfyVkG2BN7SFHoIxdtvxiVGT
        1sFHUCd2/C1kYWAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D73C313B87;
        Tue, 20 Jul 2021 13:46:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Z/XNMqfT9mBReQAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Tue, 20 Jul 2021 13:46:15 +0000
Date:   Tue, 20 Jul 2021 15:46:13 +0200
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
Message-ID: <YPbTpU2IvPYzE+Le@pevik>
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

> --- /dev/null
> +++ b/tests/install-openssl3.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
Tests heavily use bashisms like [[ ]], which is not a problem when shebang is
/bin/bash. There is no bashism in this script, but be careful to use /bin/sh in
project which contains lots of bashisms.

Kind regards,
Petr

> +
> +set -ex
> +
> +# 3.0.0-beta1 is the latest version in July 2021
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
