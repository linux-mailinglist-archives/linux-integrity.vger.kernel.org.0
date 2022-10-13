Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967AC5FD4DC
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Oct 2022 08:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJMGdG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 02:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMGdF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 02:33:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A977127927;
        Wed, 12 Oct 2022 23:33:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 115F01F385;
        Thu, 13 Oct 2022 06:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665642783;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gMU1oYsVQ3ZO2pd5Lj1627G06fVfVov6GV580JVfSQE=;
        b=BXAIOJlvvDdiXlh+E0ukinetXmdqCsAzNochzKg3N06kAB0ooHvnmq28acwLm5pYNT6ecc
        ojVsa1V01JKiaf9L3WElxGMA1WAtAP6w5IJwDAe/D1u/PmC6/sArivyxe25OVugafdGzjs
        FRR6UzEsMhOcbNA5F17/YqMy9uHNBNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665642783;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gMU1oYsVQ3ZO2pd5Lj1627G06fVfVov6GV580JVfSQE=;
        b=MeXbCh0XeTGrKzDrlGAM9y3pDpbdxILiSN2Y97aOdfkmEFxJNwu2nZVfKhkWqverww5I20
        MH2IpupvndeQUlAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 858F6139F3;
        Thu, 13 Oct 2022 06:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B+bVHh6xR2PWJgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 06:33:02 +0000
Date:   Thu, 13 Oct 2022 08:33:01 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Nikolaus Voss <nv@vosn.de>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Yael Tzur <yaelt@google.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: encrypted: fix key instantiation with
 user-provided data
Message-ID: <Y0exHaHxEvj9FC/O@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221012151429.391EE9BB@mail.steuer-voss.de>
 <ca642045c0725c045b165f9daef03bd413c6850a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca642045c0725c045b165f9daef03bd413c6850a.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Nikolaus, all,

> Hi Nikolaus,

> On Wed, 2022-10-12 at 17:09 +0200, Nikolaus Voss wrote:
> > Commit cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
> > decrypted data") added key instantiation with user provided decrypted data.
> > The user data is hex-ascii-encoded but was just memcpy'ed to the binary buffer.
> > Fix this to use hex2bin instead.

> > Keys created from user provided decrypted data saved with "keyctl pipe"
> > are still valid, however if the key is recreated from decrypted data the
> > old key must be converted to the correct format. This can be done with a
> > small shell script, e.g.:

> > BROKENKEY=abcdefABCDEF1234567890aaaaaaaaaa
> > NEWKEY=$(echo -ne $BROKENKEY | xxd -p -c64)
> > keyctl add user masterkey "$(cat masterkey.bin)" @u
> > keyctl add encrypted testkey "new user:masterkey 32 $NEWKEY" @u

> > It is encouraged to switch to a new key because the effective key size
> > of the old keys is only half of the specified size.

> Thank you for updating the patch description.


> > The corresponding test for the Linux Test Project ltp has been fixed
> > with this patch:
> > https://lists.linux.it/pipermail/ltp/2022-October/031060.html
FYI, we use lore, thus:

Link: https://lore.kernel.org/ltp/20221006081709.92303897@mail.steuer-voss.de/

> Perhaps make this a "Link:" line and move it before your "Signed-off-
> by".

> > Changes
> > =======

> As per Documentation/process/submitting-patches.rst, the changelog
> belongs after the "---" separator. 

> > v2: - clarify commit message, add example to recover old/broken keys
> >     - improve example in Documentation/security/keys/trusted-encrypted.rst
> >     - add link to ltp patch

> > Fixes: cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided decrypted data")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> > ---
> >  Documentation/security/keys/trusted-encrypted.rst | 3 ++-
> >  security/keys/encrypted-keys/encrypted.c          | 6 +++---
> >  2 files changed, 5 insertions(+), 4 deletions(-)

> > diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> > index 0bfb4c339748..e81e47db0b4c 100644
> > --- a/Documentation/security/keys/trusted-encrypted.rst
> > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > @@ -350,7 +350,8 @@ Load an encrypted key "evm" from saved blob::

> >  Instantiate an encrypted key "evm" using user-provided decrypted data::

> > -    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypted_data.blob`" @u
> > +    $ evmkey=abcdefABCDEF1234567890aaaaaaaaaaabcdefABCDEF1234567890aaaaaaaaaa
> > +    $ keyctl add encrypted evm "new default user:kmk 32 $evmkey" @u
> >      794890253

> As example code is often re-used, I would avoid including the key data
> on the command line.
