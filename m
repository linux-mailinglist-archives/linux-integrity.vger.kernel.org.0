Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF807493584
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 08:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351987AbiASHfl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 02:35:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48938 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiASHfl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 02:35:41 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05C3F212C2;
        Wed, 19 Jan 2022 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642577740;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kvNlvotchAojyaqcvheuTbmeBm2W6O7JOFg3pffJ010=;
        b=rd1F9fh10m42BwaYZ2MNhPPs4r7XCleSIOVX5Eq2oM9Zl2uAdy4YJo93BFkFSWYY4e2ZPa
        EsognuVR28dCMP2o8Az5xkm4L9WjALgYXy+5lTVoJreVFzaBsy3MJSW0DRdgfeJYe8MaOQ
        mD1H/iyQcSKWlPUGdAZNFMVmnzN2y2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642577740;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kvNlvotchAojyaqcvheuTbmeBm2W6O7JOFg3pffJ010=;
        b=g6Aal9QmMPtferVi7IMIfjt0j91zQNFk1kn7zXGKU/BCZzCv7Y4RHInEIRLR7zHIUtrwVQ
        EJRyjcqu7B/9WiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6E0513B2A;
        Wed, 19 Jan 2022 07:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HTC5Kku/52EsaAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 19 Jan 2022 07:35:39 +0000
Date:   Wed, 19 Jan 2022 08:35:37 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add missing "security/integrity" directory
Message-ID: <Yee/SaBeQMQBuIge@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220117230229.16475-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117230229.16475-1-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Few comments below.

> Update the IMA and EVM records to include the "security/integrity"
> directory.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5250298d2817..a9973d0991e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7181,6 +7181,7 @@ M:	Mimi Zohar <zohar@linux.ibm.com>
>  L:	linux-integrity@vger.kernel.org
>  S:	Supported
Aren't you a maintainer? How about
S:  Maintained

>  F:	security/integrity/evm/
> +F:	security/integrity
I'd add trailing slash (i.e. security/integrity/)

How about adding git tree to EVM?

>  EXTENSIBLE FIRMWARE INTERFACE (EFI)
>  M:	Ard Biesheuvel <ardb@kernel.org>
> @@ -9419,6 +9420,7 @@ L:	linux-integrity@vger.kernel.org
>  S:	Supported
and here

>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>  F:	security/integrity/ima/
> +F:	security/integrity
and here

>  INTEL 810/815 FRAMEBUFFER DRIVER
>  M:	Antonino Daplas <adaplas@gmail.com>

Kind regards,
Petr
