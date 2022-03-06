Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD64CE838
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Mar 2022 03:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiCFCMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Mar 2022 21:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFCMG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Mar 2022 21:12:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B0033A1C;
        Sat,  5 Mar 2022 18:11:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FBD7B80CA9;
        Sun,  6 Mar 2022 02:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AE0C004E1;
        Sun,  6 Mar 2022 02:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646532672;
        bh=RIr7fFxWI3FpbIOB6aX3qDH5fiOuOsqD69tSVCBjZ9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qqRymxnCBeVBEJwFO1pLqku+gNXcOjtZNKYovOg9pmz1EM4PCBXWSBapA01Fv4jVu
         Id9Rl2sor5n72v0P9IRMNw2NO19ZXCYJv2ImpGecsrLyl02X52THJrfe67leLwMZWJ
         6juDUcN6xl1v1ldUgik5zLiRWFt5e3IqU9S4xIqt3LnTrT8dQwcozHwMTEYs1nK7Ea
         9xQwcud6iUZNSOipqd66eDLLDFg0yheP41mdd9gan2S8KH4HbaB3zQtWfTmVSwdAUg
         KNFgM8p/w5H7u3PwcD78wwSDMImL9Gi5a4DmcIaDN6iKP2b1lYJyT+qF7kejPJ2ltf
         CWuIxFQBrSSGw==
Date:   Sun, 6 Mar 2022 04:10:30 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com
Subject: Re: [PATCH v9 0/3] integrity: support including firmware ".platform"
 keys at build time
Message-ID: <YiQYFvrKCr4fPpY4@iki.fi>
References: <20220304175403.20092-1-nayna@linux.ibm.com>
 <YiL3DvrlAHaMm+lk@iki.fi>
 <YiL55eyeoyjbW6JH@iki.fi>
 <0902b082-d0c8-cbcd-f8fa-68696527144d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0902b082-d0c8-cbcd-f8fa-68696527144d@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Mar 05, 2022 at 08:32:43PM -0500, Nayna wrote:
> 
> On 3/5/22 00:49, Jarkko Sakkinen wrote:
> > On Sat, Mar 05, 2022 at 07:37:18AM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Mar 04, 2022 at 12:54:00PM -0500, Nayna Jain wrote:
> > > > Some firmware support secure boot by embedding static keys to verify the
> > > > Linux kernel during boot. However, these firmware do not expose an
> > > > interface for the kernel to load firmware keys onto the ".platform"
> > > > keyring, preventing the kernel from verifying the kexec kernel image
> > > > signature.
> > > > 
> > > > This patchset exports load_certificate_list() and defines a new function
> > > > load_builtin_platform_cert() to load compiled in certificates onto the
> > > > ".platform" keyring.
> > > > 
> > > > Changelog:
> > > > v9:
> > > > * Rebased on tpmdd master branch repo -
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > > > 
> > > > v8:
> > > > * Includes Jarkko's feedback on patch description and removed Reported-by
> > > > for Patch 1.
> > > > 
> > > > v7:
> > > > * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
> > > > 
> > > > v6:
> > > > * Includes Jarkko's feedback:
> > > >   * Split Patch 2 into two.
> > > >   * Update Patch description.
> > > > 
> > > > v5:
> > > > * Renamed load_builtin_platform_cert() to load_platform_certificate_list()
> > > > and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
> > > > suggested by Mimi Zohar.
> > > > 
> > > > v4:
> > > > * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
> > > > recommendation.
> > > > 
> > > > v3:
> > > > * Included Jarkko's feedback
> > > >   ** updated patch description to include approach.
> > > >   ** removed extern for function declaration in the .h file.
> > > > * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
> > > > 
> > > > v2:
> > > > * Fixed the error reported by kernel test robot
> > > > * Updated patch description based on Jarkko's feedback.
> > > > 
> > > > Nayna Jain (3):
> > > >    certs: export load_certificate_list() to be used outside certs/
> > > >    integrity: make integrity_keyring_from_id() non-static
> > > >    integrity: support including firmware ".platform" keys at build time
> > > > 
> > > >   certs/Makefile                                |  5 ++--
> > > >   certs/blacklist.c                             |  1 -
> > > >   certs/common.c                                |  2 +-
> > > >   certs/common.h                                |  9 -------
> > > >   certs/system_keyring.c                        |  1 -
> > > >   include/keys/system_keyring.h                 |  6 +++++
> > > >   security/integrity/Kconfig                    | 10 +++++++
> > > >   security/integrity/Makefile                   | 15 ++++++++++-
> > > >   security/integrity/digsig.c                   |  2 +-
> > > >   security/integrity/integrity.h                |  6 +++++
> > > >   .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
> > > >   .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
> > > >   12 files changed, 90 insertions(+), 16 deletions(-)
> > > >   delete mode 100644 certs/common.h
> > > >   create mode 100644 security/integrity/platform_certs/platform_cert.S
> > > > 
> > > > 
> > > > base-commit: c9e54f38976a1c0ec69c0a6208b3fd55fceb01d1
> > > > -- 
> > > > 2.27.0
> > > Thank you, applied.
> > > 
> > > BR, Jarkko
> > You need to fix this:
> > 
> > WARNING: externs should be avoided in .c files
> > #129: FILE: security/integrity/platform_certs/platform_keyring.c:19:
> > +extern __initconst const unsigned long platform_certificate_list_size;
> 
> Yes, because I followed the same convention as used for system keyring
> certs. Following externs are defined in system_keyring.c for referencing
> variables defined in .S file.
> 
> extern __initconst const u8 system_certificate_list[];
> extern __initconst const unsigned long system_certificate_list_size;
> extern __initconst const unsigned long module_cert_size;

So why don't you do as the warning says and place them to integrity.h
for instance?

BR, Jarkko
