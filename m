Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252011981F5
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgC3RLz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 13:11:55 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44402 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgC3RLz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 13:11:55 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8A7E372CCED;
        Mon, 30 Mar 2020 20:11:53 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 6DDF04A4A14;
        Mon, 30 Mar 2020 20:11:53 +0300 (MSK)
Date:   Mon, 30 Mar 2020 20:11:53 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v8 1/2] ima-evm-utils: Add some tests for evmctl
Message-ID: <20200330171153.iwckfx5tc5ydkmhi@altlinux.org>
Mail-Followup-To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20200327042515.22315-1-vt@altlinux.org>
 <20200327042515.22315-2-vt@altlinux.org>
 <f9b36972-df5d-db9a-d840-52e9ff76d271@linux.microsoft.com>
 <f6c1766f-20c0-782d-0c3c-a522babd9142@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6c1766f-20c0-782d-0c3c-a522babd9142@linux.microsoft.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Lakshmi,

On Mon, Mar 30, 2020 at 09:29:29AM -0700, Lakshmi Ramasubramanian wrote:
> On 3/30/20 9:16 AM, Lakshmi Ramasubramanian wrote:
> 
> > On 3/26/20 9:25 PM, Vitaly Chikunov wrote:
> > 
> > > Run `make check' to execute the tests.
> > 
> > autogen.sh followed by configure need to be run. Could you please add
> > that in the patch description?

Why this patch should have this and not any other patch/commit?

> > > diff --git a/tests/functions.sh b/tests/functions.sh
> > > new file mode 100755
> > > index 0000000..16c8d89
> > > --- /dev/null
> > > +++ b/tests/functions.sh
> > > @@ -0,0 +1,272 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > 
> > In some source files in the kernel repo I have seen the following:
> > 
> >  ššš // SPDX-License-Identifier: GPL-2.0+
> > 
> > Not sure if it is applicable here.

I'm sure it's applicable.

> > 
> > > +check() {
> > > +š local alg=$1 pref=$2 chash=$3 hash
> > > +š local file=$alg-hash.txt
> > > +
> > > +š rm -f $file
> > > +š touch $file
> > > +š # Generate hash with openssl, if it's failed skip test,
> > 
> > "if it failed skip test"
> > 
> > > +š # unless it's negative test, then pass to evmctl
> > > +š cmd="openssl dgst $OPENSSL_ENGINE -$alg $file"
> > > +}
> > > +
> > 
> > > +# check args: algo hdr-prefix canonic-hash
> > > +expect_pass checkš md4ššššššš 0x01 31d6cfe0d16ae931b73c59d7e0c089c0
> > > +expect_pass checkš md5ššššššš 0x01 d41d8cd98f00b204e9800998ecf8427e
> > Is MD4 and MD5 tests still needed?

If it's supported why it shouldn't be tested.

> > 
> > 
> >  š-lakshmi
> 
> + Mimi and linux-integrity
