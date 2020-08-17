Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AB246528
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 13:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgHQLJP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 07:09:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgHQLJM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 07:09:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B68CB737;
        Mon, 17 Aug 2020 11:09:34 +0000 (UTC)
Date:   Mon, 17 Aug 2020 13:09:06 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 3/4] IMA: Add a test to verify measurement of
 certificate imported into a keyring
Message-ID: <20200817110906.GA1895@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200807204652.5928-1-pvorel@suse.cz>
 <20200807204652.5928-4-pvorel@suse.cz>
 <25a78f42d15dcb3312a59de587cb9f4e31ccd5b5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a78f42d15dcb3312a59de587cb9f4e31ccd5b5.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Lakshmi,

> On Fri, 2020-08-07 at 22:46 +0200, Petr Vorel wrote:
> > From: Lachlan Sneff <t-josne@linux.microsoft.com>

> > diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> > index 53c289054..30950904e 100755
> > --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh

> > @@ -61,4 +65,52 @@ test1()
> >  	tst_res TPASS "specified keyrings were measured correctly"
> >  }

> > +# Create a new keyring, import a certificate into it, and verify
> > +# that the certificate is measured correctly by IMA.
> > +test2()
> > +{
> > +	tst_require_cmds evmctl keyctl openssl
> > +
> > +	local cert_file="$TST_DATAROOT/x509_ima.der"
> > +	local keyring_name="key_import_test"
> > +	local temp_file="file.txt"
> > +	local keyring_id
> > +
> > +	tst_res TINFO "verify measurement of certificate imported into a keyring"
> > +
> > +	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
> > +		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
> > +	fi
> > +

> If the IMA policy contains multiple KEY_CHECK measurement policy rules
> it complains about "grep: Unmatched ( or \(".

> Sample rules:
> measure func=KEY_CHECK template=ima-buf
> keyrings=.ima|.builtin_trusted_keys
> measure func=KEY_CHECK template=ima-buf keyrings=key_import_test

Good catch, reproduced, working on fix (NOTE 2nd line is obviously joined to the
first one).

Caused by later code:
grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line

> > +	keyctl new_session > /dev/null
> > +
> > +	keyring_id=$(keyctl newring $keyring_name @s) || \
> > +		tst_brk TBROK "unable to create a new keyring"
> > +
> > +	tst_is_num $keyring_id || \
> > +		tst_brk TBROK "unable to parse the new keyring id"
> > +
> > +	evmctl import $cert_file $keyring_id > /dev/null || \
> > +		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"

> "cert_file" needs to be updated from 
> "ltp/testcases/kernel/security/integrity/ima/tests/datafiles/x509_ima.d
> er" to
> "ltp/testcases/kernel/security/integrity/ima/tests/../datafiles/ima_key
> s/x509_ima.der".

As Lakshmi wrote if you apply the fix, which I included in my branch
Lachlan_Sneff/ima_keys.sh-second-test.v1.fixes [1] it'd work.

Unlike kselftest, LTP requires installing and running from installed
directory. There was fix in the past allow running uninstalled test:
435d2fd82 ("ima: Rename the folder name for policy files to datafiles"), but I
broke that in this patchset ("IMA: Refactor datafiles directory").

Maybe fixing a code in tst_test.sh
if [ -z "$LTPROOT" ]; then
	export LTPROOT="$PWD"
	export TST_DATAROOT="$LTPROOT/datafiles"
else
	export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
fi

To allow to redefine it, for local testing:
if [ -z "$TST_DATAROOT" ]; then
	if [ -z "$LTPROOT" ]; then
		export LTPROOT="$PWD"
		export TST_DATAROOT="$LTPROOT/datafiles"
	else
		export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"
	fi
fi

because datafile layout does not expect subdirectory. I also hate the makefile
helper, which requires to have special directory, datafiles just require some
rethinking.

> On failure to open the file, 
> errno: No such file or directory (2)

The rest is obviously not relevant (was just a hint for problems caused with
other LSM).
> ima_keys 2 TBROK: unable to import a certificate into key_import_test keyring
> ima_keys 2 TINFO: SELinux enabled in enforcing mode, this may affect test results
> ima_keys 2 TINFO: it can be disabled with TST_DISABLE_SELINUX=1 (requires super/root)
> ima_keys 2 TINFO: install seinfo to find used SELinux profiles
> ima_keys 2 TINFO: loaded SELinux profiles: none

Kind regards,
Petr

[1] https://github.com/pevik/ltp/tree/Lachlan_Sneff/ima_keys.sh-second-test.v1.fixes
