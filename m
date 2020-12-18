Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624892DE8FA
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Dec 2020 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgLRSia (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Dec 2020 13:38:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:45890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgLRSia (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Dec 2020 13:38:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D51BAC7B;
        Fri, 18 Dec 2020 18:37:48 +0000 (UTC)
Date:   Fri, 18 Dec 2020 19:37:46 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        paul@paul-moore.com, tusharsu@linux.microsoft.com,
        ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ima: Add test for selinux measurement
Message-ID: <X9z2+nXBdTMqHPgD@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200928194730.20862-1-nramas@linux.microsoft.com>
 <20200928194730.20862-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928194730.20862-2-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi, Mimi, all,

@Lakshmi
TL;DR: I added some fixes in my fork, branch ima/selinux.v2.draft,
https://github.com/pevik/ltp/commits/ima/selinux.v2.draft

+ added 3 additional commits, one of them as you as the author.
I moved some functions to testcases/lib/tst_security.sh, renamed them.
Can you please have a look and test? I don't have any SELinux machine.

@Mimi, all: any comment to this test? My changes are just LTP cleanup
so you can comment it on this patchset.
I suppose you get to this in January.

Some notes for my changes:

As files are quite similar (checks etc), I put both tests into single
file ima_selinux.sh.

> New functionality is being added to IMA to measure data provided by
> kernel components. With this feature, IMA policy can be set to enable
> measuring data provided by Linux Security Modules (LSM). Currently one
> such LSM namely selinux is being updated to use this functionality.
> This new functionality needs test automation in LTP.

> Add test cases which verify that the IMA subsystem correctly measures
> the data provided by selinux.

Could you please put into commit message and test kernel commit hash relevant
for the test. Is that 8861d0af642c646c8e148ce34c294bdef6f32f6a (merged into
v5.10-rc1) or there are more relevant commits?

...
> +### IMA SELinux test
> +
> +To enable IMA to measure SELinux state and policy, `ima_selinux_policy.sh`
> +and `ima_selinux_state.sh` require a readable IMA policy, as well as
> +a loaded measure policy with
> +`measure func=CRITICAL_DATA data_sources=selinux template=ima-buf`
I put this into
testcases/kernel/security/integrity/ima/datafiles/ima_selinux/selinux.policy
and mention it in docs.

> +test1()
> +{
> +	local policy_digest expected_policy_digest algorithm
> +	local data_source_name="selinux"
> +	local pattern="data_sources=[^[:space:]]*$data_source_name"
> +	local tmp_file="$TST_TMPDIR/selinux_policy_tmp_file.txt"
> +
> +	check_policy_pattern "$pattern" $FUNC_CRITICAL_DATA $TEMPLATE_BUF > $tmp_file || return
> +
> +	tst_res TINFO "Verifying selinux policy measurement"
> +
> +	#
> +	# Trigger a measurement by changing selinux state
> +	#
> +	update_selinux_state
Here I used tst_update_selinux_state.

...
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh

> +#
> +# Update selinux state. This is used for validating IMA
> +# measurement of selinux constructs.
> +#
> +update_selinux_state()
> +{
> +	local cur_val new_val
> +
> +	cur_val=$(cat $SELINUX_FOLDER/checkreqprot)
> +
> +	if [ $cur_val = 1 ]; then
> +		new_val=0
> +	else
> +		new_val=1
> +	fi
> +
> +	echo $new_val > $SELINUX_FOLDER/checkreqprot
> +}
> +
> +#
> +# Verify selinux is enabled in the system
> +#
> +check_selinux_state()
> +{
> +	[ -d $SELINUX_FOLDER ] || tst_brk TCONF "selinux is not enabled"
> +}

As I mentioned above, this is not needed as I put them under different names in
testcases/lib/tst_security.sh.

>  mount_helper()
>  {
>  	local type="$1"
> @@ -238,6 +265,7 @@ ima_setup()
>  	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
>  	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
>  	IMA_POLICY="$IMA_DIR/policy"
> +	SELINUX_FOLDER="$SYSFS/fs/selinux"

nit: I renamed it to $SELINUX_DIR (for consistency with $IMA_DIR)
and moved to ima_selinux.sh.

Kind regards,
Petr
