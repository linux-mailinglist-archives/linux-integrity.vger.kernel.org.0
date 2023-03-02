Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D676A84D1
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCBPDN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 10:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCBPDM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 10:03:12 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284C91986
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 07:03:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PSDdw3XDSz9v7Zm
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 22:54:28 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnOF+YugBkaQ9kAQ--.9622S2;
        Thu, 02 Mar 2023 16:02:54 +0100 (CET)
Message-ID: <6ff2a75c338aa6ca84666c9d91b33afd421818a8.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v3] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 02 Mar 2023 16:02:44 +0100
In-Reply-To: <d235810e8d352e4ebcd177dfb512f590eb3720aa.camel@linux.ibm.com>
References: <20230228175859.193798-1-roberto.sassu@huaweicloud.com>
         <0d74908c26c59c9605c80060fd78f543f2f4f470.camel@linux.ibm.com>
         <f1400ec253c961fb7bf321f6a0a44c75e15940c2.camel@huaweicloud.com>
         <d235810e8d352e4ebcd177dfb512f590eb3720aa.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBnOF+YugBkaQ9kAQ--.9622S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGryfKw45tF1rCFyUJryUAwb_yoW8Gry3Xo
        WfKrnIyFW8GF98C3WDC39FqrWj93WfGrs7J345AF45CFy2gr4kZay5Xr15JF4kGwn8JF13
        KFyxX3s5AFyUWasxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5H7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3w
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
        WIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBF1jj4Yj3AAAsK
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-03-02 at 09:47 -0500, Mimi Zohar wrote:
> On Thu, 2023-03-02 at 13:40 +0100, Roberto Sassu wrote:
> > On Wed, 2023-03-01 at 19:18 -0500, Mimi Zohar wrote:
> > > Hi Roberto,
> > > 
> > > Just a couple of comments below.
> > > 
> > > 
> > > > diff --git a/tests/ima_policy_check.test b/tests/ima_policy_check.test
> > > > new file mode 100755
> > > > index 00000000000..3549009bb1c
> > > > --- /dev/null
> > > > +++ b/tests/ima_policy_check.test
> > > > @@ -0,0 +1,245 @@
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
> > > > +# ima_policy_check.awk returns a bit mask with the following values:
> > > > +# - 1: invalid new rule;
> > > > +# - 2: overlap of the new rule with an existing rule in the IMA policy;
> > > > +# - 4: new rule exists in the IMA policy.
> > > > +
> > > > +# Basic checks.
> > > > +desc="empty IMA policy"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy=""
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Empty new rule"
> > > > +rule=""
> > > > +ima_policy=""
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > > +
> > > > +desc="Unknown policy keyword fun"
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
> > > > +desc="Non-overlapping by action measure/dont_appraise, same func"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy="dont_appraise func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by action audit/dont_appraise, same func"
> > > > +rule="audit func=FILE_CHECK"
> > > > +ima_policy="dont_appraise func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by action appraise/dont_measure, same func"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="dont_measure func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by action dont_measure/hash, same func"
> > > > +rule="dont_measure func=FILE_CHECK"
> > > > +ima_policy="hash func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by func"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy="measure func=MMAP_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by uid, func is equal"
> > > > +rule="measure func=FILE_CHECK uid=0"
> > > > +ima_policy="measure uid=1 func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by uid, func is equal, same policy options"
> > > > +rule="measure func=FILE_CHECK uid=0 permit_directio"
> > > > +ima_policy="measure uid=1 func=FILE_CHECK permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by mask, func and uid are equal, same policy options"
> > > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > > +ima_policy="measure uid=0 mask=MAY_EXEC func=FILE_CHECK permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="Non-overlapping by mask, func and uid are equal, different policy options"
> > > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > > +ima_policy="measure uid=0 mask=MAY_EXEC func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +# Overlapping and different rules.
> > > > +desc="same actions, different keywords"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="appraise uid=0"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="unrelated actions with appraise and a do action, same func"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="measure func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > 
> > > All the different actions - appraise, measure, audit - are applied for
> > > the same hook.  If the appraise rule func is "FILE_CHECK", then for any
> > > other func, the rules would overlap. 
> > 
> > Hi Mimi
> > 
> > yes. But also, if two tests add respectively appraise func=MMAP_CHECK
> > and measure func=FILE_CHECK, if we say that they don't overlap, we are
> > implying that there won't be mmap operations in the second test.
> 
> With this understanding of what constitutes overlapping rules, then a
> "measure func=FILE_CHECK" rule should overlap with all other rules. 
> Why limit it to the same hook?

Ok, I agree.

> > I would be more on the safe side, and say that if there is an appraise
> > rule, different func values won't lead to no overlap.
> 
> Ok, at least adding a comment explaining what is meant by overlap in
> this case would help.

I think the fact is that by executing commands, more than one hook can
be executed. Will add a note.

