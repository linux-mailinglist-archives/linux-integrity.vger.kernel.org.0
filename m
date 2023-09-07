Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0514279776D
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Sep 2023 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjIGQZc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Sep 2023 12:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240939AbjIGQYG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Sep 2023 12:24:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A503C272B;
        Thu,  7 Sep 2023 09:21:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001EAC116D6;
        Thu,  7 Sep 2023 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694086232;
        bh=BQqmAsnKsYCURZdBUxzJ5oq3xlzAgdnhH5VorW6j2es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6lYQANfxUUFWoyZp/V5KNiQHdM+KGxHUGVv4pBcJQhRwOn4+5pLAvcr3hecL4Ucm
         nSg2sGI4ndAzw8OGj7Eb+6ZKbKjlRgaDPgZXIzgENndX8qklFZbFfz3Vv0QA2YGdTv
         edRhLRXleubbSps3JiKxCVXgJ8r6e62wLhHU06hA=
Date:   Thu, 7 Sep 2023 12:30:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org,
        linux-security-module@vger.kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, robh+dt@kernel.org, sashal@kernel.org,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com
Subject: Re: [PATCH 5.15] of: kexec: Mark ima_{free,stable}_kexec_buffer() as
 __init
Message-ID: <2023090723-mocha-overfed-f6df@gregkh>
References: <20230905-5-15-of-kexec-modpost-warning-v1-1-4138b2e96b4e@kernel.org>
 <169403211998.243709.4772468997015448407.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169403211998.243709.4772468997015448407.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 06, 2023 at 03:28:51PM -0500, Rob Herring wrote:
> 
> On Tue, 05 Sep 2023 13:36:11 -0700, Nathan Chancellor wrote:
> > This commit has no direct upstream equivalent.
> > 
> > After commit d48016d74836 ("mm,ima,kexec,of: use memblock_free_late from
> > ima_free_kexec_buffer") in 5.15, there is a modpost warning for certain
> > configurations:
> > 
> >   WARNING: modpost: vmlinux.o(.text+0xb14064): Section mismatch in reference from the function ima_free_kexec_buffer() to the function .init.text:__memblock_free_late()
> >   The function ima_free_kexec_buffer() references
> >   the function __init __memblock_free_late().
> >   This is often because ima_free_kexec_buffer lacks a __init
> >   annotation or the annotation of __memblock_free_late is wrong.
> > 
> > In mainline, there is no issue because ima_free_kexec_buffer() is marked
> > as __init, which was done as part of commit b69a2afd5afc ("x86/kexec:
> > Carry forward IMA measurement log on kexec") in 6.0, which is not
> > suitable for stable.
> > 
> > Mark ima_free_kexec_buffer() and its single caller
> > ima_load_kexec_buffer() as __init in 5.15, as ima_load_kexec_buffer() is
> > only called from ima_init(), which is __init, clearing up the warning.
> > 
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/of/kexec.c                 | 2 +-
> >  include/linux/of.h                 | 2 +-
> >  security/integrity/ima/ima.h       | 2 +-
> >  security/integrity/ima/ima_kexec.c | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Now queued up, thanks.

greg k-h
