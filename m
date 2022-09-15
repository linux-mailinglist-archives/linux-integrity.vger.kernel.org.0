Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA25B9EFC
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIOPhF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 11:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOPhE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 11:37:04 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA03A2F388
        for <linux-integrity@vger.kernel.org>; Thu, 15 Sep 2022 08:37:02 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B13FC72C90B;
        Thu, 15 Sep 2022 18:37:00 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 994D34A46F0;
        Thu, 15 Sep 2022 18:37:00 +0300 (MSK)
Date:   Thu, 15 Sep 2022 18:36:59 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3 06/15] Add missing EVP_MD_CTX_free()
 call in calc_evm_hash()
Message-ID: <20220915153659.dtykhzitxdrlpasq@altlinux.org>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
 <20220914022956.1359218-7-zohar@linux.ibm.com>
 <20220914145136.7xiziuvcsqtiyex3@altlinux.org>
 <4e9bfc7330e205d1b2a872c6b128eab62c66263e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <4e9bfc7330e205d1b2a872c6b128eab62c66263e.camel@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Sep 15, 2022 at 07:58:51AM -0400, Mimi Zohar wrote:
> Hi Vitaly,
> 
> Thank you for this and the other reviews.  They'll be addressed in the
> next version.
> 
> On Wed, 2022-09-14 at 17:51 +0300, Vitaly Chikunov wrote:
> > > @@ -350,12 +356,11 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> > >  #if OPENSSL_VERSION_NUMBER < 0x10100000
> > >       EVP_MD_CTX ctx;
> > >       pctx = &ctx;
> > > -#else
> > > -     pctx = EVP_MD_CTX_new();
> > >  #endif
> > >  
> > >       if (lstat(file, &st)) {
> > >               log_err("Failed to stat: %s\n", file);
> > > +             errno = 0;
> > 
> > Why it clears errno (here and below)?
> > 
> > errno(3) says "The value of errno is never set to zero by any system
> > call or library function."
> 
> evmctl, itself, is not a system call or a library function. 

Ah, I wasn't attentive this is only evmctl. [But there's similar commit
acb19d1 ("Reset 'errno' after failure to open or access a file")
changing libimaevm.c which is wrong.]

Perhaps it should be noted in commit message that errno is cleared
because it's error message is already printed to avoid double printing
at exit of cmd handler.

> Is this a
> generic statement or here in particular as to how evmctl should handle
> failed system calls?   Another example is reading the keyfile.  The
> existence of which is not required.

          log_err("Failed to stat: %s\n", file);

This does not even output errno code, but it could be very informative
to user. I think it's better to print (at least errno or) strerror for
users there (and on other syscall errors log_err instances.

Maybe to add special log function (like log_strerr) just for evmctl
which will print (non "\n"-terminated) error message (similar to
warn(3)) with strerror output appended (and commented in the code why
it) clears errno (so that later handlers do not print it again).

ps. About libimaevm.c--I think errno should not be touched there as this
breaks what coders expect from libraries. If this affects exit of evmctl
then it should be handled in evmctl, not in the library. (Of course it's
better to add strerror(errno) to log_err there too, but not by the
proposed above function.)

Vitaly,

> 
> thanks,
> 
> Mimi
> 
