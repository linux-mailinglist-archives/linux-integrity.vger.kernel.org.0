Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0326B2F756C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 10:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbhAOJ3Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 04:29:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbhAOJ3X (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 04:29:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 685E923436;
        Fri, 15 Jan 2021 09:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610702922;
        bh=apGADtKlrfa4YYghHsGMEpjHQn9bjjZ8mMzl0uMAbUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jr3i3MiraGrjKs3dkoOrrhe26xY9WZ3gv63Y830+mFmZ9n0uMvXfHG5CfK0CSGga8
         zL01ymSiNWnvu6IzJFAvpoE2annb2KlC3299fymNakZtiTOLxPTALNu35jM0mY3i8n
         qX3R7NGB93+EHg7HbgW/NLExg7g6WT3KIj/RkUxthccdljsyQnz+PBYBHRH3TjgRL/
         SS/TcvR+RqeWK0R8RasrsAY6JlMl7dLojuPzmSSzhZFMN8fe0yWSCODXxhzHcD6Na6
         6vWWIm+8FEoeDL0D4swTkpWSqkBXBBgNfQH1/j8FyojawxRoGbSKfAUjS+qCP5o6it
         uAjUDiy5Mklpg==
Date:   Fri, 15 Jan 2021 11:28:35 +0200
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
Subject: Re: [PATCH v3 00/10] Enable root to update the blacklist keyring
Message-ID: <YAFgQ1SN24iFujjx@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-1-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:18:59PM +0100, Mickaël Salaün wrote:
> This third patch series includes back three fix patches taken from the first
> series (and cherry-picked from David Howells's tree [1]), and one cosmetic fix
> from Alex Shi which helps avoid future conflicts.  I also added some Acked-by
> and improved comments.  As requested, this series is based on v5.11-rc3.
> 
> The goal of these patches is to add a new configuration option to enable the
> root user to load signed keys in the blacklist keyring.  This keyring is useful
> to "untrust" certificates or files.  Enabling to safely update this keyring
> without recompiling the kernel makes it more usable.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-fixes
> 
> Previous patch series:
> https://lore.kernel.org/lkml/20201211190330.2586116-1-mic@digikod.net/
> 
> Regards,
> 
> Alex Shi (1):
>   certs/blacklist: fix kernel doc interface issue
> 
> David Howells (1):
>   certs: Fix blacklist flag type confusion
> 
> Mickaël Salaün (8):
>   certs: Fix blacklisted hexadecimal hash string check
>   PKCS#7: Fix missing include
>   certs: Replace K{U,G}IDT_INIT() with GLOBAL_ROOT_{U,G}ID
>   certs: Make blacklist_vet_description() more strict
>   certs: Factor out the blacklist hash creation
>   certs: Check that builtin blacklist hashes are valid
>   certs: Allow root user to append signed hashes to the blacklist
>     keyring
>   tools/certs: Add print-cert-tbs-hash.sh
> 
>  MAINTAINERS                                   |   2 +
>  certs/.gitignore                              |   1 +
>  certs/Kconfig                                 |  10 +
>  certs/Makefile                                |  15 +-
>  certs/blacklist.c                             | 217 ++++++++++++++----
>  certs/system_keyring.c                        |   5 +-
>  crypto/asymmetric_keys/x509_public_key.c      |   3 +-
>  include/keys/system_keyring.h                 |  14 +-
>  include/linux/key.h                           |   1 +
>  include/linux/verification.h                  |   2 +
>  scripts/check-blacklist-hashes.awk            |  37 +++
>  security/integrity/ima/ima_mok.c              |   4 +-
>  .../platform_certs/keyring_handler.c          |  26 +--
>  security/keys/key.c                           |   2 +
>  tools/certs/print-cert-tbs-hash.sh            |  91 ++++++++
>  15 files changed, 345 insertions(+), 85 deletions(-)
>  create mode 100755 scripts/check-blacklist-hashes.awk
>  create mode 100755 tools/certs/print-cert-tbs-hash.sh
> 
> 
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> -- 
> 2.30.0
> 
> 

Thank you. Unfortunately no time to review this anymore this week but I
sanity checked that this applies cleanly now, so should be easy to get on
testing this series next week:

$ git-pw series apply 414691
Applying: certs/blacklist: fix kernel doc interface issue
Applying: certs: Fix blacklisted hexadecimal hash string check
Applying: PKCS#7: Fix missing include
Applying: certs: Fix blacklist flag type confusion
Applying: certs: Replace K{U,G}IDT_INIT() with GLOBAL_ROOT_{U,G}ID
Applying: certs: Make blacklist_vet_description() more strict
Applying: certs: Factor out the blacklist hash creation
Applying: certs: Check that builtin blacklist hashes are valid
Applying: certs: Allow root user to append signed hashes to the blacklist keyring
Applying: tools/certs: Add print-cert-tbs-hash.sh

/Jarkko
