Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609022FE305
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 07:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbhAUGiv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 01:38:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbhATXpp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 18:45:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FF75221FE;
        Wed, 20 Jan 2021 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611186302;
        bh=DtYGGvkksfs7vXommXeJwl91lOsFd1rEuyBTgJv2+l0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E70AnGgrCqxaoh1vWdlhGmZ2hd7h/FB84wv2240pZVLQUYmrHgMKATyaqSOkK85F/
         efCn9nc8j0I9yyif6cEaIBQ+Y8LWSf+T/dqeBGKToiPaLLnNeBV1+7hwW5AxIM/qIi
         msPEsJTYyd/Wx5bu8Da6KODI7Zbxlq/djYsCS3CT/WKtcjJxGMw81TsvZN0B0zv+fH
         yq1FOKDdleusG2CT5IJQua2USHSh1tGzSkT6kTlaaNQQJ6+uyly9wZta2XxuOIhExl
         bu2B36wdUYjoVyWPzvMvz8AUR+XPQHfHGGqkXP6OrYIbAY4z8Hgjlm7KTVPVLiVjYh
         Vr6VDSf5UWiWw==
Date:   Thu, 21 Jan 2021 01:44:56 +0200
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
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH v3 02/10] certs: Fix blacklisted hexadecimal hash string
 check
Message-ID: <YAjAePytNXMC6HqX@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-3-mic@digikod.net>
 <YAem+DjBR92WG+bK@kernel.org>
 <05e3ce56-c27c-877d-8ebe-d088ba95f248@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05e3ce56-c27c-877d-8ebe-d088ba95f248@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 20, 2021 at 12:12:50PM +0100, Mickaël Salaün wrote:
> 
> On 20/01/2021 04:43, Jarkko Sakkinen wrote:
> > On Thu, Jan 14, 2021 at 04:19:01PM +0100, Mickaël Salaün wrote:
> >> From: Mickaël Salaün <mic@linux.microsoft.com>
> >>
> >> When looking for a blacklisted hash, bin2hex() is used to transform a
> >> binary hash to an ascii (lowercase) hexadecimal string.  This string is
> >> then search for in the description of the keys from the blacklist
> >> keyring.  When adding a key to the blacklist keyring,
> >> blacklist_vet_description() checks the hash prefix and the hexadecimal
> >> string, but not that this string is lowercase.  It is then valid to set
> >> hashes with uppercase hexadecimal, which will be silently ignored by the
> >> kernel.
> >>
> >> Add an additional check to blacklist_vet_description() to check that
> >> hexadecimal strings are in lowercase.
> >>
> >> Cc: David Woodhouse <dwmw2@infradead.org>
> >> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> >> Signed-off-by: David Howells <dhowells@redhat.com>
> >> Reviewed-by: Ben Boeckel <mathstuf@gmail.com>
> >> ---
> >>
> >> Changes since v2:
> >> * Cherry-pick v1 patch from
> >>   https://lore.kernel.org/lkml/2659836.1607940186@warthog.procyon.org.uk/
> >>   to rebase on v5.11-rc3.
> >> * Rearrange Cc order.
> >> ---
> >>  certs/blacklist.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/certs/blacklist.c b/certs/blacklist.c
> >> index 2719fb2fbc1c..a888b934a1cd 100644
> >> --- a/certs/blacklist.c
> >> +++ b/certs/blacklist.c
> >> @@ -37,7 +37,7 @@ static int blacklist_vet_description(const char *desc)
> >>  found_colon:
> >>  	desc++;
> >>  	for (; *desc; desc++) {
> >> -		if (!isxdigit(*desc))
> >> +		if (!isxdigit(*desc) || isupper(*desc))
> >>  			return -EINVAL;
> >>  		n++;
> >>  	}
> >> -- 
> >> 2.30.0
> >>
> > 
> > Shouldn't this rather convert the upper case to lower case? I don't like
> > the ABI break that this causes.
> 
> It doesn't break the ABI because keys loaded in the blacklist keyring
> can only happen with builtin hashes.  Moreover these builtin hashes will
> be checked by patch 10/10 at build time.

Right the patches are just out of order then.

/Jarkko

> 
> This patch is also important to remove a false sense of security and
> warns about mis-blacklisted certificates or binaries:
> https://lore.kernel.org/lkml/c9664a67-61b7-6b4a-86d7-5aca9ff06fa5@digikod.net/
> 
> Hot-patching keys doesn't seem a good idea, especially when these keys
> are signed. Moreover, it would bring additional complexity and will
> require to change the core of the key management.
> 
> > 
> > /Jarkko
> > 
> 
