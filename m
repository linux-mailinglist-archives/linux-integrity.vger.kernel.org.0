Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E5520565
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 21:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiEITo3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiEITo2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 15:44:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68B17706D;
        Mon,  9 May 2022 12:40:32 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BA8B1EC0494;
        Mon,  9 May 2022 21:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652125226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AoQvWKpDU2P9lFLXU3ELvlGMrlfk5EWwWkEu8isye3M=;
        b=DQuH+dnuMo1XHCdc4ZpdApzMaFQlpLltEumRjTO50gpT+YcXRQwzFwSB5wJ2DyhUWQ/HFz
        KZ50vFjPK3Eo8Oo0PNr+rFPebrt+K0CRHG4cS6DBsf7DllxhAOeBaeyMX23V+ApO6wOyW5
        8OnulC85syhrH2iJiEvQ95QtbvZ2bOo=
Date:   Mon, 9 May 2022 21:40:28 +0200
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
Message-ID: <YnluLIEN9HH+QvrD@zn.tnic>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
 <0960C132-581C-4881-8948-C566657C3998@alien8.de>
 <YnlTaawPH6T7LOUs@noodles-fedora.dhcp.thefacebook.com>
 <YnlY87wm6WmQjs7m@zn.tnic>
 <YnlgTCyB2ciaD1so@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnlgTCyB2ciaD1so@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 06:41:17PM +0000, Jonathan McDowell wrote:
> I'm not tied to setup_data but given the concerns I raise above with
> device tree on x86 and the need to handle this in the kernel it seemed
> like a reasonable first approach. You seem to be saying it's not and
> either adding the device tree infrastructure or doing a command line
> hack would be preferable?

All I'm doing is asking more questions to make you give more details as
to why you wanna do it this way. I'll take a detailed look tomorrow but
it looks ok from a quick glance.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
