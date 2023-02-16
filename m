Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCA698B1F
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Feb 2023 04:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBPDXB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Feb 2023 22:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBPDXA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Feb 2023 22:23:00 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9973583
        for <linux-integrity@vger.kernel.org>; Wed, 15 Feb 2023 19:22:48 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G2ijRX028128;
        Thu, 16 Feb 2023 03:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mUvtWjTcAC9Vx5evhRJMWuWvOyI5qN7ipGKYX4t/nt0=;
 b=hin5Kv9ZaqL0p5M5X7iH1tmrZXtCyCXSYEGINRrF+Zv4WcNHIGtqewMdmPzhB0rVlc8W
 pcRRlvzqU3OjKw8OBt+KGFr4Hj0meRUD376hAmCBXxpcIMxHlZO06HZ/Zqz0JSxDuohy
 yfhib5/rjvCcdRgxWwpFEVS7xKz5TKZZm3gJLPdQNC+Z/Y0IjgL8rFegTLOQjL3CUQv5
 Nz0GzQfBG9r4lx9ttloahU92Ui6kEeVY6b7UpEYZ+/hri+kDXHuqknGJVhaS/D7lgOIS
 tGXm1LfwWbkuWnk4KagqMiNysPYMcP2aShQiUg2QuRwYU7/gyQdSrRlRwfh0h41IK5B3 Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsbypgk94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 03:22:25 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31G2vLHo004260;
        Thu, 16 Feb 2023 03:22:25 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsbypgk90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 03:22:25 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FNqBNp017171;
        Thu, 16 Feb 2023 03:22:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3np2n70eb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 03:22:24 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31G3MNqn37618344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 03:22:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F9FE58051;
        Thu, 16 Feb 2023 03:22:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F6D05805F;
        Thu, 16 Feb 2023 03:22:22 +0000 (GMT)
Received: from sig-9-65-193-223.ibm.com (unknown [9.65.193.223])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 03:22:22 +0000 (GMT)
Message-ID: <f00d6ea8df825b38f1df62cd2487fb4467c7ab48.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 15 Feb 2023 22:22:21 -0500
In-Reply-To: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
References: <20230214152258.3553294-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: crzebuwP8La4wbbhpDQ_lerEZqrhe_Eg
X-Proofpoint-ORIG-GUID: _CwfE5WH6gJKBxQJT0bFqAzD7g75bWPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_15,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

> diff --git a/tests/ima_policy_check.awk b/tests/ima_policy_check.awk
> new file mode 100755
> index 00000000000..73107d01083
> --- /dev/null
> +++ b/tests/ima_policy_check.awk
> @@ -0,0 +1,176 @@
> +#! /usr/bin/gawk -f
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> +#
> +# Check a new rule against the loaded IMA policy.
> +#
> +# Documentation/ABI/testing/ima_policy (Linux kernel)
> +# base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
> +#	[uid=] [euid=] [gid=] [egid=]
> +#	[fowner=] [fgroup=]]
> +# lsm:	[[subj_user=] [subj_role=] [subj_type=]
> +#	[obj_user=] [obj_role=] [obj_type=]]
> +# option:	[digest_type=] [template=] [permit_directio]
> +#		[appraise_type=] [appraise_flag=]
> +#		[appraise_algos=] [keyrings=]
> +#
> +# Rules don't overlap if there is at least one policy keyword (in base or lsm)
> +# providing a different value.

The above comment needs to be updated to reflect the overlapping tests.

> Currently, the < > operators and the ^ modifier
> +# are not supported and overlap is asserted even if intervals are disjoint.
> +# Also, despite the MMAP_CHECK and MMAP_CHECK_REQPROT hooks have different
> +# names, they are basically the same hook but with different behavior depending
> +# on external factors, so also in this case overlap has to be asserted. Finally,
> +# the existing aliases PATH_CHECK and FILE_MMAP are converted to the current
> +# hook names, respectively FILE_CHECK and MMAP_CHECK.
> +#
> +# Rule equivalence is determined by checking each key/value pair, regardless of
> +# their order. However, the action must always be at the beginning of the rules.
> +# Rules with aliases are considered equivalent.
> +#
> +# Return a bit mask with the following values:
> +# - 1: invalid new rule;
> +# - 2: overlap of the new rule with an existing rule in the IMA policy;
> +# - 4: new rule exists in the IMA policy.
> 
> diff --git a/tests/ima_policy_check.test b/tests/ima_policy_check.test
> new file mode 100755
> index 00000000000..ba8747a74b1
> --- /dev/null
> +++ b/tests/ima_policy_check.test
> @@ -0,0 +1,225 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> +#
> +# Test for ima_policy_check.awk
> +
> +trap '_report_exit_and_cleanup' SIGINT SIGTERM EXIT
> +
> +cd "$(dirname "$0")" || exit 1
> +. ./functions.sh
> +
> +export PATH=$PWD:$PATH
> +
> +check_result() {
> +	local result
> +
> +	echo -e "\nTest: $1"
> +	echo "New rule: $2"
> +	echo "IMA policy: $3"
> +
> +	echo -n "Result (expect $4): "
> +
> +	echo -e "$2\n$3" | ima_policy_check.awk
> +	result=$?
> +
> +	if [ "$result" -ne "$4" ]; then
> +		echo "${RED}$result${NORM}"
> +		return "$FAIL"
> +	fi
> +
> +	echo "${GREEN}$result${NORM}"
> +	return "$OK"
> +}
> +
> +# Basic checks.
> +desc="empty IMA policy"
> +rule="measure func=FILE_CHECK"
> +ima_policy=""
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 0

