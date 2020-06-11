Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6CF1F6B45
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jun 2020 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgFKPmw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jun 2020 11:42:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:56010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgFKPmw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jun 2020 11:42:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7399BACBD;
        Thu, 11 Jun 2020 15:42:54 +0000 (UTC)
Date:   Thu, 11 Jun 2020 17:42:49 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     ltp@lists.linux.it, zohar@linux.ibm.com,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] IMA: Add a test to verify importing a certificate
 into keyring
Message-ID: <20200611154249.GB25057@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
 <1591808483-22040-2-git-send-email-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591808483-22040-2-git-send-email-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan, Mimi,

@Mimi: I'd also appreciate you to review both commits.

> Add an IMA measurement test that verifies that an x509 certificate
> can be imported into the .ima keyring and measured correctly.

> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> ---
>  .../security/integrity/ima/tests/ima_keys.sh  | 44 ++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index 1b0dd0aed..6904fabfa 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -7,7 +7,7 @@

>  TST_NEEDS_CMDS="awk cut"
Not only xxd, but also keyctl needs to be here.
ALso it looks like you require openssl (unlike compute_digest where it's like
fallback and even here I was thinking about writing hint which packages are
required).
I'd also add cmp (probably less common than cut).
NOTE: Although not documented, we consider grep to be everywhere.

>  TST_SETUP="setup"
> -TST_CNT=1
> +TST_CNT=2
>  TST_NEEDS_DEVICE=1

Please put it here to allow overwrite it:
CERT_FILE="${CERT_FILE:-}/etc/keys/x509_ima.der"

>  . ima_setup.sh
> @@ -69,4 +69,46 @@ $(echo "$line" | cut -d' ' -f5) keyring"
>  	tst_res TPASS "specified keyrings were measured correctly"
>  }

> +
> +# Test that a cert can be imported into the ".ima" keyring correctly.
> +test2() {
> +	local keyring_id key_id
> +	CERT_FILE="/etc/keys/x509_ima.der" # Default
instead of here.
> +
> +	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
> +
> +	if ! openssl x509 -in $CERT_FILE -inform der > /dev/null; then
> +		tst_brk TCONF "The suppled cert file ($CERT_FILE) is not \
> +a valid x509 certificate"
> +	fi
> +
> +	tst_res TINFO "adding a cert to the \".ima\" keyring ($CERT_FILE)"
nit: I personally would not quot .ima. I usually don't quot that much or use '
to help people grep, but that's not important.

> +
> +	keyring_id=$(sudo keyctl show %:.ima | sed -n 2p | \
> +		sed 's/^[[:space:]]*//' | cut -d' ' -f1) || \
> +		tst_btk TCONF "unable to retrieve .ima keyring id"
> +
> +	if ! tst_is_num	"$keyring_id"; then
> +		tst_brk TCONF "unable to parse keyring id from keyring"
> +	fi
> +
> +	sudo evmctl import $CERT_FILE "$keyring_id" > /dev/null || \
This test requires to be run with root (see TST_NEEDS_ROOT=1 in ima_setup.sh,
maybe I should have put the variables in each test to be this clear),
thus no need for sudo. Also you'd need to specify sudo in TST_NEEDS_CMDS
(precise check is needed as these tests can be run on some custom embedded
board, without any support.  Also some people test kernel with rapido.)

> +		tst_brk TCONF "unable to import a cert into the .ima keyring"
> +
> +	grep -F ".ima" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
> +		xxd -r -p > $TEST_FILE || \
> +		tst_brk TCONF "cert not found in ascii_runtime_measurements log"
> +
> +	if ! openssl x509 -in $TEST_FILE -inform der > /dev/null; then
> +		tst_brk TCONF "The cert logged in ascii_runtime_measurements \
> +($CERT_FILE) is not a valid x509 certificate"
> +	fi
> +
> +	if cmp -s "$TEST_FILE" $CERT_FILE; then
> +		tst_res TPASS "logged cert matches original cert"
> +	else
> +		tst_res TFAIL "logged cert does not match original cert"
> +	fi
> +}
> +
>  tst_run

Again, thank for your patches!

Kind regards,
Petr
