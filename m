Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93056A8487
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 15:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCBOsY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 09:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjCBOsK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 09:48:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD078A41
        for <linux-integrity@vger.kernel.org>; Thu,  2 Mar 2023 06:48:02 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322EblqY008706;
        Thu, 2 Mar 2023 14:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TsHLzkiqNhcu3aGHqLBu0U/lDCNQoXlzei4R0UEL9qU=;
 b=M5ei+K4BTjfqMB0kp9BFNk7uAPoX96LG/ZUrLweIm9e4ZWyMeF3TAI7HF94XYDsNgA0h
 GxkF1ZMYbR+Q46+DRvLC+ihZqYL+WN8cs/V2t0lHgKblarqMRrtamf2vmZVe/tJxqekU
 uLvlfWzmoiskIlnkX9EjvpiF9zOdFT7PGytWIa3ey2N+4MQ/g66rWstntcErQrns2Xsu
 17z8r6pgYxOgsLr635Oes/vB4KrSsw5BalbGWjOI28TO48eD8dW1tm3ZzMHB9N2sD4jQ
 0KNIM6oqQoJjmy+Ggmf7vKIkLT1/8PTu3s0A2iFinEUklerQn8eXoOFx6mbWWq7zeKvx kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2wqqra91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 14:47:36 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 322Ee6rZ017932;
        Thu, 2 Mar 2023 14:47:36 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2wqqra8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 14:47:36 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 322D4EXT024469;
        Thu, 2 Mar 2023 14:47:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nybe9webh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 14:47:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 322ElY1S39518898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Mar 2023 14:47:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F3BE58043;
        Thu,  2 Mar 2023 14:47:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AD3358061;
        Thu,  2 Mar 2023 14:47:33 +0000 (GMT)
Received: from sig-9-65-219-109.ibm.com (unknown [9.65.219.109])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  2 Mar 2023 14:47:33 +0000 (GMT)
Message-ID: <d235810e8d352e4ebcd177dfb512f590eb3720aa.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 02 Mar 2023 09:47:32 -0500
In-Reply-To: <f1400ec253c961fb7bf321f6a0a44c75e15940c2.camel@huaweicloud.com>
References: <20230228175859.193798-1-roberto.sassu@huaweicloud.com>
         <0d74908c26c59c9605c80060fd78f543f2f4f470.camel@linux.ibm.com>
         <f1400ec253c961fb7bf321f6a0a44c75e15940c2.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OADcGT73QcZ2lLDaFEROQAuHfU23By57
X-Proofpoint-ORIG-GUID: lb_hOOrE07ROoFze8bl8He4n3LDZRpqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_08,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303020126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-03-02 at 13:40 +0100, Roberto Sassu wrote:
> On Wed, 2023-03-01 at 19:18 -0500, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > Just a couple of comments below.
> > 
> > 
> > > diff --git a/tests/ima_policy_check.test b/tests/ima_policy_check.test
> > > new file mode 100755
> > > index 00000000000..3549009bb1c
> > > --- /dev/null
> > > +++ b/tests/ima_policy_check.test
> > > @@ -0,0 +1,245 @@
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
> > > +# ima_policy_check.awk returns a bit mask with the following values:
> > > +# - 1: invalid new rule;
> > > +# - 2: overlap of the new rule with an existing rule in the IMA policy;
> > > +# - 4: new rule exists in the IMA policy.
> > > +
> > > +# Basic checks.
> > > +desc="empty IMA policy"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy=""
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Empty new rule"
> > > +rule=""
> > > +ima_policy=""
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 1
> > > +
> > > +desc="Unknown policy keyword fun"
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
> > > +desc="Non-overlapping by action measure/dont_appraise, same func"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy="dont_appraise func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by action audit/dont_appraise, same func"
> > > +rule="audit func=FILE_CHECK"
> > > +ima_policy="dont_appraise func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by action appraise/dont_measure, same func"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="dont_measure func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by action dont_measure/hash, same func"
> > > +rule="dont_measure func=FILE_CHECK"
> > > +ima_policy="hash func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by func"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy="measure func=MMAP_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by uid, func is equal"
> > > +rule="measure func=FILE_CHECK uid=0"
> > > +ima_policy="measure uid=1 func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by uid, func is equal, same policy options"
> > > +rule="measure func=FILE_CHECK uid=0 permit_directio"
> > > +ima_policy="measure uid=1 func=FILE_CHECK permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by mask, func and uid are equal, same policy options"
> > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > +ima_policy="measure uid=0 mask=MAY_EXEC func=FILE_CHECK permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="Non-overlapping by mask, func and uid are equal, different policy options"
> > > +rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
> > > +ima_policy="measure uid=0 mask=MAY_EXEC func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +# Overlapping and different rules.
> > > +desc="same actions, different keywords"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="appraise uid=0"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="unrelated actions with appraise and a do action, same func"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="measure func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > 
> > All the different actions - appraise, measure, audit - are applied for
> > the same hook.  If the appraise rule func is "FILE_CHECK", then for any
> > other func, the rules would overlap. 
> 
> Hi Mimi
> 
> yes. But also, if two tests add respectively appraise func=MMAP_CHECK
> and measure func=FILE_CHECK, if we say that they don't overlap, we are
> implying that there won't be mmap operations in the second test.

With this understanding of what constitutes overlapping rules, then a
"measure func=FILE_CHECK" rule should overlap with all other rules. 
Why limit it to the same hook?

> 
> I would be more on the safe side, and say that if there is an appraise
> rule, different func values won't lead to no overlap.

Ok, at least adding a comment explaining what is meant by overlap in
this case would help.

