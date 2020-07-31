Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFB234C64
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 22:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgGaUks (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 16:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgGaUkr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 16:40:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 433BCAF2D;
        Fri, 31 Jul 2020 20:40:59 +0000 (UTC)
Date:   Fri, 31 Jul 2020 22:40:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200731204044.GC27841@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
 <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Petr,

> On Fri, Jul 31, 2020 at 10:18:08PM +0200, Petr Vorel wrote:
> > > > +++ b/tests/install-gost-engine.sh
> > > > @@ -0,0 +1,10 @@
> > > > +#!/bin/sh
> > > > +
> > > > +openssl version
> > > > +
> > > > +git clone https://github.com/gost-engine/engine.git

> > > gost-engine master branch corresponds to openssl-3.0 which is probably
> > > not on Travis systems yet. I think branch `openssl_1_1_0` should be used.

> > >   git clone --branch openssl_1_1_0 https://github.com/gost-engine/engine.git

> > FYI: it work on current setup.
> > https://travis-ci.org/github/pevik/ima-evm-utils/builds/713815774

> I think `install-gost-engine.sh` is not executed in this line:

>   257 $ if [ "${SSL}" = "openssl" ]; then ./tests/install-gost-engine.sh; openssl version; fi   0.00s

Good catch!
$ ./tests/install-gost-engine.sh
OpenSSL 1.1.1g  21 Apr 2020
fatal: destination path 'engine' already exists and is not an empty directory.
CMake Error at /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:165 (message):
  Could NOT find OpenSSL, try to set the path to OpenSSL root folder in the
  system variable OPENSSL_ROOT_DIR: Found unsuitable version "1.1.1g", but
  required is at least "3.0" (found /usr/lib64/libcrypto.so, )
Call Stack (most recent call first):
  /usr/share/cmake/Modules/FindPackageHandleStandardArgs.cmake:456 (_FPHSA_FAILURE_MESSAGE)
  /usr/share/cmake/Modules/FindOpenSSL.cmake:486 (find_package_handle_standard_args)
  CMakeLists.txt:11 (find_package)

-- Configuring incomplete, errors occurred!
See also "/home/pvorel/install/src/ima-evm-utils.git/engine/CMakeFiles/CMakeOutput.log".
make: *** No rule to make target 'install'.  Stop.

And when using suggested branch openssl_1_1_0, it also fails on make install
$ ./tests/install-gost-engine.sh
OpenSSL 1.1.1g  21 Apr 2020
Cloning into 'engine'...
remote: Enumerating objects: 63, done.
remote: Counting objects: 100% (63/63), done.
remote: Compressing objects: 100% (40/40), done.
remote: Total 2738 (delta 33), reused 32 (delta 21), pack-reused 2675
Receiving objects: 100% (2738/2738), 2.48 MiB | 2.09 MiB/s, done.
Resolving deltas: 100% (1735/1735), done.
-- The C compiler identification is GNU 10.1.1
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Found OpenSSL: /usr/lib64/libcrypto.so (found suitable version "1.1.1g", minimum required is "1.1")
-- Check if the system is big endian
-- Searching 16 bit integer
-- Looking for sys/types.h
-- Looking for sys/types.h - found
-- Looking for stdint.h
-- Looking for stdint.h - found
-- Looking for stddef.h
-- Looking for stddef.h - found
-- Check size of unsigned short
-- Check size of unsigned short - done
-- Searching 16 bit integer - Using unsigned short
-- Check if the system is big endian - little endian
-- LITTLE_ENDIAN
-- Configuring done
-- Generating done
-- Build files have been written to: /home/pvorel/install/src/ima-evm-utils.git/engine
make: *** No rule to make target 'install'.  Stop.

=> It'd be good to fix this and add some test with SSL=openssl variable.
But the branch would have to be updated time to time.

BTW do you plan to test other crypto libraries?

Kind regards,
Petr
