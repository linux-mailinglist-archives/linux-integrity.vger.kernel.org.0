Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3C699551
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 14:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBPNOL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Feb 2023 08:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjBPNOK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Feb 2023 08:14:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE77521C7
        for <linux-integrity@vger.kernel.org>; Thu, 16 Feb 2023 05:14:08 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GD7dsp032176;
        Thu, 16 Feb 2023 13:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wARf5TG2ALhp30nZAbSkwRxh8ZIbPMquVCUzUd9mcOA=;
 b=lbqqI42ftn2GKX7L2O+7KildPLMrImLRdxwp9eatD6HpcoKvkTiC0ICdfPqUBNZ1qcp/
 pNoaptm0mBjm+3vqd1WSj/hVsxfBcpXk1tQ3Udotepz9j+uo11D1zx6GRVYtZZPKnaDZ
 ycP8XzLXSgKPXdKSOGIUPrCL1zhezmP8b8tJFNbeeW1eegm5uRreELVU8vLXstL90xIi
 9CswXkkths+lNBDCY2fxW4vM4Bs8Xx4+TvVUJmQYlzs7uAiv40NwRmgvwXcmbQQ30ED3
 HQAXf1GhyFM6DOQgxzCbrhuUx08Bwy9CsdNCQrwt11AuqoUduM9Amx646hFk5VIKteEe FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsn3nr3aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 13:13:45 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31GD88o2034812;
        Thu, 16 Feb 2023 13:13:44 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsn3nr3aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 13:13:44 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31GB2phE024149;
        Thu, 16 Feb 2023 13:13:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3np2n7s5uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 13:13:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31GDDgKl36962854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 13:13:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B03B58043;
        Thu, 16 Feb 2023 13:13:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713D858055;
        Thu, 16 Feb 2023 13:13:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.163.119])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 13:13:41 +0000 (GMT)
Message-ID: <87c98608540c6b482614ac90bcf7819c3fd058e5.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 16 Feb 2023 08:13:41 -0500
In-Reply-To: <c462ad3e9b77990691b3cf0aff64ea64a5d77586.camel@huaweicloud.com>
References: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
         <f00d6ea8df825b38f1df62cd2487fb4467c7ab48.camel@linux.ibm.com>
         <c462ad3e9b77990691b3cf0aff64ea64a5d77586.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aWXAh0n99TTNB_1hI5AYfKUzC4scyXd0
X-Proofpoint-ORIG-GUID: UKYJnStH-v5n0gaQzxZXUY4XHY6pdPTx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_09,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-16 at 09:39 +0100, Roberto Sassu wrote:
> On Wed, 2023-02-15 at 22:22 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > > diff --git a/tests/ima_policy_check.awk b/tests/ima_policy_check.awk
> > > new file mode 100755
> > > index 00000000000..73107d01083
> > > --- /dev/null
> > > +++ b/tests/ima_policy_check.awk
> > > @@ -0,0 +1,176 @@
> > > +#! /usr/bin/gawk -f
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> > > +#
> > > +# Check a new rule against the loaded IMA policy.
> > > +#
> > > +# Documentation/ABI/testing/ima_policy (Linux kernel)
> > > +# base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
> > > +#	[uid=] [euid=] [gid=] [egid=]
> > > +#	[fowner=] [fgroup=]]
> > > +# lsm:	[[subj_user=] [subj_role=] [subj_type=]
> > > +#	[obj_user=] [obj_role=] [obj_type=]]
> > > +# option:	[digest_type=] [template=] [permit_directio]
> > > +#		[appraise_type=] [appraise_flag=]
> > > +#		[appraise_algos=] [keyrings=]
> > > +#
> > > +# Rules don't overlap if there is at least one policy keyword (in base or lsm)
> > > +# providing a different value.
> > 
> > The above comment needs to be updated to reflect the overlapping tests.
> 
> Not sure what is missing. Maybe: rules don't overlap also when they are
> equivalent (they have the same keys and values)?

The above "overlap" definition doesn't take into account one rule being
more restrictive (having more "keys" than the other.)

