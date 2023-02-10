Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2A692121
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjBJOsZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 09:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjBJOsY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 09:48:24 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135AA17CE9;
        Fri, 10 Feb 2023 06:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676040501;
        bh=A77B3s1s57hm488iE4tG38i+br5yKIVtB7DrfmZz48o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Mw/7h1OGDw7PgRqqQYvM7HXX4/eCQjSudYX0NzvLq7Bh7BPaNhb8SByg48h3hIJws
         nTujJ3aI1GySKvt6FXs2DAJ86Y5CZIX0S2Do1SsbT428qnxVVXLJSaLl8Ll8eaBwXx
         p4ZKv1LwsQy9rzXYlXUhGxq19kKdgdW6SnHVe7NA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7F2941280DC4;
        Fri, 10 Feb 2023 09:48:21 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ibrNE9Rqax4R; Fri, 10 Feb 2023 09:48:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1676040501;
        bh=A77B3s1s57hm488iE4tG38i+br5yKIVtB7DrfmZz48o=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Mw/7h1OGDw7PgRqqQYvM7HXX4/eCQjSudYX0NzvLq7Bh7BPaNhb8SByg48h3hIJws
         nTujJ3aI1GySKvt6FXs2DAJ86Y5CZIX0S2Do1SsbT428qnxVVXLJSaLl8Ll8eaBwXx
         p4ZKv1LwsQy9rzXYlXUhGxq19kKdgdW6SnHVe7NA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AA4C11285D21;
        Fri, 10 Feb 2023 09:48:19 -0500 (EST)
Message-ID: <3109ff421139af6b0d9e66a06d8399135e546fa7.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Yujie Liu <yujie.liu@intel.com>
Cc:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Feb 2023 09:48:15 -0500
In-Reply-To: <Y+MNxmzlILarAlZA@kernel.org>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
         <202301250706.deGvd0yq-lkp@intel.com>
         <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
         <Y9ykeASyzhSKQCmx@yujie-X299> <Y+MNxmzlILarAlZA@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-02-08 at 04:49 +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 03, 2023 at 02:06:48PM +0800, Yujie Liu wrote:
> > Hi James,
> > 
> > On Wed, Jan 25, 2023 at 07:59:09AM -0500, James Bottomley wrote:
> > > On Wed, 2023-01-25 at 07:11 +0800, kernel test robot wrote:
> > > > Hi James,
> > > > 
> > > > I love your patch! Perhaps something to improve:
> > > > 
> > > > [auto build test WARNING on char-misc/char-misc-testing]
> > > > [also build test WARNING on char-misc/char-misc-next char-
> > > > misc/char-
> > > > misc-linus zohar-integrity/next-integrity linus/master v6.2-rc5
> > > > next-
> > > > 20230124]
> > > > [If your patch is applied to the wrong git tree, kindly drop us
> > > > a
> > > > note.
> > > > And when submitting patch, we suggest to use '--base' as
> > > > documented
> > > > in
> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information
> > > > ]
> > > > 
> > > > url:   
> > > > https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
> > > > patch link:   
> > > > https://lore.kernel.org/r/20230124175516.5984-7-James.Bottomley%40HansenPartnership.com
> > > > patch subject: [PATCH v2 06/11] tpm: Add full HMAC and
> > > > encrypt/decrypt session handling code
> > > > config: arc-allyesconfig
> > > > (
> > > > https://download.01.org/0day-ci/archive/20230125/202301250706.de
> > > > Gvd0
> > > > yq-lkp@intel.com/config)
> > > > compiler: arceb-elf-gcc (GCC) 12.1.0
> > > > reproduce (this is a W=1 build):
> > > >         wget
> > > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > >  -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         #
> > > > https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> > > >         git remote add linux-review
> > > > https://github.com/intel-lab-lkp/linux
> > > >         git fetch --no-tags linux-review James-Bottomley/tpm-
> > > > move-
> > > > buffer-handling-from-static-inlines-to-real-functions/20230125-
> > > > 020146
> > > >         git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > > > make.cross W=1 O=build_dir ARCH=arc olddefconfig
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > > > make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash
> > > > drivers/char/tpm/
> > > > 
> > > > If you fix the issue, kindly add following tag where applicable
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All warnings (new ones prefixed by >>):
> > > > 
> > > >    drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no
> > > > previous
> > > > prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
> > > >     1184 | int tpm2_create_null_primary(struct tpm_chip *chip)
> > > > {
> > > >          |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > > 'tpm_buf_check_hmac_response':
> > > > > > drivers/char/tpm/tpm2-sessions.c:831:1: warning: the frame
> > > > > > size
> > > > > > of 1132 bytes is larger than 1024 bytes [-Wframe-larger-
> > > > > > than=]
> > > >      831 | }
> > > >          | ^
> > > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > > 'tpm_buf_fill_hmac_session':
> > > >    drivers/char/tpm/tpm2-sessions.c:579:1: warning: the frame
> > > > size of
> > > > 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > >      579 | }
> > > >          | ^
> > > 
> > > Is this a test problem?  I can't see why the code would only blow
> > > the
> > > stack on the arc architecture and not on any other ... does it
> > > have
> > > something funny with on stack crypto structures?
> > 
> > This warning is controlled by the value of CONFIG_FRAME_WARN.
> > 
> > For "make ARCH=arc allyesconfig", the default value is 1024, so
> > this frame warning shows up during the build.
> > 
> > For other arch such as "make ARCH=x86_64 allyesconfig", the default
> > value would be 2048 and won't have this warning.
> > 
> > Not sure if this is a real problem that need to be fixed, here just
> > providing above information for your reference.
> > 
> > --
> > Best Regards,
> > Yujie
> 
> *Must* be fixed given that it is how the default value is set now.
> This is wrong place to reconsider.
>
> 
> And we do not want to add functions that bloat the stack this way.
> 
> Shash just needs to be allocated from heap instead of stack.

On x86_64 the stack usage is measured at 984 bytes, so rather than
jumping to conclusions let's root cause why this is a problem only on
the arc architecture.  I suspect it's something to do with the
alignment constraints of shash.  I've also noted it shouldn't actually
warn on arc because the default stack warning size there should be 2048
(like x86_64).

James

