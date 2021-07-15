Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FA13C98DA
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jul 2021 08:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhGOGmM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jul 2021 02:42:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40624 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhGOGmL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jul 2021 02:42:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2CCF227C7;
        Thu, 15 Jul 2021 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626331157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y35NQy9G8kXAKirgXHE3LFGrxcq9ZB9H6hSQSdfDzSI=;
        b=Ia3Fe4oyu1VLCwfLkP3wynSNrQuU6bDdvFDcut2hP+jR7UwLJLXbXiqw37tJRRq25rxue2
        6c0ANF+3hvDKMHSvvdP6+zNsctgSfGScFCzkW1KTblGVtnfpRfqpEqtMZhrRUMB7VHyx/r
        3bS4qZF9KMFRyD/JbHcP46/ZEJs2P6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626331157;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y35NQy9G8kXAKirgXHE3LFGrxcq9ZB9H6hSQSdfDzSI=;
        b=AiDO2istQNRRAO3cs+O1ecpfAVjRE0xDI61UKBZWOQcI+pFKtOHp0B3ODulzSBl1ldQqOU
        4AiYLS5uxFQtmqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 514E013C29;
        Thu, 15 Jul 2021 06:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fkNyERXY72AzVwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 15 Jul 2021 06:39:17 +0000
Date:   Thu, 15 Jul 2021 08:39:16 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v4] ima-evm-utils: Support SM2 algorithm
 for sign and verify
Message-ID: <YO/YFAEWN5VzYIsQ@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
 <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Tianjia,

> Hi Tianjia,

> On Wed, 2021-07-14 at 21:01 +0800, Tianjia Zhang wrote:

> > index 5b07711..a0001b0 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -93,4 +93,4 @@ before_install:
> >  script:
> >      - INSTALL="${DISTRO%%:*}"
> >      - INSTALL="${INSTALL%%/*}"
> > -    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
> > [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
> > && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
> > \"$VARIANT\" ]; then which tpm_server || which swtpm ||
> > ./tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\"
> > ./build.sh"
> > +    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if
> > [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi
> > && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ !
> > \"$VARIANT\" ]; then which tpm_server || which swtpm ||
> > ./tests/install-swtpm.sh; fi && ./tests/install-openssl3.sh && 
> > CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"

> With "install-openssl3.sh", installing openssl 3.0 is being done for
> every distro matrix rule.  This needs to be limited to a specific
> instance.  Petr, please correct if I'm wrong, I assume a new variable
> needs to be defined, similar to "TSS".
+1

> A similar change would need to be made in ci.yml.
+1

> > new file mode 100755
> > index 0000000..21adb6f
> > --- /dev/null
> > +++ b/tests/install-openssl3.sh
> > @@ -0,0 +1,15 @@
> > +#!/bin/sh
> > +
> > +set -ex
> > +
> > +# The latest version in July 2021
> > +wget --no-check-certificate https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0-beta1.tar.gz
> > +tar --no-same-owner -xvzf openssl-3.0.0-beta1.tar.gz

> Petr said,  "Although it appears there is no distro which would have
> openssl 3.0 [1],
> Debian actually have 3.0.0~~beta1-1 in experimental [2]. openSUSE has slightly
> older version openssl-3.0.0-alpha16 [3]. I suppose we update soon to beta1 as
> well.
> Using distro packages would be probably faster to run in CI than install from git."
> I guess, whether the openssl 3.0 source code is from the distro or from
> openssl, it needs to be compiled from source.

> Perhaps limiting compiling openssl 3.0 to those distros with the source
> package is simpler than defining a new travis.yml variable, as
> suggested above.  Petr?
It'll be slower, but why not. It might be better not cover only Debian.
But IMHO there should be at least some distros tested with regular openssl 1.1.x
(or which particular version it have) which means some runs will be added to the
matrix. But there should be a balance between test coverity and time required
for tests to be run (we don't want to end up like u-boot [1] :)).

Kind regards,
Petr

[1] https://github.com/u-boot/u-boot/runs/3073277277

> thanks,

> Mimi
