Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1A74DC046
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Mar 2022 08:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiCQHkS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Mar 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiCQHkR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Mar 2022 03:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8DDBD2FD;
        Thu, 17 Mar 2022 00:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70591B81DD2;
        Thu, 17 Mar 2022 07:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCF3C340EE;
        Thu, 17 Mar 2022 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647502739;
        bh=O79CEsoyIM7lxDVdJAO6U5R65lNwXiJdQsB6hFftUwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFuNrIGNOAYmosTutCqrDM2kXVQiSItuO1IPhKEQHAgH4HwLiAVMVFOUjKN1DjwpD
         4osvtn0lcnS5F3eaG/pVFKSfTBWqvFh4j3uOfHDvJqSb5w7sdTzuiMs7XGd8P6O7bi
         nyTHoIxWh2wpLcbgW+auOg2nRYmMp/h2OS8E/tHxx/fqzhXDcGN2X8rrWFT4x9wjya
         lXreP54kXkeKsCdeEub9CRYsu+1htrC11ZTTR8/u+1xq2QpR+q9qaW8/uKQxf7pfPg
         dmmgPCqjUgq2TsKZ2sBgff7IHAw4/Z8RkkDwFr9sPZaIyYrVVFnyCuqLtZzBHIcGLz
         nNz2EoXYfsZFw==
Date:   Thu, 17 Mar 2022 09:38:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nageswara Sastry <rnsastry@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v11 0/4] integrity: support including firmware
 ".platform" keys at build time
Message-ID: <YjLlYTs+2ep80zoK@iki.fi>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
 <4afae87c-2986-6b0e-07be-954dd4937afd@linux.ibm.com>
 <f78d11fefd13bd17748e36621acee9c2f27a77f6.camel@kernel.org>
 <f92ec4d8-47c0-ece5-3c52-caeb8265881c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f92ec4d8-47c0-ece5-3c52-caeb8265881c@linux.vnet.ibm.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 11, 2022 at 04:03:12PM -0500, Nayna wrote:
> 
> On 3/11/22 11:42, Jarkko Sakkinen wrote:
> > On Fri, 2022-03-11 at 10:11 +0530, Nageswara Sastry wrote:
> > > 
> > > On 11/03/22 3:14 am, Nayna Jain wrote:
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
> > > > v11:
> > > > * Added a new patch to conditionally build extract-cert if
> > > > PLATFORM_KEYRING is enabled.
> > > > 
> > > Tested the following four patches with and with out setting
> > > CONFIG_INTEGRITY_PLATFORM_KEYS
> > > 
> > > Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> > OK, I added it:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> 
> Thanks Jarkko. Masahiro Yamada would prefer to revert the original commit
> 340a02535ee785c64c62a9c45706597a0139e972 i.e. move extract-cert back to the
> scripts/ directory.
> 
> I am just posting v12 which includes Masahiro feedback. Nageswara has
> already tested v12 version as well.
> 
> I am fine either way 1.) Adding v11 and then separately handling of
> reverting of the commit or 2.) Adding v12 version which includes the revert.
> I leave the decision on you as to which one to upstream.
> 
> Thanks & Regards,
> 
>     - Nayna
> 

I already sent PR for v5.18. Too many late changes to include this, which
means that v12 is the way to go.

BR, Jarkko

