Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A7767B2CF
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 13:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjAYM7X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 07:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAYM7W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 07:59:22 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B38360BC;
        Wed, 25 Jan 2023 04:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674651557;
        bh=1h3KVU06lOoLOdYsLnIUqpA3XQTq9kVXFFNylvoJSj4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=fLl7cZctumr8AVdN7FmYgB13dp34nE9HVcbzGxjc82nv4AaSZ9Mk/tuyz9rLFq2Ca
         hgl4o4Pm61VsA8fF6CKqrQS+JgiWQ5cWZ3Whw53pw/lhE/qxlczQtpXwkSkhiyjE5F
         1coOIgSs7XLle+cEOuDkhn/D2uCIbtnkFibEWASk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C4FF81285D02;
        Wed, 25 Jan 2023 07:59:17 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U2IzwpUjJlAo; Wed, 25 Jan 2023 07:59:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674651556;
        bh=1h3KVU06lOoLOdYsLnIUqpA3XQTq9kVXFFNylvoJSj4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=KHrbss3JSFUfsu551V5G8E4NYE+iqjoAF+X6M/wwKXS5p99pQQ6ct8GC0ENn7tCVG
         SOnz1dlwGMPXlYzoSo1DoH85M7FbgkU+y2ZxYq5to0O5mEwzj8e0TIrQoRXvyJFdY+
         RSDI2z8Jky+cBYk7wbj53LHuKzukoP2j4Rjae954=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D87361281E04;
        Wed, 25 Jan 2023 07:59:15 -0500 (EST)
Message-ID: <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 25 Jan 2023 07:59:09 -0500
In-Reply-To: <202301250706.deGvd0yq-lkp@intel.com>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
         <202301250706.deGvd0yq-lkp@intel.com>
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

On Wed, 2023-01-25 at 07:11 +0800, kernel test robot wrote:
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
> https://lore.kernel.org/r/20230124175516.5984-7-James.Bottomley%40HansenPartnership.com
> patch subject: [PATCH v2 06/11] tpm: Add full HMAC and
> encrypt/decrypt session handling code
> config: arc-allyesconfig
> (https://download.01.org/0day-ci/archive/20230125/202301250706.deGvd0
> yq-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
>  -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
>         git remote add linux-review
> https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review James-Bottomley/tpm-move-
> buffer-handling-from-static-inlines-to-real-functions/20230125-020146
>         git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> make.cross W=1 O=build_dir ARCH=arc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/tpm/
> 
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no previous
> prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
>     1184 | int tpm2_create_null_primary(struct tpm_chip *chip) {
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/char/tpm/tpm2-sessions.c: In function
> 'tpm_buf_check_hmac_response':
> > > drivers/char/tpm/tpm2-sessions.c:831:1: warning: the frame size
> > > of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      831 | }
>          | ^
>    drivers/char/tpm/tpm2-sessions.c: In function
> 'tpm_buf_fill_hmac_session':
>    drivers/char/tpm/tpm2-sessions.c:579:1: warning: the frame size of
> 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>      579 | }
>          | ^

Is this a test problem?  I can't see why the code would only blow the
stack on the arc architecture and not on any other ... does it have
something funny with on stack crypto structures?

James