> 
> > > +
> > > +desc="related actions, same func"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy="dont_measure func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="related actions, same func, different policy options"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy="dont_measure func=FILE_CHECK permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="related actions, same func, different policy options"
> > > +rule="measure func=FILE_CHECK permit_directio"
> > > +ima_policy="dont_measure func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="same actions, same func, same mask with different modifier"
> > > +rule="measure func=FILE_CHECK mask=MAY_EXEC"
> > > +ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="same actions, same func, different mask with same modifier"
> > > +rule="measure func=FILE_CHECK mask=^MAY_READ"
> > > +ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="same actions, same func, different policy options"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy="measure func=FILE_CHECK permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="same actions, same func, different policy options"
> > > +rule="measure func=FILE_CHECK permit_directio"
> > > +ima_policy="measure func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="same actions, MMAP_CHECK and MMAP_CHECK_REQPROT hooks"
> > > +rule="measure func=MMAP_CHECK"
> > > +ima_policy="measure func=MMAP_CHECK_REQPROT"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +desc="related actions, same func, same mask with same modifier"
> > > +rule="measure func=FILE_CHECK mask=^MAY_EXEC"
> > > +ima_policy="dont_measure func=FILE_CHECK mask=^MAY_EXEC"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +desc="same actions, same func, different uid with same operator"
> > > +rule="measure func=FILE_CHECK uid>0"
> > > +ima_policy="measure func=FILE_CHECK uid>1"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > 
> > Please add a comment here before the < > test, indicating these
> > operators are currently not supported.
> 
> > > +desc="same actions, same func, same uid with different operator"
> > > +rule="measure func=FILE_CHECK uid>1"
> > > +ima_policy="measure func=FILE_CHECK uid<1"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 2
> > > +
> > > +# Overlapping and same rules.
> > > +desc="same actions, same func"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="appraise func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > +
> > > +desc="same actions, same func, same mask"
> > > +rule="appraise mask=MAY_READ func=FILE_CHECK"
> > > +ima_policy="appraise func=FILE_CHECK mask=MAY_READ"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > +
> > > +desc="same actions, same func, same mask, same policy options"
> > > +rule="appraise mask=MAY_READ func=FILE_CHECK permit_directio appraise_type=imasig"
> > > +ima_policy="appraise func=FILE_CHECK mask=MAY_READ permit_directio appraise_type=imasig"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > +
> > > +desc="same actions, same func"
> > > +rule="measure func=MMAP_CHECK_REQPROT"
> > > +ima_policy="measure func=MMAP_CHECK_REQPROT"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > +
> > > +desc="same actions, same func with alias"
> > > +rule="measure func=FILE_CHECK"
> > > +ima_policy="measure func=PATH_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4

Aliases should probably be classified as duplicate rules.  For now this
is fine, since aliases are deprecated and should be removed.   Perhaps
comment it.

> > > +
> > > +desc="same actions, same func with alias, same mask with same modifiers"
> > > +rule="measure mask=^MAY_READ func=FILE_CHECK"
> > > +ima_policy="measure func=PATH_CHECK mask=^MAY_READ"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > +
> > > +desc="same actions, same func with alias and same mask with same modifiers, same uid with same operators"
> > > +rule="measure mask=^MAY_READ uid>0 func=FILE_CHECK"
> > > +ima_policy="measure func=PATH_CHECK mask=^MAY_READ uid>0"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > +
> > > +desc="same actions, same func with alias and same mask with same modifiers, same uid with same operators"
> > > +rule="measure mask=^MAY_READ uid<1 func=FILE_CHECK"
> > > +ima_policy="measure func=PATH_CHECK mask=^MAY_READ uid<1"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4
> > > +
> > > +# Overlapping and two rules (one same, one different).
> > > +desc="first: same actions, same func, second: unrelated actions with appraise and a do action"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="appraise func=FILE_CHECK\nmeasure func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > 
> > Refer to comment above on different action rules for same func.
> > 
> > > +desc="first: unrelated actions with appraise and a do action, same func, second: same actions"
> > > +rule="appraise func=FILE_CHECK"
> > > +ima_policy="measure func=FILE_CHECK\nappraise func=FILE_CHECK"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > > +
> > > +desc="first: same actions, same func, same mask, second: different policy options"
> > > +rule="appraise mask=MAY_READ func=FILE_CHECK"
> > > +ima_policy="appraise func=FILE_CHECK mask=MAY_READ\nappraise func=FILE_CHECK mask=MAY_READ permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > > +
> > > +desc="first: same actions, same func with alias, same mask, second: different policy options"
> > > +rule="appraise mask=MAY_READ func=FILE_CHECK"
> > > +ima_policy="appraise func=PATH_CHECK mask=MAY_READ\nappraise func=FILE_CHECK mask=MAY_READ permit_directio"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 6
> > > +
> > > +# Non-overlapping and three rules.
> > > +desc="same actions, same func and mask, different uid"
> > > +rule="appraise mask=MAY_READ func=FILE_CHECK uid=0"
> > > +ima_policy="appraise mask=MAY_READ func=FILE_CHECK uid=1\nappraise mask=MAY_READ func=FILE_CHECK uid=2\nappraise mask=MAY_READ func=FILE_CHECK uid=3"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 0
> > > +
> > > +desc="same actions, same func and mask, different uid, except one that is the same"
> > > +rule="appraise mask=MAY_READ func=FILE_CHECK uid=0"
> > > +ima_policy="appraise mask=MAY_READ func=FILE_CHECK uid=1\nappraise mask=MAY_READ func=FILE_CHECK uid=0\nappraise mask=MAY_READ func=FILE_CHECK uid=3"
> > > +expect_pass check_result "$desc" "$rule" "$ima_policy" 4

-- 
thanks,

Mimi

