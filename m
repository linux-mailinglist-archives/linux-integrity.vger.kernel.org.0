Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5F5601D0
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jun 2022 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiF2OBc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2OB3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 10:01:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB0B23141;
        Wed, 29 Jun 2022 07:01:25 -0700 (PDT)
Received: from zn.tnic (p200300ea97156ae0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:6ae0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF6A31EC04C2;
        Wed, 29 Jun 2022 16:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656511279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1nfA4bd39uY9wmMuXeUB/WuKXARluBCBaMbOeIYcBnY=;
        b=LRK5ezlYQtIou/WwjqaCHEkzUwF537MTzAq2lHavZu/AFBFt05GjuZvi60LPc/HaFKAxzq
        8gWqVL7Mu26tnpybnyjQJEPDCModDkJIdXd2axk+QkTaTDn2Byx0on7m3eWcQgCLlHow8m
        WLyN6KMa6BsOQrx4FEIgjDu5NbaXcMM=
Date:   Wed, 29 Jun 2022 16:01:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] of: Correctly annotate IMA kexec buffer functions
Message-ID: <YrxbK4IsYb6yls5d@zn.tnic>
References: <202206291039.yGgljGbx-lkp@intel.com>
 <YrwPjnxBk3Xyuakg@zn.tnic>
 <Yrwg1aYEnFz38V6+@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yrwg1aYEnFz38V6+@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 29, 2022 at 09:52:50AM +0000, Jonathan McDowell wrote:
> Below is on top of what was in tip; I can roll a v7 if preferred but
> I think seeing the fix on its own is clearer.

Yes, and you don't have to base it on top because, as I've said, I've
zapped your other patch there.

Once IMA folks are fine with that fix of yours I can take both, if they
wish so.

> ima_free_kexec_buffer() calls into memblock_phys_free() so must be
> annotated __meminit.

Why __meminit?

The very sparse comment over it says:

/* Used for MEMORY_HOTPLUG */
#define __meminit        __section(".meminit.text") __cold notrace \
                                                  __latent_entropy

so how does ima_free_kexec_buffer() have anything to do with
MEMORY_HOTPLUG?

It calls memblock_phys_free() which is __init_memblock.

Now __init_memblock is defined as

#define __init_memblock __meminit

for some CONFIG_ARCH_KEEP_MEMBLOCK thing so I guess that is the
connection.

But then the couple other functions which call into memblock are all
__init...

IOW, I probably am missing something...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
