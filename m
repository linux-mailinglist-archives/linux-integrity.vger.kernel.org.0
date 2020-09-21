Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1F2734F3
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Sep 2020 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgIUVbj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Sep 2020 17:31:39 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54318 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbgIUVbj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Sep 2020 17:31:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 28CF98EE194;
        Mon, 21 Sep 2020 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600723898;
        bh=p71+JgwogRw2iWBePs1UqpzC6HsL3jZwWKcEVepmafM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m5Kqn221FR1QojQGaBtPCoMX2hqNotE/7zL8eXFlbxBQG0fWSzH8VQowQa8jDMBim
         q6ZxAm0f2wF2qIjsxdrw3O2lAqKFtkk3lkh5ubT1+K+5zVqUDqR5axiR/WOyntP2HJ
         Iv887jWTqBqH/Zi5lz/kQ/sr2MI+BAIgNbAGJo4U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1_w9Ny52yK9i; Mon, 21 Sep 2020 14:31:38 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 646D98EE0CF;
        Mon, 21 Sep 2020 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600723897;
        bh=p71+JgwogRw2iWBePs1UqpzC6HsL3jZwWKcEVepmafM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JDpWeIg5o4b9DBD3Yw3ssI27FTff850qKtncQxRSzCCijldxpJVTvz9wUtOFrj14Y
         zRRFtt7c3z6oPss/a1nsPWxXSO8fsdtpLXd4719IinCB5H6CMEXaPL8g+SoIISkLIL
         5tqdnn3G702XphduMzURi7OCBex6JOe/0fUhYdfY=
Message-ID: <2d395d924b70fba7f1867eb83946497ce1f6eb47.camel@HansenPartnership.com>
Subject: Re: [PATCH v12 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Mon, 21 Sep 2020 14:31:35 -0700
In-Reply-To: <202009210844.KCwzdqmx%lkp@intel.com>
References: <20200920163351.11293-5-James.Bottomley@HansenPartnership.com>
         <202009210844.KCwzdqmx%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-21 at 08:07 +0800, kernel test robot wrote:
> Hi James,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on integrity/next-integrity]
> [also build test ERROR on linus/master v5.9-rc5 next-20200918]
> [cannot apply to security/next-testing dhowells-fs/fscache-next]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note. And when submitting patch, we suggest to use '--base' as
> documented in https://git-scm.com/docs/git-format-patch]
> 
> url:    
> https://github.com/0day-ci/linux/commits/James-Bottomley/TPM-2-0-trusted-key-rework/20200921-003922
> base:   
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> next-integrity
> config: x86_64-randconfig-a003-20200921 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project
> f4e554180962aa6bc93678898b6933ea712bde50)
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> > > make[4]: *** No rule to make target 'security/keys/trusted-
> > > keys/tpm2key.asn1.o', needed by 'security/keys/trusted-
> > > keys/built-in.a'.
>    make[4]: *** [scripts/Makefile.build:283: security/keys/trusted-
> keys/trusted_tpm2.o] Error 1
>    make[4]: Target '__build' not remade because of errors.


So can I still add that tracking this down involved installing an
entirely unnecessary ARM build environment, which was a huge effort I
didn't need to do if you'd just provided the build log which fingered
the ASN.1 compiler problem if you know what to look for.

The reason for the problem is because ASN1 isn't selected in the
Kconfig which causes the ASN.1 compiler not to be built.  The way our
current build rules are structured causes the make rule for this simply
to be skipped, which means you have to know to look for the absence of
ASN.1 in the build log.  I propose adding this to the build rules,
which produces the much more explicit:

/home/jejb/git/linux-build/scripts/Makefile.build:387: *** CONFIG_ASN1 must be defined for the asn1_compiler.  Stop.
make[3]: *** [/home/jejb/git/linux-build/scripts/Makefile.build:505: security/keys/trusted-keys] Error 2

James

---

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a467b9323442..bca7003beac8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -382,6 +382,11 @@ quiet_cmd_asn1_compiler = ASN.1   $(basename $@).[ch]
       cmd_asn1_compiler = $(objtree)/scripts/asn1_compiler $< \
 				$(basename $@).c $(basename $@).h
 
+ifndef CONFIG_ASN1
+$(objtree)/scripts/asn1_compiler:
+	$(error CONFIG_ASN1 must be defined for the asn1_compiler)
+endif
+
 $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 	$(call cmd,asn1_compiler)
 

