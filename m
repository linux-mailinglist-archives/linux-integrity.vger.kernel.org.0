Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366654CE32B
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Mar 2022 06:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiCEFvD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Mar 2022 00:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEFvC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Mar 2022 00:51:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FE583BE;
        Fri,  4 Mar 2022 21:50:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC2160A6F;
        Sat,  5 Mar 2022 05:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802A3C340EE;
        Sat,  5 Mar 2022 05:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646459411;
        bh=pTetQPmMHjZMD4gH82x0S4ogGPpBDH0vvOnmlnDkUE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+0DlIeC+5iVbOlpAykeA++LGsBuci+dJqSGkwAxMskwofmfFEGMOwOl4Ld/PmF0P
         XTlHw5RZYV8PRlmoCV/hK+vo40fAbCJ//82duZjHBuTM1dODSzG3izM2roPOL9/RpI
         W47D0WiMC9br+hEizCaYS+OSMAWgdERTd3vC5xmifv9RbmNpnzXbjj2jfa5MgEZME7
         O4ZzLFUBH93myoUrpbeQkT/MvSbRwHzndzd2m3M1u2c4A/BU3NNHN8blTVjtmiPPwp
         Efmi4AlonB9m1UcI5BdjtsdZ/9RNLdukUxii6TEYgoxPRPLp3Gc8WAKBCemLoMDH3m
         vKJMvvd0Zk0RA==
Date:   Sat, 5 Mar 2022 07:49:25 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com
Subject: Re: [PATCH v9 0/3] integrity: support including firmware ".platform"
 keys at build time
Message-ID: <YiL55eyeoyjbW6JH@iki.fi>
References: <20220304175403.20092-1-nayna@linux.ibm.com>
 <YiL3DvrlAHaMm+lk@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiL3DvrlAHaMm+lk@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Mar 05, 2022 at 07:37:18AM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 04, 2022 at 12:54:00PM -0500, Nayna Jain wrote:
> > Some firmware support secure boot by embedding static keys to verify the
> > Linux kernel during boot. However, these firmware do not expose an
> > interface for the kernel to load firmware keys onto the ".platform"
> > keyring, preventing the kernel from verifying the kexec kernel image
> > signature.
> > 
> > This patchset exports load_certificate_list() and defines a new function
> > load_builtin_platform_cert() to load compiled in certificates onto the
> > ".platform" keyring.
> > 
> > Changelog:
> > v9:
> > * Rebased on tpmdd master branch repo - 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > 
> > v8:
> > * Includes Jarkko's feedback on patch description and removed Reported-by
> > for Patch 1.
> > 
> > v7:
> > * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
> > 
> > v6:
> > * Includes Jarkko's feedback:
> >  * Split Patch 2 into two.
> >  * Update Patch description.
> > 
> > v5:
> > * Renamed load_builtin_platform_cert() to load_platform_certificate_list()
> > and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
> > suggested by Mimi Zohar.
> > 
> > v4:
> > * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
> > recommendation.
> > 
> > v3:
> > * Included Jarkko's feedback
> >  ** updated patch description to include approach.
> >  ** removed extern for function declaration in the .h file.
> > * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
> > 
> > v2:
> > * Fixed the error reported by kernel test robot
> > * Updated patch description based on Jarkko's feedback.
> > 
> > Nayna Jain (3):
> >   certs: export load_certificate_list() to be used outside certs/
> >   integrity: make integrity_keyring_from_id() non-static
> >   integrity: support including firmware ".platform" keys at build time
> > 
> >  certs/Makefile                                |  5 ++--
> >  certs/blacklist.c                             |  1 -
> >  certs/common.c                                |  2 +-
> >  certs/common.h                                |  9 -------
> >  certs/system_keyring.c                        |  1 -
> >  include/keys/system_keyring.h                 |  6 +++++
> >  security/integrity/Kconfig                    | 10 +++++++
> >  security/integrity/Makefile                   | 15 ++++++++++-
> >  security/integrity/digsig.c                   |  2 +-
> >  security/integrity/integrity.h                |  6 +++++
> >  .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
> >  .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
> >  12 files changed, 90 insertions(+), 16 deletions(-)
> >  delete mode 100644 certs/common.h
> >  create mode 100644 security/integrity/platform_certs/platform_cert.S
> > 
> > 
> > base-commit: c9e54f38976a1c0ec69c0a6208b3fd55fceb01d1
> > -- 
> > 2.27.0
> 
> Thank you, applied. 
> 
> BR, Jarkko

You need to fix this:

WARNING: externs should be avoided in .c files
#129: FILE: security/integrity/platform_certs/platform_keyring.c:19:
+extern __initconst const unsigned long platform_certificate_list_size;

I.e. remove extern's from font.

Please send one more version.

BR, Jarkko
