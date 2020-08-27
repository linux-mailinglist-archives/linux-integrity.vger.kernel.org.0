Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC25925515A
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0WyU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 18:54:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgH0WyT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 18:54:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 388A3AD20;
        Thu, 27 Aug 2020 22:54:51 +0000 (UTC)
Date:   Fri, 28 Aug 2020 00:54:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
Message-ID: <20200827225417.GA29921@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-5-pvorel@suse.cz>
 <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
 <20200827132354.GA20439@dell5510>
 <20200827135503.GA11990@dell5510>
 <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

...
> > > > Instead of using TST_DATAROOT, which is defined as
> > > > "$LTPROOT/datafiles", use LTPROOT directly to define the path to the
> > > > cert.  Adding the following will allow the test to run from the build
> > > > directory.
> > > >       if [ ! -f $cert_file ]; then
> > > >               cert_file="$LTPROOT/../datafiles/ima_keys/x509_ima.der"
> > > >       fi
> > > Yes, this will work if you set LTPROOT to <ltp git>/testcases/kernel/security/integrity/ima/tests/:

> When running any of the tests from build tree test directory -
> ltp/testcases/kernel/security/integrity/ima/tests, supplying LTPROOT
> isn't necessary. "IMA: Refactor datafiles directory" broke running the
> other tests directly from the build tree as well.
Correct, I overlooked $LTPROOT does not have to be set.
You're right, there is export LTPROOT="$PWD" in tst_test.sh.

The only broken tests are ima_policy.sh and ima_keys.sh. I fixed that workaround
in the commit "IMA: Refactor datafiles directory":

+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -160,6 +160,11 @@ ima_setup()
 	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
 	IMA_POLICY="$IMA_DIR/policy"
 
+	# hack when running tests locally from tests directory
+	if [ ! -d "$TST_DATAROOT" ]; then
+		TST_DATAROOT="$LTPROOT/../datafiles/$TST_ID/"
+	fi
+
 	print_ima_config
 
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
---

Again, pushed to:
https://github.com/pevik/ltp/tree/Lachlan_Sneff/ima_keys.sh-second-test.v4.fixes

Kind regards,
Petr
