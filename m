Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8179520443
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiEISNx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 14:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiEISNw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 14:13:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8816EEB8;
        Mon,  9 May 2022 11:09:57 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1737B1EC01E0;
        Mon,  9 May 2022 20:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652119792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L9Ar+ydmc7t38d3TuBxUw1cNUzBjweI6t/LwvKD8DEI=;
        b=LlSfo//agkPEyJ0VR6GE3fKki2x2cRN11SSjWMpSJewrU9LoSBPDq4g68zlEIa7ZJqVooK
        7/okTqr92ZIgaEVYqIDjMkXwMDwpvqyzVMegVpsryiVt197V2FLQbN+f4mX3CoHpVfV+Ix
        RcmZ1bN5m+R8fx9+MZPIt56mfAvUvOY=
Date:   Mon, 9 May 2022 20:09:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
Message-ID: <YnlY87wm6WmQjs7m@zn.tnic>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
 <0960C132-581C-4881-8948-C566657C3998@alien8.de>
 <YnlTaawPH6T7LOUs@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnlTaawPH6T7LOUs@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 05:46:22PM +0000, Jonathan McDowell wrote:
> Device tree on x86 doesn't seem to be a thing;

Not a thing? What does that even mean?

We have arch/x86/kernel/devicetree.c which adds some minimal devicetree
support.

> none of the distros I regularly use enable CONFIG_OF for x86, I can
> only find 2 32-bit x86 platforms that actually select it and none of
> the plumbing for kexec on x86 ties in device tree.

And? That can get changed and enabled and so on.

> I agree for platforms that make active use of device tree that's the
> appropriate path, but it doesn't seem to be the case for x86.

I'm not sure what you're aim here is?

You want to pass that IMA measurement to the kexec kernel with minimal
changes, i.e., change only the kernel?

Why can't distros be also changed to use devicetree for the IMA
measurement, like the other arches do? Why does x86 need to do it
differently?

We also pass info to the kexec kernel by reading it from sysfs
and having kexec tools pass it to the kexec-ed kernel, see
Documentation/ABI/testing/sysfs-firmware-efi-runtime-map

kexec(8) itself can do:

kexec -l kernel-image --append=command-line-options
			^^^^^^^^^^^^^^^^^

and add those cmdline options which are dug out from the first kernel.

So is there any particular reason/pressing need to pass the measurement
with setup_data?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
