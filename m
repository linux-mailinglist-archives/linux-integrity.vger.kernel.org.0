Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1E4B556C
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Feb 2022 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356039AbiBNPzk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Feb 2022 10:55:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbiBNPzk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Feb 2022 10:55:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824F4968F;
        Mon, 14 Feb 2022 07:55:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A75051F38B;
        Mon, 14 Feb 2022 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644854129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9MmC9qkXYRWrTYfRcCJEivsJms60nX4tIrMOUzEtWM=;
        b=u2FyfK++GVdTzQOjqWcqZGLBUUzrDhYKtU57FNklJOt/e4NK7Ftz0UbOcIPXvf2tiz8yjC
        lOg4m1lH1HgqVUk5WhL9P0848EpI0TeXdVvzmIRoxnDQUtvmgcKuSfY1LwMOO9hOAfDpie
        JLjWKG8CZYhVYy8OF3M7nq+jfqPZ6Gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644854129;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k9MmC9qkXYRWrTYfRcCJEivsJms60nX4tIrMOUzEtWM=;
        b=DZL+qoheqv/LmFulfWwBj6ooEqSB1jfA3QUYZzmGmg+dkmwxT83ob8JmlxLvtLwJu6Pvpa
        ANP+ga/h5qpfxHCg==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4E27A3B89;
        Mon, 14 Feb 2022 15:55:25 +0000 (UTC)
Date:   Mon, 14 Feb 2022 16:55:24 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Message-ID: <20220214155524.GN3113@kunlun.suse.cz>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
 <cff97dbe262919ff709a5ad2c4af6a702cc72a95.camel@linux.ibm.com>
 <a8d717a44e5e919676e9b1e197cac781db46da87.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d717a44e5e919676e9b1e197cac781db46da87.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

On Mon, Feb 14, 2022 at 10:14:16AM -0500, Mimi Zohar wrote:
> Hi Michal,
> 
> On Sun, 2022-02-13 at 21:59 -0500, Mimi Zohar wrote:
> 
> > 
> > On Tue, 2022-01-11 at 12:37 +0100, Michal Suchanek wrote:
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index dea74d7717c0..1cde9b6c5987 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -560,6 +560,22 @@ config KEXEC_FILE
> > >  config ARCH_HAS_KEXEC_PURGATORY
> > >         def_bool KEXEC_FILE
> > >  
> > > +config KEXEC_SIG
> > > +       bool "Verify kernel signature during kexec_file_load() syscall"
> > > +       depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > > +       help
> > > +         This option makes kernel signature verification mandatory for

This is actually wrong. KEXEC_SIG makes it mandatory that any signature
that is appended is valid and made by a key that is part of the platform
keyiring (which is also wrong, built-in keys should be also accepted).
KEXEC_SIG_FORCE or an IMA policy makes it mandatory that the signature
is present.

> > > +         the kexec_file_load() syscall.
> > 
> > When KEXEC_SIG is enabled on other architectures, IMA does not define a
> > kexec 'appraise' policy rule.  Refer to the policy rules in
> > security/ima/ima_efi.c.  Similarly the kexec 'appraise' policy rule in

I suppose you mean security/integrity/ima/ima_efi.c

I also think it's misguided because KEXEC_SIG in itself does not enforce
the signature. KEXEC_SIG_FORCE does.

> > arch/powerpc/kernel/ima_policy.c should not be defined.

I suppose you mean arch/powerpc/kernel/ima_arch.c - see above.


Thanks for taking the time to reseach and summarize the differences.

> The discussion shouldn't only be about IMA vs. KEXEC_SIG kernel image
> signature verification.  Let's try and reframe the problem a bit.
> 
> 1. Unify and simply the existing kexec signature verification so
> verifying the KEXEC kernel image signature works irrespective of
> signature type - PE, appended signature.
> 
> solution: enable KEXEC_SIG  (This patch set, with the above powerpc IMA
> policy changes.)
> 
> 2. Measure and include the kexec kernel image in a log for attestation,
> if desired.
> 
> solution: enable IMA_ARCH_POLICY 
> - Powerpc: requires trusted boot to be enabled.
> - EFI:   requires  secure boot to be enabled.  The IMA efi policy
> doesn't differentiate between secure and trusted boot.
> 
> 3. Carry the kexec kernel image measurement across kexec, if desired
> and supported on the architecture.
> 
> solution: enable IMA_KEXEC
> 
> Comparison: 
> - Are there any differences between IMA vs. KEXEC_SIG measuring the
> kexec kernel image?
> 
> One of the main differences is "what" is included in the measurement
> list differs.  In both cases, the 'd-ng' field of the IMA measurement
> list template (e.g. ima-ng, ima-sig, ima-modsig) is the full file hash
> including the appended signature.  With IMA and the 'ima-modsig'
> template, an additional hash without the appended signature is defined,
> as well as including the appended signature in the 'sig' field.
> 
> Including the file hash and appended signature in the measurement list
> allows an attestation server, for example, to verify the appended
> signature without having to know the file hash without the signature.

I don't understand this part. Isn't the hash *with* signature always
included, and the distinguishing part about IMA is the hash *without*
signature which is the same irrespective of signature type (PE, appended
xattr) and irrespective of the keyt used for signoing?

> Other differences are already included in the Kconfig KEXEC_SIG "Notes"
> section.

Which besides what is already described above would be blacklisting
specific binaries, which is much more effective if you have hashes of
binaries without signature.

Thanks

Michal
