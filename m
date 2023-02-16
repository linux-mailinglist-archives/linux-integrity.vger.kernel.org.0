Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39BB6995D4
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBPNaz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 08:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjBPNaw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 08:30:52 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED6556EFE
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 05:30:46 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PHbFh1qSCz9xGWp
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 21:22:00 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3xl3xL+5jqdIlAQ--.61886S2;
        Thu, 16 Feb 2023 14:30:31 +0100 (CET)
Message-ID: <6dc1c55d499187c55dbf88b19b52c3923001b8af.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v2] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 16 Feb 2023 14:30:19 +0100
In-Reply-To: <87c98608540c6b482614ac90bcf7819c3fd058e5.camel@linux.ibm.com>
References: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
         <f00d6ea8df825b38f1df62cd2487fb4467c7ab48.camel@linux.ibm.com>
         <c462ad3e9b77990691b3cf0aff64ea64a5d77586.camel@huaweicloud.com>
         <87c98608540c6b482614ac90bcf7819c3fd058e5.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwD3xl3xL+5jqdIlAQ--.61886S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW3uF4DXFyxXw18Gr1xKrg_yoW3Ww4rpF
        WkGa4DuF4DZ342qwn2gas8Xrn2yrWUGa1UXry5Gr9rAwn5Gw43Kry5tryUurW0kr15AFWq
        vr4Fq3y3ur1YqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4kPfgABsH
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-16 at 08:13 -0500, Mimi Zohar wrote:
> On Thu, 2023-02-16 at 09:39 +0100, Roberto Sassu wrote:
> > On Wed, 2023-02-15 at 22:22 -0500, Mimi Zohar wrote:
> > > Hi Roberto,
> > > 
> > > > diff --git a/tests/ima_policy_check.awk b/tests/ima_policy_check.awk
> > > > new file mode 100755
> > > > index 00000000000..73107d01083
> > > > --- /dev/null
> > > > +++ b/tests/ima_policy_check.awk
> > > > @@ -0,0 +1,176 @@
> > > > +#! /usr/bin/gawk -f
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +#
> > > > +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> > > > +#
> > > > +# Check a new rule against the loaded IMA policy.
> > > > +#
> > > > +# Documentation/ABI/testing/ima_policy (Linux kernel)
> > > > +# base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
> > > > +#	[uid=] [euid=] [gid=] [egid=]
> > > > +#	[fowner=] [fgroup=]]
> > > > +# lsm:	[[subj_user=] [subj_role=] [subj_type=]
> > > > +#	[obj_user=] [obj_role=] [obj_type=]]
> > > > +# option:	[digest_type=] [template=] [permit_directio]
> > > > +#		[appraise_type=] [appraise_flag=]
> > > > +#		[appraise_algos=] [keyrings=]
> > > > +#
> > > > +# Rules don't overlap if there is at least one policy keyword (in base or lsm)
> > > > +# providing a different value.
> > > 
> > > The above comment needs to be updated to reflect the overlapping tests.
> > 
> > Not sure what is missing. Maybe: rules don't overlap also when they are
> > equivalent (they have the same keys and values)?
> 
> The above "overlap" definition doesn't take into account one rule being
> more restrictive (having more "keys" than the other.)

Ok, I see.

Rules don't overlap if both include the same policy keyword (in base or
lsm), at least one, with a different value.

Roberto

