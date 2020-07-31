Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AC234CAA
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGaVG4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 17:06:56 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37454 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgGaVG4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 17:06:56 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7E52D72CCDC;
        Sat,  1 Aug 2020 00:06:53 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 454DC4A4AE7;
        Sat,  1 Aug 2020 00:06:53 +0300 (MSK)
Date:   Sat, 1 Aug 2020 00:06:53 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200731210653.p5m4efy52melqwgs@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
 <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
 <20200731204044.GC27841@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200731204044.GC27841@dell5510>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 31, 2020 at 10:40:44PM +0200, Petr Vorel wrote:
> And when using suggested branch openssl_1_1_0, it also fails on make install
> $ ./tests/install-gost-engine.sh
> OpenSSL 1.1.1g  21 Apr 2020
> Cloning into 'engine'...
> remote: Enumerating objects: 63, done.
> remote: Counting objects: 100% (63/63), done.
> remote: Compressing objects: 100% (40/40), done.
> remote: Total 2738 (delta 33), reused 32 (delta 21), pack-reused 2675
> Receiving objects: 100% (2738/2738), 2.48 MiB | 2.09 MiB/s, done.
> Resolving deltas: 100% (1735/1735), done.
> -- The C compiler identification is GNU 10.1.1
> -- Detecting C compiler ABI info
> -- Detecting C compiler ABI info - done
> -- Check for working C compiler: /usr/bin/cc - skipped
> -- Detecting C compile features
> -- Detecting C compile features - done
> -- Found OpenSSL: /usr/lib64/libcrypto.so (found suitable version "1.1.1g", minimum required is "1.1")
> -- Check if the system is big endian
> -- Searching 16 bit integer
> -- Looking for sys/types.h
> -- Looking for sys/types.h - found
> -- Looking for stdint.h
> -- Looking for stdint.h - found
> -- Looking for stddef.h
> -- Looking for stddef.h - found
> -- Check size of unsigned short
> -- Check size of unsigned short - done
> -- Searching 16 bit integer - Using unsigned short
> -- Check if the system is big endian - little endian
> -- LITTLE_ENDIAN
> -- Configuring done
> -- Generating done
> -- Build files have been written to: /home/pvorel/install/src/ima-evm-utils.git/engine
> make: *** No rule to make target 'install'.  Stop.

It seems this branch does not have install target. I think,

- `engine/bin/gost.so` should be moved in platform dependent engines dir,
for example for debian9 it's `/usr/lib/x86_64-linux-gnu/engines-1.1/`
(found with strace).

- Or, just keep it as is, but `OPENSSL_ENGINES` env should be set to
`/home/pvorel/install/src/ima-evm-utils.git/engine/bin/`.

- Or even better, Bionic (which is supported by Travis) should have
  gost-engine already in the libengine-gost-openssl1.1 package.

  In that case `.travis.yml` should have `dist: bionic`.
    https://docs.travis-ci.com/user/reference/bionic/



> 
> => It'd be good to fix this and add some test with SSL=openssl variable.
> But the branch would have to be updated time to time.
> 
> BTW do you plan to test other crypto libraries?
> 
> Kind regards,
> Petr
