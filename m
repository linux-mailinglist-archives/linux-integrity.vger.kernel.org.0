Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA304CE313
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Mar 2022 06:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiCEFi4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 5 Mar 2022 00:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiCEFi4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 5 Mar 2022 00:38:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48874EF54;
        Fri,  4 Mar 2022 21:38:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77003B80EFF;
        Sat,  5 Mar 2022 05:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71DBC004E1;
        Sat,  5 Mar 2022 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646458684;
        bh=LMIqGM/SSvRoh46+l9QergJBMyKlC0EkMePi5NTOh3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xx6ZZpRR51eOrgP3VHLkyq0oI9f+lQgG/RHntdgVG0kW5s2Y2G0V30gGpl9ZbCCO0
         nJLmwDBmNgOeNP1lpv9Tt63QlJ0Sx5nEC0oRyQPutYGU/caPNeIE9NMcEM7KEO82WX
         ePz/DcJtB6Hej4colruuNJGRF5DhD3wEH/7wDSEBHtQyloBi55DRR4dZ0qdfBAo96L
         hRzbTWvvo3rElHn+Y4rAzRYP6MBpc125vhWfJcyqDHVZYWTwVfYn0EcncFIQ+TyRHR
         m2vjOb2TQnbpmnTt8gITTIoq75tl1cuRmMf3zx3BaVglwsQXp62ik42VjWIKJfR/2E
         8ce06Nnqy2CEQ==
Date:   Sat, 5 Mar 2022 07:37:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com
Subject: Re: [PATCH v9 0/3] integrity: support including firmware ".platform"
 keys at build time
Message-ID: <YiL3DvrlAHaMm+lk@iki.fi>
References: <20220304175403.20092-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304175403.20092-1-nayna@linux.ibm.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 04, 2022 at 12:54:00PM -0500, Nayna Jain wrote:
> Some firmware support secure boot by embedding static keys to verify the
> Linux kernel during boot. However, these firmware do not expose an
> interface for the kernel to load firmware keys onto the ".platform"
> keyring, preventing the kernel from verifying the kexec kernel image
> signature.
> 
> This patchset exports load_certificate_list() and defines a new function
> load_builtin_platform_cert() to load compiled in certificates onto the
> ".platform" keyring.
> 
> Changelog:
> v9:
> * Rebased on tpmdd master branch repo - 
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> 
> v8:
> * Includes Jarkko's feedback on patch description and removed Reported-by
> for Patch 1.
> 
> v7:
> * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
> 
> v6:
> * Includes Jarkko's feedback:
>  * Split Patch 2 into two.
>  * Update Patch description.
> 
> v5:
> * Renamed load_builtin_platform_cert() to load_platform_certificate_list()
> and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
> suggested by Mimi Zohar.
> 
> v4:
> * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
> recommendation.
> 
> v3:
> * Included Jarkko's feedback
>  ** updated patch description to include approach.
>  ** removed extern for function declaration in the .h file.
> * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
> 
> v2:
> * Fixed the error reported by kernel test robot
> * Updated patch description based on Jarkko's feedback.
> 
> Nayna Jain (3):
>   certs: export load_certificate_list() to be used outside certs/
>   integrity: make integrity_keyring_from_id() non-static
>   integrity: support including firmware ".platform" keys at build time
> 
>  certs/Makefile                                |  5 ++--
>  certs/blacklist.c                             |  1 -
>  certs/common.c                                |  2 +-
>  certs/common.h                                |  9 -------
>  certs/system_keyring.c                        |  1 -
>  include/keys/system_keyring.h                 |  6 +++++
>  security/integrity/Kconfig                    | 10 +++++++
>  security/integrity/Makefile                   | 15 ++++++++++-
>  security/integrity/digsig.c                   |  2 +-
>  security/integrity/integrity.h                |  6 +++++
>  .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>  .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>  12 files changed, 90 insertions(+), 16 deletions(-)
>  delete mode 100644 certs/common.h
>  create mode 100644 security/integrity/platform_certs/platform_cert.S
> 
> 
> base-commit: c9e54f38976a1c0ec69c0a6208b3fd55fceb01d1
> -- 
> 2.27.0

Thank you, applied. 

BR, Jarkko


