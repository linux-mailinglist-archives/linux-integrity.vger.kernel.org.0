Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8741D2FE038
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 04:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbhAUDx1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 22:53:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404283AbhATXyC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 18:54:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D032224D1;
        Wed, 20 Jan 2021 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611186801;
        bh=KaAIzngTFdJOggqeK7loFLhsbvngspe0/HlURAXHAgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHaQCXddx55iPn4zzRZ4h369HDxx+f10wwgXlwvnOYnceCMv/Tgt7UkQTt7vPpHk7
         9CkGiWZx82+8Ue2VivIz/zDsRM1gPo/2HhcS3pGRiQXyOqSLeiqI9Ts6LiBwaOLTrQ
         3Xa7oxqO6LpkXGVzVDW+mpRMD8BxILd9xkCAEoT6Rw8sYFkCSiWrMZvHlK5G+urMGs
         FTZbWHiobojD4DtlCkJ6qO/JQmwjGQufBxqTNqrDSUt6sQ9QJbaBDeFUJ/I+zhepfk
         ob0gCIqOmAffaeGFmUtLSFMuQHhyPWzrA567O6CJGCrFI8Mzty5QfSqaYbOG3FPrsF
         XkJXSzsRDlatg==
Date:   Thu, 21 Jan 2021 01:53:16 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 08/10] certs: Check that builtin blacklist hashes are
 valid
Message-ID: <YAjCbKwQf8nS+Nuu@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-9-mic@digikod.net>
 <YAe9egzT5D7B0swR@kernel.org>
 <11ce77c9-7b43-e2a0-55bc-c0035bf3d681@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11ce77c9-7b43-e2a0-55bc-c0035bf3d681@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 20, 2021 at 12:57:55PM +0100, Mickaël Salaün wrote:
> 
> On 20/01/2021 06:19, Jarkko Sakkinen wrote:
> > On Thu, Jan 14, 2021 at 04:19:07PM +0100, Mickaël Salaün wrote:
> >> From: Mickaël Salaün <mic@linux.microsoft.com>
> >>
> >> Add and use a check-blacklist-hashes.awk script to make sure that the
> >> builtin blacklist hashes will be approved by the run time blacklist
> >> description checks.  This is useful to debug invalid hash formats, and
> >> it make sure that previous hashes which could have been loaded in the
> >> kernel (but ignored) are now noticed and deal with by the user.
> >>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Cc: David Woodhouse <dwmw2@infradead.org>
> >> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> >> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > I get this with a self-signed cert:
> > 
> > certs/Makefile:18: *** target pattern contains no '%'.  Stop.
> > 
> > CONFIG_SYSTEM_BLACKLIST_HASH_LIST="tbs:8eed1340eef37c1dc84d996406ad05c7dbb3eade19132d688408ca2f63904869"
> 
> As said in the Kconfig documentation for
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST, you need to provide a file with the
> list, not to set the string directly in the configuration variable. This
> patch series didn't change this behavior. The same kind of macros are
> used for CONFIG_MODULE_SIG_KEY.

OK, the documentation just states that:

"Hashes to be preloaded into the system blacklist keyring"

No mention about a file. I'd add a patch to update this documentation.

> 
> > 
> > I used the script in 10/10 to test this, which is another
> > reamark: the patches are in invalid order, as you need to
> > apply 10/10 before you can test  8/10.
> 
> I'll move patch 10/10 earlier but this kind of formatting was already
> required (but silently ignored) for this option to be really taken into
> account. Only the kernel code was available to understand how to
> effectively create such hash.

Great, thanks.


> > 
> > /Jarkko
> > 


/Jarkko

