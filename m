Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1F4C9C64
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 05:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiCBEVG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Mar 2022 23:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCBEVF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Mar 2022 23:21:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3E21C920;
        Tue,  1 Mar 2022 20:20:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6264617A5;
        Wed,  2 Mar 2022 04:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B58C004E1;
        Wed,  2 Mar 2022 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646194822;
        bh=GI/ZKKrRYWBhNT3gVPHoQ7zlrKpoYFQqagorYrklqDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R0/qPcJr1GiFQ2mLQN0GK16GP9tJv8biYfGAeDODvy8Dotnb1GKV8qpsUKexUoeoS
         m8yPthsXvmxwE/sHlO3s/N7DU8s40gFSk21SubDkxsRvFZbU5dTDBctPSopAMKN5zF
         os6NCH2GiRsvcCfUwFk97vjhkZmK0+vaLja5/uyIZ0b6r/O5PTX862X4qMDyNTqyja
         N8zHo+Gal/HuhmxJwyliKYUWwyZ6CySlgS/xkuff1jycOyUdv2ZoR1yK5QypUNeemX
         pcjtmSXKKA4wF9f6x8ZEzm7El1DqfuPtSQBjbn/5/3ggNlVvmWSEpHxZ7RZHxJ43T3
         nuWXGt54/1Vxw==
Date:   Wed, 2 Mar 2022 05:21:06 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v8 0/3] integrity: support including firmware ".platform"
 keys at build time
Message-ID: <Yh7wst/WbOzI82s/@iki.fi>
References: <20220111183647.977037-1-nayna@linux.ibm.com>
 <YhLIhJF0aWZt+8op@iki.fi>
 <0a87bb3b-574c-6e8e-2f8f-49e42d71ab8c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a87bb3b-574c-6e8e-2f8f-49e42d71ab8c@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 21, 2022 at 08:33:55AM -0500, Nayna wrote:
> 
> On 2/20/22 18:02, Jarkko Sakkinen wrote:
> > On Tue, Jan 11, 2022 at 01:36:44PM -0500, Nayna Jain wrote:
> > > Some firmware support secure boot by embedding static keys to verify the
> > > Linux kernel during boot. However, these firmware do not expose an
> > > interface for the kernel to load firmware keys onto the ".platform"
> > > keyring, preventing the kernel from verifying the kexec kernel image
> > > signature.
> > > 
> > > This patchset exports load_certificate_list() and defines a new function
> > > load_builtin_platform_cert() to load compiled in certificates onto the
> > > ".platform" keyring.
> > > 
> > > Changelog:
> > > 
> > > v8:
> > > * Includes Jarkko's feedback on patch description and removed Reported-by
> > > for Patch 1.
> > > 
> > > v7:
> > > * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
> > > 
> > > v6:
> > > * Includes Jarkko's feedback:
> > >   * Split Patch 2 into two.
> > >   * Update Patch description.
> > > 
> > > v5:
> > > * Renamed load_builtin_platform_cert() to load_platform_certificate_list()
> > > and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
> > > suggested by Mimi Zohar.
> > > 
> > > v4:
> > > * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
> > > recommendation.
> > > 
> > > v3:
> > > * Included Jarkko's feedback
> > >   ** updated patch description to include approach.
> > >   ** removed extern for function declaration in the .h file.
> > > * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
> > > 
> > > v2:
> > > * Fixed the error reported by kernel test robot
> > > * Updated patch description based on Jarkko's feedback.
> > > 
> > > Nayna Jain (3):
> > >    certs: export load_certificate_list() to be used outside certs/
> > >    integrity: make integrity_keyring_from_id() non-static
> > >    integrity: support including firmware ".platform" keys at build time
> > > 
> > >   certs/Makefile                                |  5 ++--
> > >   certs/blacklist.c                             |  1 -
> > >   certs/common.c                                |  2 +-
> > >   certs/common.h                                |  9 -------
> > >   certs/system_keyring.c                        |  1 -
> > >   include/keys/system_keyring.h                 |  6 +++++
> > >   security/integrity/Kconfig                    | 10 +++++++
> > >   security/integrity/Makefile                   | 17 +++++++++++-
> > >   security/integrity/digsig.c                   |  2 +-
> > >   security/integrity/integrity.h                |  6 +++++
> > >   .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
> > >   .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
> > >   12 files changed, 92 insertions(+), 16 deletions(-)
> > >   delete mode 100644 certs/common.h
> > >   create mode 100644 security/integrity/platform_certs/platform_cert.S
> > > 
> > > -- 
> > > 2.27.0
> > To sort out tree conflicts: what if I pick these patches? They look fine
> > to me now. I can try to fix the possible merge conflicts and you can check
> > them before I make a PR.
> 
> Sounds good. Thanks !!
> 
> Thanks & Regards,
> 
>      - Nayna
> 

Sorry that this comes so later but would it possible for you to fix this
conflict against my tree and send v10 with just that change:

$ git diff
diff --cc include/keys/system_keyring.h
index 91e080efb918,d3f914d9a632..000000000000
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@@ -10,12 -10,11 +10,20 @@@
  
  #include <linux/key.h>
  
++<<<<<<< HEAD
 +enum blacklist_hash_type {
 +      /* TBSCertificate hash */
 +      BLACKLIST_HASH_X509_TBS = 1,
 +      /* Raw data hash */
 +      BLACKLIST_HASH_BINARY = 2,
 +};
++=======
+ #ifdef CONFIG_KEYS
+ int load_certificate_list(const u8 cert_list[],
+                         const unsigned long list_size,
+                         const struct key *keyring);
+ #endif
++>>>>>>> certs: export load_certificate_list() to be used outside certs/
  
I somehow lost your response to the jungle and found it only now :-(

I'm still happy to include this to the PR.

BR, Jarkko
