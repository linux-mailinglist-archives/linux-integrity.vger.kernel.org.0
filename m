Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3204D523C10
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 19:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbiEKR4k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbiEKR4j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 13:56:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9F33B57F;
        Wed, 11 May 2022 10:56:27 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE9501EC0535;
        Wed, 11 May 2022 19:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652291781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GTg1ZSG8tdoJ8Un5Pa70eoBMG9Ax/ldvlvlcyKKfV3E=;
        b=iPODDOIc6RyWxTpJtBxT6AOjKo1uKlPx/uJZXQ5buY/OjTjFmQwMZhL6xJZqi1io4AGQZ5
        bQIJ/ZLLzJNVJZcJSVVO20knOmJrvqvhSuhCT8/RA3afOAXcz8GlWaGGgsZM8WKVLRA5cN
        KUGuXK6u/kDptGOdv2/CUS2phVFg17w=
Date:   Wed, 11 May 2022 19:56:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <Ynv4zBnLvbMKrwrq@zn.tnic>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <67f0fe5874638241bc2f2401dc2bc12c51becc0b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67f0fe5874638241bc2f2401dc2bc12c51becc0b.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 11, 2022 at 01:53:23PM -0400, Mimi Zohar wrote:
> This patch doesn't apply to Linus' master branch.  Which tip/master
> branch?

This one:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/

Considering how the majority of the changes are x86-specific, I was
thinking I'd carry it through the tip tree after getting your ACK for
the IMA side of things?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
