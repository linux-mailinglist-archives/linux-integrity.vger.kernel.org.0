Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EE53233A1
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Feb 2021 23:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBWWPa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 17:15:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:41492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhBWWPa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 17:15:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE642AC69;
        Tue, 23 Feb 2021 22:14:34 +0000 (UTC)
Date:   Tue, 23 Feb 2021 23:14:33 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH] IMA: Add test for selinux measurement
Message-ID: <YDV+SdQqGnCoykph@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210222023805.12846-1-nramas@linux.microsoft.com>
 <YDVCsNAfn+Ot6QIB@pevik>
 <fdda206c-e156-d66b-7f53-0ee9c1417597@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdda206c-e156-d66b-7f53-0ee9c1417597@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On 2/23/21 10:00 AM, Petr Vorel wrote:


> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > ...
> > > +validate_policy_capabilities()
> > > +{
> > > +	local measured_cap measured_value expected_value
> > > +	local result=1
> > > +	local inx=7
> > > +
> > > +	# Policy capabilities flags start from "network_peer_controls"
> > > +	# in the measured SELinux state at offset 7 for 'awk'
> > > +	while [ $inx -lt 20 ]; do
> > > +		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
> > > +		inx=$(( $inx + 1 ))
> > > +
> > > +		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
> > > +		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
> > > +		if [ "$measured_value" != "$expected_value" ];then
> > > +			tst_res TWARN "$measured_cap: expected: $expected_value, got: $digest"
> > We rarely use TWARN in the tests, only when the error is not related to the test result.
> > Otherwise we use TFAIL.
> ok - I will change it to TFAIL.
Thanks!
But I've noticed that this error is handled twice, first in validate_policy_capabilities()
as TWARN (or TFAIL) and then in test2(). Let's use TPASS/TFAIL in
validate_policy_capabilities():

validate_policy_capabilities()
{
	local measured_cap measured_value expected_value
	local inx=7

	# Policy capabilities flags start from "network_peer_controls"
	# in the measured SELinux state at offset 7 for 'awk'
	while [ $inx -lt 20 ]; do
		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
		inx=$(($inx + 1))

		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
		if [ "$measured_value" != "$expected_value" ]; then
			tst_res TFAIL "$measured_cap: expected: $expected_value, got: $digest"
			return
		fi

		inx=$(($inx + 1))
	done

	tst_res TPASS "SELinux state measured correctly"
}

test2()
{
	...
	validate_policy_capabilities $measured_data
}

...
> > As we discuss, I'm going tom merge test when patchset is merged in maintainers tree,
> > please ping me. And ideally we should mention kernel commit hash as a comment in
> > the test.
> Will do. Thank you.
Thanks!

...
> > +++ testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> > @@ -13,16 +13,14 @@ TST_SETUP="setup"
> >   . ima_setup.sh
> >   FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
> > -REQUIRED_POLICY="^measure.*($FUNC_CRITICAL_DATA)"
> > +REQUIRED_POLICY="^measure.*$FUNC_CRITICAL_DATA"
> >   setup()
> >   {
> > -	SELINUX_DIR=$(tst_get_selinux_dir)
> > -	if [ -z "$SELINUX_DIR" ]; then
> > -		tst_brk TCONF "SELinux is not enabled"
> > -		return
> > -	fi
> > +	tst_require_selinux_enabled
> Please correct me if I have misunderstood this one:

> tst_require_selinux_enabled is checking if SELinux is enabled in "enforce"
> mode. Would this check fail if SELinux is enabled in "permissive" mode?

> For running the test, we just need SELinux to be enabled. I verify that by
> checking for the presence of SELINUX_DIR.

Good catch. Your original version is correct (put it back into ima/selinux.v2.fixes).
I didn't put a helper for it, because you need $SELINUX_DIR anyway.
Thus removed tst_require_selinux_enabled() as not needed.

I renamed tst_selinux_enabled() to tst_selinux_enforced() to make the purpose clearer
(commit 82b598ea1 IMA: Add test for selinux measurement).

I've updated branch ima/selinux.v2.fixes with all mentioned changes
https://github.com/pevik/ltp/commits/ima/selinux.v2.fixes

Kind regards,
Petr

> thanks,
>  -lakshmi
