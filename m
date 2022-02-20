Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B0E4BD280
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbiBTXCR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 18:02:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBTXCQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 18:02:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6105744778;
        Sun, 20 Feb 2022 15:01:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3625FB80D9C;
        Sun, 20 Feb 2022 23:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6335EC340E8;
        Sun, 20 Feb 2022 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645398110;
        bh=5OmhqiX81KNtJ2T9a1Vvx/TvbU7V6OHOgTfNkZczbi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaUqLKpvotaUtMI8vne0jeoBkaeQq1P8eGmdDbHTHAsS/UaxXKDnlcXh6aOf1aUZr
         luLTFDhhsokTV6aiWcF94lLz8zLgJcrRrkRi+2X2aKcTc+JdwLGSCdbtVoa16CThNL
         5HuBuqD2B4wGo15xM+5zebx7Qk9yeNyMzg9lVeAsidOrgnAyJp4Lzpgr+0iYfbA/lq
         lZXe1j9Z9EcnyOcdkWtQH/a8PzuCHtVPyeyHgzgEmNZ8c6XuUVEN1wWswYEGwpboU9
         BpXkmlht1y9yoc0crbgjKG5A8RfkHC4BCi4tumSzb4gr5d1T0GlBBvlhbIgCkRetaG
         TuYfhAGXfsbNA==
Date:   Mon, 21 Feb 2022 00:02:28 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me
Subject: Re: [PATCH v8 0/3] integrity: support including firmware ".platform"
 keys at build time
Message-ID: <YhLIhJF0aWZt+8op@iki.fi>
References: <20220111183647.977037-1-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111183647.977037-1-nayna@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 11, 2022 at 01:36:44PM -0500, Nayna Jain wrote:
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
>  security/integrity/Makefile                   | 17 +++++++++++-
>  security/integrity/digsig.c                   |  2 +-
>  security/integrity/integrity.h                |  6 +++++
>  .../integrity/platform_certs/platform_cert.S  | 23 ++++++++++++++++
>  .../platform_certs/platform_keyring.c         | 26 +++++++++++++++++++
>  12 files changed, 92 insertions(+), 16 deletions(-)
>  delete mode 100644 certs/common.h
>  create mode 100644 security/integrity/platform_certs/platform_cert.S
> 
> -- 
> 2.27.0

To sort out tree conflicts: what if I pick these patches? They look fine
to me now. I can try to fix the possible merge conflicts and you can check
them before I make a PR.

/Jarkko
