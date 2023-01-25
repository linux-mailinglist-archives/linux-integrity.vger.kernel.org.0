Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA067B3C9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 15:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbjAYOB5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 09:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjAYOB4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 09:01:56 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10A46167;
        Wed, 25 Jan 2023 06:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674655315;
        bh=mOb5g9Y6fpziO8sZahIkRFgvrUxahBGEJYC92LSBRUQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cw/5flAwvjyXclH1HnW04plVsCkM7xHH59NQ/1KeyhV7uGnsPo33ethpG7IQLAuHw
         +xq3MUJcOHgEKpROI/2JygkUuF0zZC4+08WHqmjyRHJ/wpB3VYux0xdQPEq7CzKvkI
         Ac3h0lKDTqye55CyIhtrCFMkxkdPAuK7riD3evCE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 170A11286199;
        Wed, 25 Jan 2023 09:01:55 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T3KzLZZsZejS; Wed, 25 Jan 2023 09:01:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674655314;
        bh=mOb5g9Y6fpziO8sZahIkRFgvrUxahBGEJYC92LSBRUQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pqaz8dlsw2Gjw+sVezF9iVZVJITI5Wb9Y1nxlPIlOZNtjEYZVnmYfb+SCH3SAZvwm
         wlxE3SAxfppcF6KXRj0c2d6aowUnmz24azJirsBrMX+ktWM1XnWCQxfkeb1whDV6Fl
         /W6TrdMhJRf0Fhvam9rVQ1E2Mb2J7VNw9wMk2Hy4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3BC9A1286141;
        Wed, 25 Jan 2023 09:01:54 -0500 (EST)
Message-ID: <0c69d737684c5b1232090c1a501198852bf15b9c.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 01/11] tpm: move buffer handling from static inlines
 to real functions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Jan 2023 09:01:52 -0500
In-Reply-To: <202301250315.ZgtsNzSm-lkp@intel.com>
References: <20230124175516.5984-2-James.Bottomley@HansenPartnership.com>
         <202301250315.ZgtsNzSm-lkp@intel.com>
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

On Wed, 2023-01-25 at 03:57 +0800, kernel test robot wrote:
> Hi James,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on char-misc/char-misc-testing]
> [also build test WARNING on char-misc/char-misc-next char-misc/char-
> misc-linus zohar-integrity/next-integrity linus/master v6.2-rc5 next-
> 20230124]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:   
> https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
> patch link:   
> https://lore.kernel.org/r/20230124175516.5984-2-James.Bottomley%40HansenPartnership.com
> patch subject: [PATCH v2 01/11] tpm: move buffer handling from static
> inlines to real functions
> config: sparc-allyesconfig
> (https://download.01.org/0day-ci/archive/20230125/202301250315.ZgtsNz
> Sm-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://github.com/intel-lab-lkp/linux/commit/484b879d0bfceec899fea147a76d12f7072d9f23
>         git remote add linux-review
> https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review James-Bottomley/tpm-move-
> buffer-handling-from-static-inlines-to-real-functions/20230125-020146
>         git checkout 484b879d0bfceec899fea147a76d12f7072d9f23
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> make.cross W=1 O=build_dir ARCH=sparc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash
> drivers/char/tpm/
> 
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> > > drivers/char/tpm/tpm-buf.c:46:5: warning: no previous prototype
> > > for 'tpm_buf_tag' [-Wmissing-prototypes]
>       46 | u16 tpm_buf_tag(struct tpm_buf *buf)
>          |     ^~~~~~~~~~~


This looks like an initial header got missed in the code motion. 
However, the fact that nothing broke shows that tpm_buf_tag isn't used
outside of the tpm-buf.c functions, so I think I can make it static to
them.

James