> > > > +
> > > > +desc="related actions, same func"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy="dont_measure func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="related actions, same func, different policy options"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy="dont_measure func=FILE_CHECK permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="related actions, same func, different policy options"
> > > > +rule="measure func=FILE_CHECK permit_directio"
> > > > +ima_policy="dont_measure func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="same actions, same func, same mask with different modifier"
> > > > +rule="measure func=FILE_CHECK mask=MAY_EXEC"
> > > > +ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="same actions, same func, different mask with same modifier"
> > > > +rule="measure func=FILE_CHECK mask=^MAY_READ"
> > > > +ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="same actions, same func, different policy options"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy="measure func=FILE_CHECK permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="same actions, same func, different policy options"
> > > > +rule="measure func=FILE_CHECK permit_directio"
> > > > +ima_policy="measure func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="same actions, MMAP_CHECK and MMAP_CHECK_REQPROT hooks"
> > > > +rule="measure func=MMAP_CHECK"
> > > > +ima_policy="measure func=MMAP_CHECK_REQPROT"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +desc="related actions, same func, same mask with same modifier"
> > > > +rule="measure func=FILE_CHECK mask=^MAY_EXEC"
> > > > +ima_policy="dont_measure func=FILE_CHECK mask=^MAY_EXEC"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +desc="same actions, same func, different uid with same operator"
> > > > +rule="measure func=FILE_CHECK uid>0"
> > > > +ima_policy="measure func=FILE_CHECK uid>1"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > 
> > > Please add a comment here before the < > test, indicating these
> > > operators are currently not supported.
> > > > +desc="same actions, same func, same uid with different operator"
> > > > +rule="measure func=FILE_CHECK uid>1"
> > > > +ima_policy="measure func=FILE_CHECK uid<1"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > > +
> > > > +# Overlapping and same rules.
> > > > +desc="same actions, same func"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="appraise func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > > +
> > > > +desc="same actions, same func, same mask"
> > > > +rule="appraise mask=MAY_READ func=FILE_CHECK"
> > > > +ima_policy="appraise func=FILE_CHECK mask=MAY_READ"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > > +
> > > > +desc="same actions, same func, same mask, same policy options"
> > > > +rule="appraise mask=MAY_READ func=FILE_CHECK permit_directio appraise_type=imasig"
> > > > +ima_policy="appraise func=FILE_CHECK mask=MAY_READ permit_directio appraise_type=imasig"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > > +
> > > > +desc="same actions, same func"
> > > > +rule="measure func=MMAP_CHECK_REQPROT"
> > > > +ima_policy="measure func=MMAP_CHECK_REQPROT"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > > +
> > > > +desc="same actions, same func with alias"
> > > > +rule="measure func=FILE_CHECK"
> > > > +ima_policy="measure func=PATH_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> 
> Aliases should probably be classified as duplicate rules.  For now this
> is fine, since aliases are deprecated and should be removed.   Perhaps
> comment it.

Yes, aliases are converted internally to the main hook name. So, the
script considers rules with aliases as duplicate (equivalent). Ok.

Thanks

Roberto

> > > > +
> > > > +desc="same actions, same func with alias, same mask with same modifiers"
> > > > +rule="measure mask=^MAY_READ func=FILE_CHECK"
> > > > +ima_policy="measure func=PATH_CHECK mask=^MAY_READ"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > > +
> > > > +desc="same actions, same func with alias and same mask with same modifiers, same uid with same operators"
> > > > +rule="measure mask=^MAY_READ uid>0 func=FILE_CHECK"
> > > > +ima_policy="measure func=PATH_CHECK mask=^MAY_READ uid>0"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > > +
> > > > +desc="same actions, same func with alias and same mask with same modifiers, same uid with same operators"
> > > > +rule="measure mask=^MAY_READ uid<1 func=FILE_CHECK"
> > > > +ima_policy="measure func=PATH_CHECK mask=^MAY_READ uid<1"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > > +
> > > > +# Overlapping and two rules (one same, one different).
> > > > +desc="first: same actions, same func, second: unrelated actions with appraise and a do action"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="appraise func=FILE_CHECK\nmeasure func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > > 
> > > Refer to comment above on different action rules for same func.
> > > 
> > > > +desc="first: unrelated actions with appraise and a do action, same func, second: same actions"
> > > > +rule="appraise func=FILE_CHECK"
> > > > +ima_policy="measure func=FILE_CHECK\nappraise func=FILE_CHECK"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > > > +
> > > > +desc="first: same actions, same func, same mask, second: different policy options"
> > > > +rule="appraise mask=MAY_READ func=FILE_CHECK"
> > > > +ima_policy="appraise func=FILE_CHECK mask=MAY_READ\nappraise func=FILE_CHECK mask=MAY_READ permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > > > +
> > > > +desc="first: same actions, same func with alias, same mask, second: different policy options"
> > > > +rule="appraise mask=MAY_READ func=FILE_CHECK"
> > > > +ima_policy="appraise func=PATH_CHECK mask=MAY_READ\nappraise func=FILE_CHECK mask=MAY_READ permit_directio"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > > > +
> > > > +# Non-overlapping and three rules.
> > > > +desc="same actions, same func and mask, different uid"
> > > > +rule="appraise mask=MAY_READ func=FILE_CHECK uid=0"
> > > > +ima_policy="appraise mask=MAY_READ func=FILE_CHECK uid=1\nappraise mask=MAY_READ func=FILE_CHECK uid=2\nappraise mask=MAY_READ func=FILE_CHECK uid=3"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > > +
> > > > +desc="same actions, same func and mask, different uid, except one that is the same"
> > > > +rule="appraise mask=MAY_READ func=FILE_CHECK uid=0"
> > > > +ima_policy="appraise mask=MAY_READ func=FILE_CHECK uid=1\nappraise mask=MAY_READ func=FILE_CHECK uid=0\nappraise mask=MAY_READ func=FILE_CHECK uid=3"
> > > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4

