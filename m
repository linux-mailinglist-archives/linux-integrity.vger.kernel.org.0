Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E962748E2
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Sep 2020 21:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIVTOV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Sep 2020 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVTOU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Sep 2020 15:14:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C029CC061755
        for <linux-integrity@vger.kernel.org>; Tue, 22 Sep 2020 12:14:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so13364841pfk.2
        for <linux-integrity@vger.kernel.org>; Tue, 22 Sep 2020 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ny/WX3SoGi3xA0aasg0y+S/O8JpZEz3cKfWCtfobAKg=;
        b=c2pAKhYMfHPIvLNmZSQq/lUseuE2S6srkxcNVjAWRA3EAQyE4atTSXfXTAbReYVors
         he2fThmMzezK+5ylnM4BuEvfPS+ZwQPjTGE1yvWgaNuD05j3do76CeSkQ+Rpg2tuw1UN
         F/ZFOx4It1hffjBmBfcD50MY70vFFuJpw2pWKgKQxYW/Q1Vplj5tmNSkfsVlP5N2TiOU
         4Tgoh6BrW0B776Okcdeqz1M/yTpT4dai4ajcRs3Aj2PzIwQPpsigrQ7+Ionx0QCoSd3U
         480ZUxP7FwKS1MaQzO2nuUdnc/3wjZQXMHg2NXyuzKQWpCPMYdrjl6DIjVVAaTGyKCbl
         dW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ny/WX3SoGi3xA0aasg0y+S/O8JpZEz3cKfWCtfobAKg=;
        b=C4yX891oFFsCHYzgKBJpSRax4emLcwwep8HezsI9wlv7+uRWPrAXJ4fX86zLf4550Q
         JLbhfZ4On4IfYcyZdYrCM4RpO+NVAnY3sw7eEC+CwHLk03VWXSUQQzESDPRBBzfwSHAr
         ji91KJ/Ygv41udEEUmDAF3jF1sKpAbodhjs9Ztam6raVoWm2nDjtF39MpIy02NfVuesv
         dN69z+UbWqZjgHIUnb/CbziPC/Eq2Eg11zMwNNMlepd4+x0LcrTs62vpkcNB4WEF1Whl
         tJ+nl1ne/KENafrIqlRpiygrTABzuYHDUeBLcJM/gIMdDkoiY8AcA2hCzvKqOm86uPNv
         TcgA==
X-Gm-Message-State: AOAM532gyWUIA2bwWP2jrfKQsUgN5/b3SlXhghf4Z+0NWksuRKLjTfxo
        GEJou9CCuozNSAZZZEadMh2uvShqj6wIQkyNe+eL1Ag6Rs7sVg==
X-Google-Smtp-Source: ABdhPJx4+wQxUK2XmbPbZBrNY6pjvXyGq/eRBNGPwDxkBquhF1pENXesdgLF3QEPdD09v5Qog83AWah/9qGR004BUz0=
X-Received: by 2002:a65:554a:: with SMTP id t10mr4839340pgr.263.1600802060042;
 Tue, 22 Sep 2020 12:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200920163351.11293-5-James.Bottomley@HansenPartnership.com>
 <202009210844.KCwzdqmx%lkp@intel.com> <2d395d924b70fba7f1867eb83946497ce1f6eb47.camel@HansenPartnership.com>
In-Reply-To: <2d395d924b70fba7f1867eb83946497ce1f6eb47.camel@HansenPartnership.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Sep 2020 12:14:08 -0700
Message-ID: <CAKwvOd=yqYh9i1n84djbX_+8-4JbAUbRQL6FYnhugOocu+vCKg@mail.gmail.com>
Subject: Re: [PATCH v12 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 21, 2020 at 2:31 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Mon, 2020-09-21 at 08:07 +0800, kernel test robot wrote:
> > Hi James,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on integrity/next-integrity]
> > [also build test ERROR on linus/master v5.9-rc5 next-20200918]
> > [cannot apply to security/next-testing dhowells-fs/fscache-next]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note. And when submitting patch, we suggest to use '--base' as
> > documented in https://git-scm.com/docs/git-format-patch]
> >
> > url:
> > https://github.com/0day-ci/linux/commits/James-Bottomley/TPM-2-0-trusted-key-rework/20200921-003922
> > base:
> > https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > next-integrity
> > config: x86_64-randconfig-a003-20200921 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project
> > f4e554180962aa6bc93678898b6933ea712bde50)
> > reproduce (this is a W=1 build):
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > > > make[4]: *** No rule to make target 'security/keys/trusted-
> > > > keys/tpm2key.asn1.o', needed by 'security/keys/trusted-
> > > > keys/built-in.a'.
> >    make[4]: *** [scripts/Makefile.build:283: security/keys/trusted-
> > keys/trusted_tpm2.o] Error 1
> >    make[4]: Target '__build' not remade because of errors.
>
>
> So can I still add that tracking this down involved installing an
> entirely unnecessary ARM build environment, which was a huge effort I
> didn't need to do if you'd just provided the build log which fingered
> the ASN.1 compiler problem if you know what to look for.

Having a link to the build log artifact is a valid criticism.

>
> The reason for the problem is because ASN1 isn't selected in the
> Kconfig which causes the ASN.1 compiler not to be built.  The way our
> current build rules are structured causes the make rule for this simply
> to be skipped, which means you have to know to look for the absence of
> ASN.1 in the build log.  I propose adding this to the build rules,
> which produces the much more explicit:
>
> /home/jejb/git/linux-build/scripts/Makefile.build:387: *** CONFIG_ASN1 must be defined for the asn1_compiler.  Stop.
> make[3]: *** [/home/jejb/git/linux-build/scripts/Makefile.build:505: security/keys/trusted-keys] Error 2
>
> James
>
> ---
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index a467b9323442..bca7003beac8 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -382,6 +382,11 @@ quiet_cmd_asn1_compiler = ASN.1   $(basename $@).[ch]
>        cmd_asn1_compiler = $(objtree)/scripts/asn1_compiler $< \
>                                 $(basename $@).c $(basename $@).h
>
> +ifndef CONFIG_ASN1
> +$(objtree)/scripts/asn1_compiler:
> +       $(error CONFIG_ASN1 must be defined for the asn1_compiler)
> +endif
> +
>  $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
>         $(call cmd,asn1_compiler)

Is there a better way via Kconfig to gate whatever consumes
CONFIG_ASN1 on CONFIG_ASN1 being set, rather than erroring for
randconfig builds? I don't see how the diff would solve the case of CI
systems doing randconfig builds.
-- 
Thanks,
~Nick Desaulniers