> > > > Currently, the < > operators and the ^ modifier
> > > > +# are not supported and overlap is asserted even if intervals are disjoint.
> > > > +# Also, despite the MMAP_CHECK and MMAP_CHECK_REQPROT hooks have different
> > > > +# names, they are basically the same hook but with different behavior depending
> > > > +# on external factors, so also in this case overlap has to be asserted. Finally,
> > > > +# the existing aliases PATH_CHECK and FILE_MMAP are converted to the current
> > > > +# hook names, respectively FILE_CHECK and MMAP_CHECK.
> > > > +#
> > > > +# Rule equivalence is determined by checking each key/value pair, regardless of
> > > > +# their order. However, the action must always be at the beginning of the rules.
> > > > +# Rules with aliases are considered equivalent.
> > > > +#
> > > > +# Return a bit mask with the following values:
> > > > +# - 1: invalid new rule;
> > > > +# - 2: overlap of the new rule with an existing rule in the IMA policy;
> > > > +# - 4: new rule exists in the IMA policy.
> > > > 
> > > > diff --git a/tests/ima_policy_check.test b/tests/ima_policy_check.test
> > > > new file mode 100755
> > > > index 00000000000..ba8747a74b1
> > > > --- /dev/null
> > > > +++ b/tests/ima_policy_check.test
> > > > @@ -0,0 +1,225 @@
> > > > +#!/bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +#
> > > > +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> > > > +#
> > > > +# Test for ima_policy_check.awk
> > > > +
> > > > +trap '_report_exit_and_cleanup' SIGINT SIGTERM EXIT
> > > > +
> > > > +cd "$(dirname "$0")" || exit 1
> > > > +. ./functions.sh
> > > > +
> > > > +export PATH=$PWD:$PATH
> > > > +
> > > > +check_result() {
> > > > +	local result
> > > > +
> > > > +	echo -e "\nTest: $1"
> > > > +	echo "New rule: $2"
> > > > +	echo "IMA policy: $3"
> > > > +
> > > > +	echo -n "Result (expect $4): "
> > > > +
> > > > +	echo -e "$2\n$3" | ima_policy_check.awk
> > > > +	result=$?
> > > > +
> > > > +	if [ "$result" -ne "$4" ]; then
> > > > +		echo "${RED}$result${NORM}"
> > > > +		return "$FAIL"
> > > > +	fi
> > > > +
> > > > +	echo "${GREEN}$result${NORM}"
> > > > +	return "$OK"
> > > > +}
> > > > +
> > > > +# Basic checks.
> > > > +desc="empty IMA policy"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy=""
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > 
> > > Include the comment, before the tests, as to what the expected return
> > > values mean:
> > > # Return a bit mask with the following values:
> > > # - 1: invalid new rule;
> > > # - 2: overlap of the new rule with an existing rule in the IMA policy;
> > > # - 4: new rule exists in the IMA policy.
> > 
> > Ok.
> > 
> > > > +desc="Empty new rule"
> > > > +rule=""
> > > > +ima_policy=""
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > > +
> > > > +desc="Wrong func"
> > > 
> > > "FILE_CHECK" is actually fine, but the condition keyword "fun" is
> > > invalid. 
> > 
> > Ok, will fix the description.
> > 
> > > > +rule="measure fun=FILE_CHECK"
> > > > +ima_policy=""
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > > +
> > > > +desc="Missing action"
> > > > +rule="func=FILE_CHECK"
> > > > +ima_policy=""
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > > +
> > > > +# Non-overlapping rules.
> > > > +desc="Non-overlapping by func"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy="appraise func=MMAP_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > 
> > > All of the non-overlapping tests are non-overlapping by action as well.
> > > Is this intentional?
> > 
> > Yes. Originally, I was considering only related actions (with/without
> > dont_). But then, appraise rules could interfer with the rest too.
> 
> Ok.  To clarify, an "appraise" rule on an earlier hook (e.g.
> file_check), could prevent a "measure" policy rule on a later hook
> (e.g. bprm_check, mmap_check).
> 
> > Maybe I should do this instead: consider again related actions and
> > combinations of actions that include appraise.
> 
> Agreed
> 
> > > +
> > > > +desc="Non-overlapping by uid, func is equal"
> > > > +rule="measure func=FILE_CHECK uid=0"
> > > > +ima_policy="appraise uid=1 func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +desc="Non-overlapping by uid, func is equal, same policy options"
> > > > +rule="measure func=FILE_CHECK uid=0 permit_directio"
> > > > +ima_policy="appraise uid=1 func=FILE_CHECK permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by mask, func and uid are equal, same policy options"
> > > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > > +ima_policy="appraise uid=0 mask=MAY_EXEC func=FILE_CHECK permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by mask, func and uid are equal, different policy options"
> > > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > > +ima_policy="appraise uid=0 mask=MAY_EXEC func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +# Overlapping and different rules.
> > > > +desc="same actions, different keywords"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="appraise uid=0"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="different actions, same func"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="measure func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > 
> > > Ok, a "measure" rule overlapping with an existing "appraise" rule could
> > > impact a test,  but the reverse an "appraise" rule overlapping with an
> > > existing "measure" rule should not impact tests.  So overlapping rules
> > > are not necessarily interferring.
> > 
> > Uhm, probably it does, when you reexecute the tests again and the
> > appraise rule is already added. ima_match_policy() parses the policy
> > until actmask is cleared.
> 
> Ok
> 
> > Actually, this was the situation for the MMAP_CHECK and
> > MMAP_CHECK_REQPROT hooks test.