> 
> > > Currently, the < > operators and the ^ modifier
> > > +# are not supported and overlap is asserted even if intervals are disjoint.
> > > +# Also, despite the MMAP_CHECK and MMAP_CHECK_REQPROT hooks have different
> > > +# names, they are basically the same hook but with different behavior depending
> > > +# on external factors, so also in this case overlap has to be asserted. Finally,
> > > +# the existing aliases PATH_CHECK and FILE_MMAP are converted to the current
> > > +# hook names, respectively FILE_CHECK and MMAP_CHECK.
> > > +#
> > > +# Rule equivalence is determined by checking each key/value pair, regardless of
> > > +# their order. However, the action must always be at the beginning of the rules.
> > > +# Rules with aliases are considered equivalent.
> > > +#
> > > +# Return a bit mask with the following values:
> > > +# - 1: invalid new rule;
> > > +# - 2: overlap of the new rule with an existing rule in the IMA policy;
> > > +# - 4: new rule exists in the IMA policy.
> > > 
> > > diff --git a/tests/ima_policy_check.test b/tests/ima_policy_check.test
> > > new file mode 100755
> > > index 00000000000..ba8747a74b1
> > > --- /dev/null
> > > +++ b/tests/ima_policy_check.test
> > > @@ -0,0 +1,225 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> > > +#
> > > +# Test for ima_policy_check.awk
> > > +
> > > +trap '_report_exit_and_cleanup' SIGINT SIGTERM EXIT
> > > +
> > > +cd "$(dirname "$0")" || exit 1
> > > +. ./functions.sh
> > > +
> > > +export PATH=$PWD:$PATH
> > > +
> > > +check_result() {
> > > +	local result
> > > +
> > > +	echo -e "\nTest: $1"
> > > +	echo "New rule: $2"
> > > +	echo "IMA policy: $3"
> > > +
> > > +	echo -n "Result (expect $4): "
> > > +
> > > +	echo -e "$2\n$3" | ima_policy_check.awk
> > > +	result=$?
> > > +
> > > +	if [ "$result" -ne "$4" ]; then
> > > +		echo "${RED}$result${NORM}"
> > > +		return "$FAIL"
> > > +	fi
> > > +
> > > +	echo "${GREEN}$result${NORM}"
> > > +	return "$OK"
> > > +}
> > > +
> > > +# Basic checks.
> > > +desc="empty IMA policy"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy=""
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > 
> > Include the comment, before the tests, as to what the expected return
> > values mean:
> > # Return a bit mask with the following values:
> > # - 1: invalid new rule;
> > # - 2: overlap of the new rule with an existing rule in the IMA policy;
> > # - 4: new rule exists in the IMA policy.
> 
> Ok.
> 
> > > +desc="Empty new rule"
> > > +rule=""
> > > +ima_policy=""
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > +
> > > +desc="Wrong func"
> > 
> > "FILE_CHECK" is actually fine, but the condition keyword "fun" is
> > invalid. 
> 
> Ok, will fix the description.
> 
> > > +rule="measure fun=FILE_CHECK"
> > > +ima_policy=""
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > +
> > > +desc="Missing action"
> > > +rule="func=FILE_CHECK"
> > > +ima_policy=""
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > +
> > > +# Non-overlapping rules.
> > > +desc="Non-overlapping by func"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy="appraise func=MMAP_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > 
> > All of the non-overlapping tests are non-overlapping by action as well.
> > Is this intentional?
> 
> Yes. Originally, I was considering only related actions (with/without
> dont_). But then, appraise rules could interfer with the rest too.

Ok.  To clarify, an "appraise" rule on an earlier hook (e.g.
file_check), could prevent a "measure" policy rule on a later hook
(e.g. bprm_check, mmap_check).

> 
> Maybe I should do this instead: consider again related actions and
> combinations of actions that include appraise.

Agreed

> 
> > +
> > > +desc="Non-overlapping by uid, func is equal"
> > > +rule="measure func=FILE_CHECK uid=0"
> > > +ima_policy="appraise uid=1 func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +desc="Non-overlapping by uid, func is equal, same policy options"
> > > +rule="measure func=FILE_CHECK uid=0 permit_directio"
> > > +ima_policy="appraise uid=1 func=FILE_CHECK permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by mask, func and uid are equal, same policy options"
> > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > +ima_policy="appraise uid=0 mask=MAY_EXEC func=FILE_CHECK permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by mask, func and uid are equal, different policy options"
> > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > +ima_policy="appraise uid=0 mask=MAY_EXEC func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +# Overlapping and different rules.
> > > +desc="same actions, different keywords"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="appraise uid=0"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="different actions, same func"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="measure func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > 
> > Ok, a "measure" rule overlapping with an existing "appraise" rule could
> > impact a test,  but the reverse an "appraise" rule overlapping with an
> > existing "measure" rule should not impact tests.  So overlapping rules
> > are not necessarily interferring.
> 
> Uhm, probably it does, when you reexecute the tests again and the
> appraise rule is already added. ima_match_policy() parses the policy
> until actmask is cleared.

Ok

> Actually, this was the situation for the MMAP_CHECK and
> MMAP_CHECK_REQPROT hooks test.

-- 
thanks,

Mimi

