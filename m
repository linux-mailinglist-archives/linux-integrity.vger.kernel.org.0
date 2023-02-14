Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1545169657B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Feb 2023 14:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjBNNzr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Feb 2023 08:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjBNNzm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 08:55:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B2E298C3;
        Tue, 14 Feb 2023 05:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C82061652;
        Tue, 14 Feb 2023 13:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AC5C4339E;
        Tue, 14 Feb 2023 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676382855;
        bh=qoULczsZVvR5w2vQsBUhToIAimNxpI6ClMZuCke9diw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f3DILNWb3pTsxyOZtfvBrQ+C4ix9A+o6s7JpTxtVu2QU96pfhVo6f4ghhN+iBwxrQ
         gSZbUV87VXYbVzwK1d0UFGKj0WC8Zt60A2WpGwRgqzCAoyZ+TKzpNEL10T/gpu1L4v
         XgpNBidhbjcDAQUW6u5QNrbWfjWQex+VE/vpm7VB9s/N5d3WtDE+Nc+pocQCmHd1VA
         Vv5qMZYcVjzWQuWLYppfKHstTiWEeq8z4GA5JFXcnwsPArQcDTTkYLENBkqok1eCvv
         R31umtPncwMj1XUjdY8yRoD+V2F+KUR/wm1cc4iL1bXR+0T0TPB/dckXlpGKS0Hphl
         JtQHhlbiOktMQ==
Received: by mail-lj1-f177.google.com with SMTP id m10so18457809ljp.3;
        Tue, 14 Feb 2023 05:54:15 -0800 (PST)
X-Gm-Message-State: AO0yUKUesMI28XoppJYY+MirSCy3+eqW/sWhzGm/KdJ7o/KE/FYYLIms
        0Nc2AeNKuyt9o28Vv1Te7x07mfLgvHu7fEQve60=
X-Google-Smtp-Source: AK7set80w1qmX66r7ie/9uXTu63eyR0TSO4NmcKBF9OB6VKHcRlvRTYXBSILu7W+DyQ45/pnO8hb8WnL30RToFNtGFk=
X-Received: by 2002:a2e:88d6:0:b0:28e:1ca4:b62 with SMTP id
 a22-20020a2e88d6000000b0028e1ca40b62mr222096ljk.97.1676382853760; Tue, 14 Feb
 2023 05:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
 <202301250706.deGvd0yq-lkp@intel.com> <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
 <Y9ykeASyzhSKQCmx@yujie-X299> <Y+MNxmzlILarAlZA@kernel.org>
 <3109ff421139af6b0d9e66a06d8399135e546fa7.camel@HansenPartnership.com> <Y+nqpLm2YyYkcZ+H@kernel.org>
