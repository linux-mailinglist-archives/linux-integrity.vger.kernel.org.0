Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70CE263EAD
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Sep 2020 09:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIJHY5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Sep 2020 03:24:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:55142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgIJHYp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Sep 2020 03:24:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9978BAC97;
        Thu, 10 Sep 2020 07:24:59 +0000 (UTC)
Date:   Thu, 10 Sep 2020 09:24:42 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com,
        ltp@lists.linux.it
Subject: Re: [PATCH] IMA: Add test for dm-crypt measurement
Message-ID: <20200910072442.GA3946@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200829011427.12893-1-tusharsu@linux.microsoft.com>
 <20200901060740.GA4117@dell5510>
 <64b16589-f16a-eff0-47f3-8456853fc205@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b16589-f16a-eff0-47f3-8456853fc205@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

> > > IMA subsystem supports measuring data from other kernel components
> > > through func=CRITICAL_DATA policy 'critical_kernel_data_sources'.
> > > This IMA policy can be set to measure the data coming from device-mapper
> > > targets. This scenario needs test coverage.
> > Thank you for your patch.

> > First, you haven't send this patch to LTP mailing list
> > (https://lists.linux.it/listinfo/ltp). I Cc it, please do next time.

> Apologies for my ignorance.
> I will include it next time.
Thanks! No big deal :).

> > > Add a testcase which verifies that the IMA subsystem correctly measures
> > > the data provided by one such DM target - dm-crypt.

> > > This series needs a kernel built on the following repo/branch/patches:
> > >   repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
> > >   branch: next-integrity
> > >   commit d012a7190fc1 ("Linux 5.9-rc2")

> > > And the following patch series should be applied in the order below:
> > >   1. https://patchwork.kernel.org/patch/11709527/
> > >   2. https://patchwork.kernel.org/patch/11742047/
> > >   3. https://patchwork.kernel.org/patch/11743265/
> > >   4. https://patchwork.kernel.org/patch/11743715/

> > Thanks for a detailed info.
> Sure. :)

...
> > > +### IMA DM target (dm-crypt) measurement test
> > > +
> > > +To enable IMA to measure device-mapper target - dm-crypt,
> > > +`ima_dm_crypt.sh` requires a readable IMA policy, as well as
> > > +a loaded measure policy with
> > > +`func=CRITICAL_DATA critical_kernel_data_sources=dm-crypt`
> > Could you please also create ima_dm_crypt.policy file in
> > testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/ directory?

> Maybe I should create a directory ‘ima_device_mapper’ rather than
> ‘ima_dm_crypt’ - because there could be more DM targets like ‘crypt’.
> And I will place all the dm target policy files there.
> Does it sound good?
The directory must have the same name as the test filename without extension,
because that is $TST_ID, see tst_test.sh:

if [ -z "$TST_ID" ]; then
	_tst_filename=$(basename $0) || \
		tst_brk TCONF "Failed to set TST_ID from \$0 ('$0'), fix it with setting TST_ID before sourcing tst_test.sh"
	TST_ID=${_tst_filename%%.*}
fi
export TST_ID="$TST_ID"

...
	export TST_DATAROOT="$LTPROOT/testcases/data/$TST_ID"

Unfortunately that's the current limitation for LTP data files.

...
> > > +test1()
> > > +{
> > > +	local dmcheck_lines i dm_targets templates
> > > +	local policy="critical_kernel_data_sources"
> > > +	local pattern='critical_kernel_data_sources=[^[:space:]]+'
> > > +	local tmp_file="tmp.txt"
> > > +	local tokens_file="tokens_file.txt" grep_file="grep_file.txt"
> > > +	local arg cmd key tgt_name
> > > +	local res=0
> > nit: local res
> > Later you can check
> > if [ "$res" = 1 ]; then

> I believe I do need to initialize res=0.
> Please see my comment below.
I'll reply there.

...
> > > +	dmcheck_lines=$(cat $tmp_file)
> > > +	dm_targets=$(for i in $dmcheck_lines; do echo "$i" | grep "$policy" | \
> > > +		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
> > Again, copy paste from ima_keys.sh. Could this be generalized and moved to
> > ima_setup.sh? See my hint below.
> Ok. I will see how I can generalize this. Thanks.
Thanks a lot!

...
> > BTW I plan to send v2 for ima_tpm.sh patch
> > https://patchwork.ozlabs.org/project/ltp/patch/20200527071434.28574-1-pvorel@suse.cz/
> > Maybe this could use it somehow as well, but not required. Main reason was to
> > use $DIGEST_INDEX (default 4), which would help to use tests also on ima_template_fmt.
> > In the future, when reboot requirement is added into LTP API this could be used
> > to tests more setup. But you can ignore it now.

> Ok. I will take a look at your v2. But won’t take a dependency on it, for
> the time being.
+1 Thanks! (it's really less important than previous generalizations with
ima_keys.sh).

...
> > > +			tst_res TINFO "Removing DM target $tgt_name."
> > > +			dmsetup remove $tgt_name
> > > +			return
> > > +		fi
> > > +
> > > +		if [ "$act_digest" = "$exp_digest" ]; then
> > > +			res=1
> > Maybe also TFAIL and return here instead of using $res?
> Thanks for the feedback.
> The while loop invokes a sub-shell. And res=1 would mean the hash is
> found, and I fail if the hash is *not* found (res=0).
> With that, it’s little tricky to do what you are suggesting. But I will see
> what I can do to simplify the logic.
It's just a small detail, you can ignore it. But we started the discussion, thus
here is an explanation:
[ "$res" = 1 ] is not true for uninitialized $res. That wouldn't work for [ $res
-eq 1 ] and also didn't work [ $res = 1 ] ("bash: [: =: unary operator
expected"). The trick is that = operator compares stings but also does numeric
evaluation and also "$uninitialized_variable" evaluates as "" (unlike
$uninitialized_variable - without quotes).

Thus instead of 0 vs. 1 you can use uninitialized vs 1 (unlike C, where 0 vs 1
must be used e.g. variable must be initialized, unless it's static variable
which is automatically initialized to 0). We use it often shell (in LTP), have a
look at tst_net.sh and tst_test.sh

Kind regards,
Petr
