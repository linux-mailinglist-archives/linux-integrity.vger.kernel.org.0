Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D7274931
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Sep 2020 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIVTbr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Sep 2020 15:31:47 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56510 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgIVTbr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Sep 2020 15:31:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B35AC8EE1C7;
        Tue, 22 Sep 2020 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600803106;
        bh=yi4m9znAa764szPgbwyELYjxj6tC/DbtwWe2jakoDJc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rkY1h3Bwl/HS076rK0ObNC9jd6yEzNcDDasIkTeFVO29k8y5O/M8nnHDDkSdXY6Zs
         4CcbjHAQ4TgHR8CVAerE5ifxENzZelzuPNk8idIrff1101yqX30vCgP0gx2EPJpjog
         9OgHqnI6Drh0xOpT6NvAMHHPeMDlRS0ZB+xzdYRE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uREMc2vhppC2; Tue, 22 Sep 2020 12:31:46 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DF7FD8EE0E0;
        Tue, 22 Sep 2020 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600803106;
        bh=yi4m9znAa764szPgbwyELYjxj6tC/DbtwWe2jakoDJc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rkY1h3Bwl/HS076rK0ObNC9jd6yEzNcDDasIkTeFVO29k8y5O/M8nnHDDkSdXY6Zs
         4CcbjHAQ4TgHR8CVAerE5ifxENzZelzuPNk8idIrff1101yqX30vCgP0gx2EPJpjog
         9OgHqnI6Drh0xOpT6NvAMHHPeMDlRS0ZB+xzdYRE=
Message-ID: <a2bb4d02f6de58bc7660f9896a34313a0c84bfcc.camel@HansenPartnership.com>
Subject: Re: [PATCH v12 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Sep 2020 12:31:44 -0700
In-Reply-To: <CAKwvOd=yqYh9i1n84djbX_+8-4JbAUbRQL6FYnhugOocu+vCKg@mail.gmail.com>
References: <20200920163351.11293-5-James.Bottomley@HansenPartnership.com>
         <202009210844.KCwzdqmx%lkp@intel.com>
         <2d395d924b70fba7f1867eb83946497ce1f6eb47.camel@HansenPartnership.com>
         <CAKwvOd=yqYh9i1n84djbX_+8-4JbAUbRQL6FYnhugOocu+vCKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-09-22 at 12:14 -0700, Nick Desaulniers wrote:
> On Mon, Sep 21, 2020 at 2:31 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > On Mon, 2020-09-21 at 08:07 +0800, kernel test robot wrote:
> > > Hi James,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on integrity/next-integrity]
> > > [also build test ERROR on linus/master v5.9-rc5 next-20200918]
> > > [cannot apply to security/next-testing dhowells-fs/fscache-next]
> > > [If your patch is applied to the wrong git tree, kindly drop us a
> > > note. And when submitting patch, we suggest to use '--base' as
> > > documented in https://git-scm.com/docs/git-format-patch]
> > > 
> > > url:
> > > https://github.com/0day-ci/linux/commits/James-Bottomley/TPM-2-0-trusted-key-rework/20200921-003922
> > > base:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > > next-integrity
> > > config: x86_64-randconfig-a003-20200921 (attached as .config)
> > > compiler: clang version 12.0.0 (
> > > https://github.com/llvm/llvm-project
> > > f4e554180962aa6bc93678898b6933ea712bde50)
> > > reproduce (this is a W=1 build):
> > >         wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install x86_64 cross compiling tool for clang build
> > >         # apt-get install binutils-x86-64-linux-gnu
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> > > make.cross
> > > ARCH=x86_64
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > > > make[4]: *** No rule to make target 'security/keys/trusted-
> > > > > keys/tpm2key.asn1.o', needed by 'security/keys/trusted-
> > > > > keys/built-in.a'.
> > >    make[4]: *** [scripts/Makefile.build:283:
> > > security/keys/trusted-
> > > keys/trusted_tpm2.o] Error 1
> > >    make[4]: Target '__build' not remade because of errors.
> > 
> > So can I still add that tracking this down involved installing an
> > entirely unnecessary ARM build environment, which was a huge effort
> > I didn't need to do if you'd just provided the build log which
> > fingered the ASN.1 compiler problem if you know what to look for.
> 
> Having a link to the build log artifact is a valid criticism.

Heh, I'm just annoyed because when I finally got the ARM environment
installed and the problem replicated, I realised it could be reproduced
with an x86 build ... just one that would never be useful in practice.

> > The reason for the problem is because ASN1 isn't selected in the
> > Kconfig which causes the ASN.1 compiler not to be built.  The way
> > our current build rules are structured causes the make rule for
> > this simply to be skipped, which means you have to know to look for
> > the absence of ASN.1 in the build log.  I propose adding this to
> > the build rules, which produces the much more explicit:
> > 
> > /home/jejb/git/linux-build/scripts/Makefile.build:387: ***
> > CONFIG_ASN1 must be defined for the asn1_compiler.  Stop.
> > make[3]: *** [/home/jejb/git/linux-
> > build/scripts/Makefile.build:505: security/keys/trusted-keys] Error
> > 2
> > 
> > James
> > 
> > ---
> > 
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index a467b9323442..bca7003beac8 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -382,6 +382,11 @@ quiet_cmd_asn1_compiler = ASN.1   $(basename
> > $@).[ch]
> >        cmd_asn1_compiler = $(objtree)/scripts/asn1_compiler $< \
> >                                 $(basename $@).c $(basename $@).h
> > 
> > +ifndef CONFIG_ASN1
> > +$(objtree)/scripts/asn1_compiler:
> > +       $(error CONFIG_ASN1 must be defined for the asn1_compiler)
> > +endif
> > +
> >  $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1
> > $(objtree)/scripts/asn1_compiler
> >         $(call cmd,asn1_compiler)
> 
> Is there a better way via Kconfig to gate whatever consumes
> CONFIG_ASN1 on CONFIG_ASN1 being set, rather than erroring for
> randconfig builds? I don't see how the diff would solve the case of
> CI systems doing randconfig builds.

Well, no there's an actual bug: all consumers of asn1_compile need a
select ASN1.  This was missing from the v12 patch and is now included
in the v13 one.  This Makefile.build patch here was just to make the
problem explicit in the 0day logs if it ever occurs again.

The reason it only showed up on arm32 is that pretty much only an
embedded kernel is cut down enough to create a randconfig that doesn't
pull in CRYPTO_RSA, which also selects ASN1 and hides the problem.

James


