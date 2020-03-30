Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44107198208
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgC3RQC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 13:16:02 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48898 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgC3RQC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 13:16:02 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CEFC772CCED;
        Mon, 30 Mar 2020 20:16:00 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 963374A4A14;
        Mon, 30 Mar 2020 20:16:00 +0300 (MSK)
Date:   Mon, 30 Mar 2020 20:16:00 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v8 2/2] ima-evm-utils: Add sign/verify tests for evmctl
Message-ID: <20200330171600.gswyocgof3d3b76b@altlinux.org>
Mail-Followup-To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20200327042515.22315-1-vt@altlinux.org>
 <20200327042515.22315-3-vt@altlinux.org>
 <98cfccc0-2191-6072-aebe-296e6e150e0c@linux.microsoft.com>
 <4f2de793-dab2-e3e9-90a6-bf4ef139400f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f2de793-dab2-e3e9-90a6-bf4ef139400f@linux.microsoft.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Lakshmi,

On Mon, Mar 30, 2020 at 09:29:54AM -0700, Lakshmi Ramasubramanian wrote:
> On 3/30/20 9:26 AM, Lakshmi Ramasubramanian wrote:
> > On 3/26/20 9:25 PM, Vitaly Chikunov wrote:
> > 
> > > --- /dev/null
> > > +++ b/tests/gen-keys.sh
> > > @@ -0,0 +1,97 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > Should this be "# SPDX-License-Identifier: GPL-2.0+"
> > 
> > > +# This script leaves test-ca.conf, *.cer, *.pub, *.key files for
> > > sing/verify tests.
> > > +# They are never deleted except by `make distclean'.
> > > +
> > > diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> > > new file mode 100755
> > > index 0000000..190b23a
> > > --- /dev/null
> > > +++ b/tests/sign_verify.test
> > > @@ -0,0 +1,364 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > Same comment as above.
> > 
> > > +# Check that detached signature matches xattr signature
> > > +_test_sigfile() {
> > > +š local file=$1 attr=$2 file_sig=$3 file_sig2=$4
> > > +
> > > +š if [ ! -e $file_sig ]; then
> > > +ššš red_always
> > > +ššš echo "evmctl ima_sign: no detached signature $file_sig"
> > > +ššš color_restore
> > > +ššš rm $file
> > 
> > Should the file be not deleted in case of failure, so that one can check
> > the file manually?
> > 
> > > +ššš return $FAIL
> > > +š fi
> > > +
> > > +š _extract_xattr $file $attr $file_sig2
> > > +š if ! cmp -bl $file_sig $file_sig2; then
> > > +ššš red_always
> > > +ššš echo "evmctl ima_sign: xattr signature on $file differ from
> > > detached $file_sig"
> > > +ššš color_restore
> > > +ššš rm $file $file_sig $file_sig2
> > Same as above - should the files be not deleted in case of failure?

These files will be overwritten by subsequent tests anyway, so there is
not point to keep them.

Thanks,

> > 
> > thanks,
> >  š-lakshmi
> 
> + Mimi and linux-integrity
