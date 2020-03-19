Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9317418BB93
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 16:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCSPuB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 11:50:01 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46116 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgCSPuA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 11:50:00 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6B73B72CCED;
        Thu, 19 Mar 2020 18:49:58 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4AB994A4AE7;
        Thu, 19 Mar 2020 18:49:58 +0300 (MSK)
Date:   Thu, 19 Mar 2020 18:49:57 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
Message-ID: <20200319154957.ijh7tbfp4d7iwcef@altlinux.org>
Mail-Followup-To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190817233348.22349-1-vt@altlinux.org>
 <392fed51-095d-2a6f-5eda-317e3bbc8707@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <392fed51-095d-2a6f-5eda-317e3bbc8707@linux.microsoft.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Lakshmi,

On Thu, Mar 19, 2020 at 08:18:39AM -0700, Lakshmi Ramasubramanian wrote:
> 
> I assume this is the latest version of your patch set. I applied the patch.
> Am seeing the errors given below.
> 
> Also, are there any other changes in for ima-evm-utils (besides the files
> listed below)?
> 
> Please let me know if I am missing something.
> 
> >   .gitignore             |   2 +-
> >   Makefile.am            |   2 +-
> >   configure.ac           |   1 +
> >   tests/.gitignore       |  16 +++
> >   tests/Makefile.am      |  12 ++
> >   tests/functions.sh     | 272 ++++++++++++++++++++++++++++++++++++
> >   tests/gen-keys.sh      |  97 +++++++++++++
> >   tests/ima_hash.test    |  80 +++++++++++
> >   tests/sign_verify.test | 366 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   9 files changed, 846 insertions(+), 2 deletions(-)
> >   create mode 100644 tests/.gitignore
> >   create mode 100644 tests/Makefile.am
> >   create mode 100755 tests/functions.sh
> >   create mode 100755 tests/gen-keys.sh
> >   create mode 100755 tests/ima_hash.test
> >   create mode 100755 tests/sign_verify.test
> 
> ~/ima-evm-utils/$ ./configure
> config.status: error: cannot find input file: `tests/Makefile.in'
> 
> ~/ima-evm-utils/$ make
> 
> Making all in tests
> make[2]: Entering directory '~/ima-evm-utils/tests'
> make[2]: *** No rule to make target 'all'.  Stop.

Please run autogen.sh twice before running configure.

Thanks,

> 
> thanks,
>  -lakshmi
