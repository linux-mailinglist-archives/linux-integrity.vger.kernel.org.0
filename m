Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2EA2FEE71
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Jan 2021 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbhAUPWv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Jan 2021 10:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbhAUPWm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jan 2021 10:22:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1976238E3;
        Thu, 21 Jan 2021 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611242521;
        bh=e1ilRiA5h3unhmKhvZR7+3hv6JFsOS3SCqU2d1CFl+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1dYt9RSwiBIFlzecPP0bgBiCCg8/4rSint8Wob/6NthzWFOUvUY0ta36Qgtr4UK7
         pzSokf/QnuZZHOLadJ3Vp7Zmlw768vHRL9P7trP1LwiMyjv0k5tMnasZAOwDVRDt+z
         9I4188bALSILhVy5tAuQ7MS7q/rrKF6PAWJlc2pry2A/5AkJTalz9vkqUOoUozMvN5
         k8i0TIrTrwXZtBRrYBktTqAw590mnAaI+vOAjduF5cXEPYrnXmOMUMxMtP2FykATQV
         2jEQblWME+jW2vROJagChuyqrh5CF/esuwheeHlp6k9MfWBCnlsv/MvJMMpOiQe1BI
         ovSu0aL1HrGFQ==
Date:   Thu, 21 Jan 2021 17:21:58 +0200
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
Message-ID: <YAmcFk9r8sUvT7U4@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-9-mic@digikod.net>
 <YAe9egzT5D7B0swR@kernel.org>
 <11ce77c9-7b43-e2a0-55bc-c0035bf3d681@digikod.net>
 <YAjCbKwQf8nS+Nuu@kernel.org>
 <c644f660-8b65-586d-42d8-45601ca58ca3@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c644f660-8b65-586d-42d8-45601ca58ca3@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 21, 2021 at 10:18:20AM +0100, Mickaël Salaün wrote:
> 
> On 21/01/2021 00:53, Jarkko Sakkinen wrote:
> > On Wed, Jan 20, 2021 at 12:57:55PM +0100, Mickaël Salaün wrote:
> >>
> >> On 20/01/2021 06:19, Jarkko Sakkinen wrote:
> >>> On Thu, Jan 14, 2021 at 04:19:07PM +0100, Mickaël Salaün wrote:
> >>>> From: Mickaël Salaün <mic@linux.microsoft.com>
> >>>>
> >>>> Add and use a check-blacklist-hashes.awk script to make sure that the
> >>>> builtin blacklist hashes will be approved by the run time blacklist
> >>>> description checks.  This is useful to debug invalid hash formats, and
> >>>> it make sure that previous hashes which could have been loaded in the
> >>>> kernel (but ignored) are now noticed and deal with by the user.
> >>>>
> >>>> Cc: David Howells <dhowells@redhat.com>
> >>>> Cc: David Woodhouse <dwmw2@infradead.org>
> >>>> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> >>>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>>
> >>> I get this with a self-signed cert:
> >>>
> >>> certs/Makefile:18: *** target pattern contains no '%'.  Stop.
> >>>
> >>> CONFIG_SYSTEM_BLACKLIST_HASH_LIST="tbs:8eed1340eef37c1dc84d996406ad05c7dbb3eade19132d688408ca2f63904869"
> >>
> >> As said in the Kconfig documentation for
> >> CONFIG_SYSTEM_BLACKLIST_HASH_LIST, you need to provide a file with the
> >> list, not to set the string directly in the configuration variable. This
> >> patch series didn't change this behavior. The same kind of macros are
> >> used for CONFIG_MODULE_SIG_KEY.
> > 
> > OK, the documentation just states that:
> > 
> > "Hashes to be preloaded into the system blacklist keyring"
> > 
> > No mention about a file. I'd add a patch to update this documentation.
> 
> I was referring to the full description:
> 
> config SYSTEM_BLACKLIST_HASH_LIST
> 	string "Hashes to be preloaded into the system blacklist keyring"
> 	depends on SYSTEM_BLACKLIST_KEYRING
> 	help
> 	  If set, this option should be the filename of a list of hashes in the
> 	  form "<hash>", "<hash>", ... .  This will be included into a C
> 	  wrapper to incorporate the list into the kernel.  Each <hash> should
> 	  be a string of hex digits.
> 
> …but the short description doesn't mention filename.

Aah.

Anyway, I'll test the next version. Now all should be clear how
to approach that. Thanks.

/Jarkko
