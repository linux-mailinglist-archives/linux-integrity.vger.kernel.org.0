Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452E368E644
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Feb 2023 03:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBHCtx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Feb 2023 21:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBHCtw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Feb 2023 21:49:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251803A5B4;
        Tue,  7 Feb 2023 18:49:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2720B816D4;
        Wed,  8 Feb 2023 02:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596ACC433EF;
        Wed,  8 Feb 2023 02:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675824588;
        bh=knypg8koZd0Cab7ZNIquVYoIC2yiDFKnUF5sBSze0OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ln6SE7qKLNlCxURgnFWS2pz87VmUxsTJFUVDy9axapk9r8gmn+7/btmDOXzpUphLH
         uJgLIs/klzPh33IX2kyB839ee9/+AZWdocpIFJxkEt9kH9NSG4NYi4YRVjQLqviuaJ
         9cUegj+Q8x1UXEPSUW+Q8ybVwTH7B8gK6qNGLQF+41lMwxd1iLMndTB1JtRN9/fCx1
         VMpKTOA3sL5wjs4V2QiKB+jbLNhz4mmJbyt27VTnh0gcKe4DQYl48IJGpx5k5xEd5g
         j+gpWN8pDlGCo9NAA4f/jbYBxUmgB2lqTJ8Jz5RFP4ATii37XMh3d7EbZwf1ctuQ3U
         OZFG7qEKyHIZg==
Date:   Wed, 8 Feb 2023 04:49:42 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        kernel test robot <lkp@intel.com>,
        linux-integrity@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <Y+MNxmzlILarAlZA@kernel.org>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
 <202301250706.deGvd0yq-lkp@intel.com>
 <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
 <Y9ykeASyzhSKQCmx@yujie-X299>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9ykeASyzhSKQCmx@yujie-X299>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 03, 2023 at 02:06:48PM +0800, Yujie Liu wrote:
> Hi James,
> 
> On Wed, Jan 25, 2023 at 07:59:09AM -0500, James Bottomley wrote:
> > On Wed, 2023-01-25 at 07:11 +0800, kernel test robot wrote:
> > > Hi James,
> > > 
> > > I love your patch! Perhaps something to improve:
> > > 
> > > [auto build test WARNING on char-misc/char-misc-testing]
> > > [also build test WARNING on char-misc/char-misc-next char-misc/char-
> > > misc-linus zohar-integrity/next-integrity linus/master v6.2-rc5 next-
> > > 20230124]
> > > [If your patch is applied to the wrong git tree, kindly drop us a
> > > note.
> > > And when submitting patch, we suggest to use '--base' as documented
> > > in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:   
> > > https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
> > > patch link:   
> > > https://lore.kernel.org/r/20230124175516.5984-7-James.Bottomley%40HansenPartnership.com
> > > patch subject: [PATCH v2 06/11] tpm: Add full HMAC and
> > > encrypt/decrypt session handling code
> > > config: arc-allyesconfig
> > > (https://download.01.org/0day-ci/archive/20230125/202301250706.deGvd0
> > > yq-lkp@intel.com/config)
> > > compiler: arceb-elf-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > >  -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         #
> > > https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> > >         git remote add linux-review
> > > https://github.com/intel-lab-lkp/linux
> > >         git fetch --no-tags linux-review James-Bottomley/tpm-move-
> > > buffer-handling-from-static-inlines-to-real-functions/20230125-020146
> > >         git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > > make.cross W=1 O=build_dir ARCH=arc olddefconfig
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > > make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/tpm/
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >    drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no previous
> > > prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
> > >     1184 | int tpm2_create_null_primary(struct tpm_chip *chip) {
> > >          |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > 'tpm_buf_check_hmac_response':
> > > > > drivers/char/tpm/tpm2-sessions.c:831:1: warning: the frame size
> > > > > of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > >      831 | }
> > >          | ^
> > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > 'tpm_buf_fill_hmac_session':
> > >    drivers/char/tpm/tpm2-sessions.c:579:1: warning: the frame size of
> > > 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > >      579 | }
> > >          | ^
> > 
> > Is this a test problem?  I can't see why the code would only blow the
> > stack on the arc architecture and not on any other ... does it have
> > something funny with on stack crypto structures?
> 
> This warning is controlled by the value of CONFIG_FRAME_WARN.
> 
> For "make ARCH=arc allyesconfig", the default value is 1024, so this
> frame warning shows up during the build.
> 
> For other arch such as "make ARCH=x86_64 allyesconfig", the default
> value would be 2048 and won't have this warning.
> 
> Not sure if this is a real problem that need to be fixed, here just
> providing above information for your reference.
> 
> --
> Best Regards,
> Yujie

*Must* be fixed given that it is how the default value is set now. This
is wrong place to reconsider.

And we do not want to add functions that bloat the stack this way.

Shash just needs to be allocated from heap instead of stack.

BR, Jarkko
