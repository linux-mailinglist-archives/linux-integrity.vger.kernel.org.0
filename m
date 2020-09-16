Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8521226CD5D
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Sep 2020 22:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIPU6f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Sep 2020 16:58:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:22936 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgIPQbi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Sep 2020 12:31:38 -0400
IronPort-SDR: Y/0A2LAR0GMjMATsNnqZ0D+rst8Zi4zlHJHt6Wr3fsoMjggmncasDP90Y5ShmHTRbo1e8SPdST
 D4kV4bIH5zYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="147262150"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="147262150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 09:27:12 -0700
IronPort-SDR: FIvyFKROnFtuDNmzXBPU2pkeO2gEwzdrYXSM4ShGzRB7hBNa/xHIaQcRReX9XCcvsyWY2w0IVi
 PNHGWT3xW+nQ==
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="451920217"
Received: from scusackx-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.45.87])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 09:27:09 -0700
Date:   Wed, 16 Sep 2020 19:27:07 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        kernel test robot <lkp@intel.com>,
        linux-integrity@vger.kernel.org, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v11 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <20200916162707.GF21026@linux.intel.com>
References: <20200912172643.9063-5-James.Bottomley@HansenPartnership.com>
 <202009131413.8dt8QEc8%lkp@intel.com>
 <1600016571.7833.9.camel@HansenPartnership.com>
 <20200915091140.GC3612@linux.intel.com>
 <CAKwvOdnDJKPJ__sVKX2HmLUWyNPo=b0ccLvyBLyWoFfC0EFkiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnDJKPJ__sVKX2HmLUWyNPo=b0ccLvyBLyWoFfC0EFkiA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 15, 2020 at 01:20:20PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 15, 2020 at 2:11 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Sun, Sep 13, 2020 at 10:02:51AM -0700, James Bottomley wrote:
> > > On Sun, 2020-09-13 at 14:26 +0800, kernel test robot wrote:
> > > > Hi James,
> > > >
> > > > I love your patch! Yet something to improve:
> > > >
> > > > [auto build test ERROR on integrity/next-integrity]
> > > > [also build test ERROR on linus/master v5.9-rc4 next-20200911]
> > > > [cannot apply to security/next-testing dhowells-fs/fscache-next]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a
> > > > note.
> > > > And when submitting patch, we suggest to use '--base' as documented
> > > > in
> > > > https://git-scm.com/docs/git-format-patch]
> > > >
> > > > url:    https://github.com/0day-ci/linux/commits/James-Bottomley/TPM-
> > > > 2-0-trusted-key-rework/20200913-013201
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-i
> > > > ntegrity.git next-integrity
> > > > config: arm-randconfig-r013-20200913 (attached as .config)
> 
> arm-randconfig ^  You'll need to download and gunzip then use the config file.
> 
> > > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project
> > > > 3170d54842655d6d936aae32b7d0bc92fce7f22e)
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master
> > > > /sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # install arm cross compiling tool for clang build
> > > >         # apt-get install binutils-arm-linux-gnueabi
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross
> > > > ARCH=arm
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > > > > security/keys/trusted-keys/trusted_tpm2.c:19:10: fatal error:
> > > > > > 'tpm2key.asn1.h' file not found
> > > >
> > > >    #include "tpm2key.asn1.h"
> > > >             ^~~~~~~~~~~~~~~~
> > > >    1 error generated.
> > >
> > > Do you have the actual build log for this?  On x86 the build process
> > > builds any precursors first, which is the tpm2key.asn1.o, which
> > > generates that header file, so we see:
> > >
> > >   ASN.1   security/keys/trusted-keys/tpm2key.asn1.[ch]
> > >   CC [M]  security/keys/trusted-keys/trusted_tpm2.o
> > >   CC [M]  security/keys/trusted-keys/tpm2-policy.o
> > >   CC [M]  security/keys/trusted-keys/tpm2key.asn1.o
> > >   LD [M]  security/keys/trusted-keys/trusted.o
> > >
> > > Is ARM doing a lazier version of that?  In which case the fix might be
> > > to move trusted_tpm2.o to after tpm2key.asn1.o in the Makefile, this
> > > line:
> > >
> > > trusted-y += trusted_tpm2.o tpm2key.asn1.o
> > >
> > > James
> >
> > You can try to reproduce the arm build with BuildRoot. That's what I
> > usually do when bumping something like this with arm.
> 
> You shouldn't need buildroot for build failures (we use buildroot, for
> boot testing).
> 
> For an arm build, you should be able to cross compile with:
> $ ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make CC=clang -j
> 
> (You can try without CC=clang first, may not be clang specific)
> (You should install arm-linux-gnueabihf-gcc and the same for binutils.
> Some distros have separate target triples without `hf` in them; either
> should be fine for the kernel as long as your invocation of make
> matches what you have installed).
> -- 
> Thanks,
> ~Nick Desaulniers

Hmm... How do I get a cross compiler in the first place for ARM?
I use BuildRoot just to get the cross compile chain.

The compiler that you use in your example is unfortunately not
preincluded to my Ubuntu installation...

/Jarkko