Include the comment, before the tests, as to what the expected return
values mean:
# Return a bit mask with the following values:
# - 1: invalid new rule;
# - 2: overlap of the new rule with an existing rule in the IMA policy;
# - 4: new rule exists in the IMA policy.

> +desc="Empty new rule"
> +rule=""
> +ima_policy=""
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> +
> +desc="Wrong func"

"FILE_CHECK" is actually fine, but the condition keyword "fun" is
invalid. 

> +rule="measure fun=FILE_CHECK"
> +ima_policy=""
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> +
> +desc="Missing action"
> +rule="func=FILE_CHECK"
> +ima_policy=""
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> +
> +# Non-overlapping rules.
> +desc="Non-overlapping by func"
> +rule="measure func=FILE_CHECK"
> +ima_policy="appraise func=MMAP_CHECK"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 0

All of the non-overlapping tests are non-overlapping by action as well.
Is this intentional?

> +
> +desc="Non-overlapping by uid, func is equal"
> +rule="measure func=FILE_CHECK uid=0"
> +ima_policy="appraise uid=1 func=FILE_CHECK"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 0

> +desc="Non-overlapping by uid, func is equal, same policy options"
> +rule="measure func=FILE_CHECK uid=0 permit_directio"
> +ima_policy="appraise uid=1 func=FILE_CHECK permit_directio"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> +
> +desc="Non-overlapping by mask, func and uid are equal, same policy options"
> +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> +ima_policy="appraise uid=0 mask=MAY_EXEC func=FILE_CHECK permit_directio"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> +
> +desc="Non-overlapping by mask, func and uid are equal, different policy options"
> +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> +ima_policy="appraise uid=0 mask=MAY_EXEC func=FILE_CHECK"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> +
> +# Overlapping and different rules.
> +desc="same actions, different keywords"
> +rule="appraise func=FILE_CHECK"
> +ima_policy="appraise uid=0"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> +
> +desc="different actions, same func"
> +rule="appraise func=FILE_CHECK"
> +ima_policy="measure func=FILE_CHECK"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2

Ok, a "measure" rule overlapping with an existing "appraise" rule could
impact a test,  but the reverse an "appraise" rule overlapping with an
existing "measure" rule should not impact tests.  So overlapping rules
are not necessarily interferring.

> +desc="different actions, same func"
> +rule="appraise func=FILE_CHECK"
> +ima_policy="dont_measure func=FILE_CHECK"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2

Similarly, an "appraise" rule should not be impacted by an existing
"dont_measure" rule.

> +desc="different actions, same func"
> +rule="measure func=FILE_CHECK"
> +ima_policy="dont_measure func=FILE_CHECK"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2

Right, measure/dont_measure rules for the same func hook overlap.

> +
> +desc="different actions, same func, different policy options"
> +rule="measure func=FILE_CHECK"
> +ima_policy="dont_measure func=FILE_CHECK permit_directio"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2

Right, any combination of measure rules or measure/dont_measure rules
for the same func hook should overlap, if one rule is more restrictive
than the other.

> +desc="different actions, same func, different policy options"
> +rule="measure func=FILE_CHECK permit_directio"
> +ima_policy="dont_measure func=FILE_CHECK"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> +
> +desc="same actions, same func, same mask with different modifier"
> +rule="measure func=FILE_CHECK mask=MAY_EXEC"
> +ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> +
> +desc="same actions, same func, different mask with same modifier"
> +rule="measure func=FILE_CHECK mask=^MAY_READ"
> +ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
> +expect_pass check_result "$desc" "$rule" "$ima_policy" 2

Right, these rules are equally restrictive, but would overlap when a
file is opened RW. 

-- 
thanks,

Mimi

