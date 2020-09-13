Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734B526806B
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Sep 2020 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMRC4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Sep 2020 13:02:56 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36714 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgIMRCy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Sep 2020 13:02:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EC7478EE1A9;
        Sun, 13 Sep 2020 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600016573;
        bh=vsXWRvMdqMLupEOYqmL3r9IK4yLkpWbDyXhGnuIB4YA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dO2tH/ayUjrxy0KdDi52FbIhK7LZBk81ouCTEbKJguMrAAnn/am+l87CoJhHcZyD2
         8Eh4lmRn+4ujtMwDvFKUu5Zb550JhQ7s4CH/sXLn0oZo2Ma0EY86eE4/zbpapVlVdP
         RsX1VB9iaQpnx85K3f6QSyrXpJ1US7mdZxBEY0u0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XRQm0a_uTo_g; Sun, 13 Sep 2020 10:02:52 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2C15E8EE0F5;
        Sun, 13 Sep 2020 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1600016572;
        bh=vsXWRvMdqMLupEOYqmL3r9IK4yLkpWbDyXhGnuIB4YA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cwnhhDvyCVgnLn7JV9nLtN509wLBLPmxLU8/yFn0DRMAO3IBrAN3kn993RYvDlmMx
         EOPyKS3Qb+KOa7wIlKAO6JHgxKQeCAPLWwO6qcCcl7PrphfGUrh+F/x1sW2wYloevd
         n9lE2cZlafpBchc6naT6DrJAeD6KpTQz3/TNzSds=
Message-ID: <1600016571.7833.9.camel@HansenPartnership.com>
Subject: Re: [PATCH v11 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Sun, 13 Sep 2020 10:02:51 -0700
In-Reply-To: <202009131413.8dt8QEc8%lkp@intel.com>
References: <20200912172643.9063-5-James.Bottomley@HansenPartnership.com>
         <202009131413.8dt8QEc8%lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-09-13 at 14:26 +0800, kernel test robot wrote:
> Hi James,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on integrity/next-integrity]
> [also build test ERROR on linus/master v5.9-rc4 next-20200911]
> [cannot apply to security/next-testing dhowells-fs/fscache-next]
> [If your patch is applied to the wrong git tree, kindly drop us a
> note.
> And when submitting patch, we suggest to use '--base' as documented
> in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/James-Bottomley/TPM-
> 2-0-trusted-key-rework/20200913-013201
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-i
> ntegrity.git next-integrity
> config: arm-randconfig-r013-20200913 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project
> 3170d54842655d6d936aae32b7d0bc92fce7f22e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master
> /sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> > > security/keys/trusted-keys/trusted_tpm2.c:19:10: fatal error:
> > > 'tpm2key.asn1.h' file not found
> 
>    #include "tpm2key.asn1.h"
>             ^~~~~~~~~~~~~~~~
>    1 error generated.

Do you have the actual build log for this?  On x86 the build process
builds any precursors first, which is the tpm2key.asn1.o, which
generates that header file, so we see:

  ASN.1   security/keys/trusted-keys/tpm2key.asn1.[ch]
  CC [M]  security/keys/trusted-keys/trusted_tpm2.o
  CC [M]  security/keys/trusted-keys/tpm2-policy.o
  CC [M]  security/keys/trusted-keys/tpm2key.asn1.o
  LD [M]  security/keys/trusted-keys/trusted.o

Is ARM doing a lazier version of that?  In which case the fix might be
to move trusted_tpm2.o to after tpm2key.asn1.o in the Makefile, this
line:

trusted-y += trusted_tpm2.o tpm2key.asn1.o

James