In-Reply-To: <Y+nqpLm2YyYkcZ+H@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Feb 2023 14:54:02 +0100
X-Gmail-Original-Message-ID: <CAMj1kXECgmUMjKZk41oeXWWQpX5wB22YtBt2CSAQzEq8SqbY_g@mail.gmail.com>
Message-ID: <CAMj1kXECgmUMjKZk41oeXWWQpX5wB22YtBt2CSAQzEq8SqbY_g@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Yujie Liu <yujie.liu@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-integrity@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 13 Feb 2023 at 08:45, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, Feb 10, 2023 at 09:48:15AM -0500, James Bottomley wrote:
> > On Wed, 2023-02-08 at 04:49 +0200, Jarkko Sakkinen wrote:
> > > On Fri, Feb 03, 2023 at 02:06:48PM +0800, Yujie Liu wrote:
> > > > Hi James,
> > > >
> > > > On Wed, Jan 25, 2023 at 07:59:09AM -0500, James Bottomley wrote:
> > > > > On Wed, 2023-01-25 at 07:11 +0800, kernel test robot wrote:
> > > > > > Hi James,
> > > > > >
> > > > > > I love your patch! Perhaps something to improve:
> > > > > >
> > > > > > [auto build test WARNING on char-misc/char-misc-testing]
> > > > > > [also build test WARNING on char-misc/char-misc-next char-
> > > > > > misc/char-
> > > > > > misc-linus zohar-integrity/next-integrity linus/master v6.2-rc5
> > > > > > next-
> > > > > > 20230124]
> > > > > > [If your patch is applied to the wrong git tree, kindly drop us
> > > > > > a
> > > > > > note.
> > > > > > And when submitting patch, we suggest to use '--base' as
> > > > > > documented
> > > > > > in
> > > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information
> > > > > > ]
> > > > > >
> > > > > > url:
> > > > > > https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
> > > > > > patch link:
> > > > > > https://lore.kernel.org/r/20230124175516.5984-7-James.Bottomley%40HansenPartnership.com
> > > > > > patch subject: [PATCH v2 06/11] tpm: Add full HMAC and
> > > > > > encrypt/decrypt session handling code
> > > > > > config: arc-allyesconfig
> > > > > > (
> > > > > > https://download.01.org/0day-ci/archive/20230125/202301250706.de
> > > > > > Gvd0
> > > > > > yq-lkp@intel.com/config)
> > > > > > compiler: arceb-elf-gcc (GCC) 12.1.0
> > > > > > reproduce (this is a W=1 build):
> > > > > >         wget
> > > > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > > > >  -O ~/bin/make.cross
> > > > > >         chmod +x ~/bin/make.cross
> > > > > >         #
> > > > > > https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> > > > > >         git remote add linux-review
> > > > > > https://github.com/intel-lab-lkp/linux
> > > > > >         git fetch --no-tags linux-review James-Bottomley/tpm-
> > > > > > move-
> > > > > > buffer-handling-from-static-inlines-to-real-functions/20230125-
> > > > > > 020146
> > > > > >         git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> > > > > >         # save the config file
> > > > > >         mkdir build_dir && cp config build_dir/.config
> > > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > > > > > make.cross W=1 O=build_dir ARCH=arc olddefconfig
> > > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > > > > > make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> > > > > > drivers/char/tpm/
> > > > > >
> > > > > > If you fix the issue, kindly add following tag where applicable
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > >
> > > > > > All warnings (new ones prefixed by >>):
> > > > > >
> > > > > >    drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no
> > > > > > previous
> > > > > > prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
> > > > > >     1184 | int tpm2_create_null_primary(struct tpm_chip *chip)
> > > > > > {
> > > > > >          |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > > > > 'tpm_buf_check_hmac_response':
> > > > > > > > drivers/char/tpm/tpm2-sessions.c:831:1: warning: the frame
> > > > > > > > size
> > > > > > > > of 1132 bytes is larger than 1024 bytes [-Wframe-larger-
> > > > > > > > than=]
> > > > > >      831 | }
> > > > > >          | ^
> > > > > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > > > > 'tpm_buf_fill_hmac_session':
> > > > > >    drivers/char/tpm/tpm2-sessions.c:579:1: warning: the frame
> > > > > > size of
> > > > > > 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > > > >      579 | }
> > > > > >          | ^
> > > > >
> > > > > Is this a test problem?  I can't see why the code would only blow
> > > > > the
> > > > > stack on the arc architecture and not on any other ... does it
> > > > > have
> > > > > something funny with on stack crypto structures?
> > > >
> > > > This warning is controlled by the value of CONFIG_FRAME_WARN.
> > > >
> > > > For "make ARCH=arc allyesconfig", the default value is 1024, so
> > > > this frame warning shows up during the build.
> > > >
> > > > For other arch such as "make ARCH=x86_64 allyesconfig", the default
> > > > value would be 2048 and won't have this warning.
> > > >
> > > > Not sure if this is a real problem that need to be fixed, here just
> > > > providing above information for your reference.
> > > >
> > > > --
> > > > Best Regards,
> > > > Yujie
> > >
> > > *Must* be fixed given that it is how the default value is set now.
> > > This is wrong place to reconsider.
> > >
> > >
> > > And we do not want to add functions that bloat the stack this way.
> > >
> > > Shash just needs to be allocated from heap instead of stack.
> >
> > On x86_64 the stack usage is measured at 984 bytes, so rather than
> > jumping to conclusions let's root cause why this is a problem only on
> > the arc architecture.  I suspect it's something to do with the
> > alignment constraints of shash.  I've also noted it shouldn't actually
> > warn on arc because the default stack warning size there should be 2048
> > (like x86_64).
>
> Would it such a big deal to allocate shash from heap? That would
> be IMHO more robust in the end.
>

Can we avoid shashes and sync skciphers at all? We have sha256 and AES
library routines these days, and AES in CFB mode seems like a good
candidate for a library implementation as well - it uses AES
encryption only, and is quite straight forward to implement. [0]

The crypto API is far too clunky for synchronous operations of
algorithms that are known at compile time, and the requirement to use
scatterlists for skciphers is especially horrid.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=crypto-aes-cfb-library
