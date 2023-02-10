Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60B6924D2
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 18:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjBJRuc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 12:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjBJRuS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 12:50:18 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0771C7CE
        for <linux-integrity@vger.kernel.org>; Fri, 10 Feb 2023 09:50:15 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AHll62000556;
        Fri, 10 Feb 2023 17:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=G/TuZlfCQK7uYq5bIREC026aUXkT/QZMQvNU5oAgq/0=;
 b=hORiDQgp6zUp7F4rt1vxqhog9bZvehnXsbdxg8NHNnwmgwxMCutEiWGW6Ca9INnRl5jT
 YAbKDOxfrEzHUaKjs34sfgMPYbeAnwR6cUugurvAj94TC9oTbCp1xX8SD+ohmR7hwyMf
 +GQmoh4qvZ/+DXhmUSG9fDwJ7TD7BHbcLUF9k3aqOgBUanUMA/k9NoyEjzZCoegEptcH
 6as6QgPWhkt+Odh7cfIGV1R4bf7GYWgh7QprWBOR2QsvtONE5cK5vCwXGMial7q5VYYM
 Ro+v9OYpbh3YCquki9N7hcK761v5a3kDIoo4+Hx+5GEHC+hI9uoVMfHdOn9kTd04tGZr Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nntmtg0yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 17:49:45 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31AHniqp008789;
        Fri, 10 Feb 2023 17:49:44 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nntmtg0ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 17:49:44 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFCv08003488;
        Fri, 10 Feb 2023 17:49:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07r4st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 17:49:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AHnh4W25100636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 17:49:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBC6E58054;
        Fri, 10 Feb 2023 17:49:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19BC95804E;
        Fri, 10 Feb 2023 17:49:42 +0000 (GMT)
Received: from sig-9-77-142-160.ibm.com (unknown [9.77.142.160])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 17:49:41 +0000 (GMT)
Message-ID: <d92def2ea2bfbbb21bad4278860f1ab418ea10e1.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Add ima_policy_check.awk and
 ima_policy_check.test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 10 Feb 2023 12:49:36 -0500
In-Reply-To: <6eacde8a2be5e7256b4758999d5b99d846ccf3ce.camel@huaweicloud.com>
References: <20230209172759.3144105-1-roberto.sassu@huaweicloud.com>
         <6eacde8a2be5e7256b4758999d5b99d846ccf3ce.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xBAY_o-fmORCXH5jg309MzjdclBLvrjh
X-Proofpoint-ORIG-GUID: 1DuxqZ3i33Vcmf-XUhFEJvRbIzY3gdQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_12,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-02-10 at 15:34 +0100, Roberto Sassu wrote:
> On Thu, 2023-02-09 at 18:27 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add the awk script to check for possible interference of a rule added by a
> > test with the existing IMA policy (policy replacement at the first policy
> > load is not taken into account).
> > 
> > The script expects the rule to be added to be the first, and the existing
> > IMA policy to be after.
> > 
> > Rules are considered as interfering if they don't overlap, or they overlap
> > but they have the same action and same policy options with the same values.
> 
> Rules are considered as not interfering...
> 
> However, if rules with the same action overlap, they can interfer too.
> 
> Example, suppose that the policy is:
> 
> measure func=FILE_CHECK
> 
> and we want to add:
> 
> measure func=MMAP_CHECK
> 
> If the goal of the test is to have the file measured, the fact that
> there are other rules with the same action that might or might not
> match is irrelevant. The important thing is that the file is measured.
> 
> However, if the goal is to have the file measured in specific
> conditions, then overlapping rules can become a problem.
> 
> test_mmap is opening the file created by the test, to get a file
> descriptor and pass it to mmap(). The goal of the test is to show that
> no measurement entry is created if the protections passed to mmap() are
> just PROT_READ.
> 
> This test fails, because the existing rule with the FILE_CHECK hook
> causes the file to be measured, while the test didn't expect that (the
> new rule causes a new measurement entry to be added when the
> protections passed to mmap() contain PROT_EXEC).
> 
> I think it is too complicated to determine if the current configuration
> could interfer with the tests. We should simply ensure that tests use
> non-overlapping rules or existing rules.

Thank you for taking the time on how to detect "interferring" policy
rules.  At some point, we probably will need to come back to this
topic. 

> We can just print a warning if there are overlapping rules.

Is the problem detecting "interferring" or "overlapping" policy rules? 
If the problem is limited to detecting "interferring" policy rules,
then test for "overlapping" policy rules and warn about "interferring"
policy rules.

Mimi

> 
> > Combinations of MMAP_CHECK and MMAP_CHECK_REQPROT hooks are always
> > considered as interfering, due to the different behavior of those hooks.
> > 
> > Finally add a test, to ensure that the awk script behaves as expected.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  tests/Makefile.am           |   2 +-
> >  tests/ima_policy_check.awk  | 142 ++++++++++++++++
> >  tests/ima_policy_check.test | 319 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 462 insertions(+), 1 deletion(-)
> >  create mode 100755 tests/ima_policy_check.awk
> >  create mode 100755 tests/ima_policy_check.test
> > 
> > diff --git a/tests/Makefile.am b/tests/Makefile.am
> > index a0463b7b5b5..9a7d8a1f989 100644
> > --- a/tests/Makefile.am
> > +++ b/tests/Makefile.am
> > @@ -2,7 +2,7 @@ check_SCRIPTS =
> >  TESTS = $(check_SCRIPTS)
> >  
> >  check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
> > -		 fsverity.test portable_signatures.test
> > +		 fsverity.test portable_signatures.test ima_policy_check.test
> >  
> >  .PHONY: check_logs
> >  check_logs:
> > diff --git a/tests/ima_policy_check.awk b/tests/ima_policy_check.awk
> > new file mode 100755
> > index 00000000000..bb39153c182
> > --- /dev/null
> > +++ b/tests/ima_policy_check.awk
> > @@ -0,0 +1,142 @@
> > +#! /usr/bin/awk -f
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> > +#
> > +# Check possible interference of a new rule with the existing IMA policy.
> > +
> > +# Documentation/ABI/testing/ima_policy (Linux kernel)
> > +# base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
> > +#	[uid=] [euid=] [gid=] [egid=]
> > +#	[fowner=] [fgroup=]]
> > +# lsm:	[[subj_user=] [subj_role=] [subj_type=]
> > +#	[obj_user=] [obj_role=] [obj_type=]]
> > +# option:	[digest_type=] [template=] [permit_directio]
> > +#		[appraise_type=] [appraise_flag=]
> > +#		[appraise_algos=] [keyrings=]
> > +#
> > +# Non interference if:
> > +# - non-overlapping rules (different values for policy keywords)
> > +# - overlapping rules with same action and same policy options
> > +#
> > +# Rules overlap if they have different policy keywords or same policy keywords
> > +# and same values.
> > +#
> > +# The same policy options and value requirement is needed as otherwise tests
> > +# might match an overlapping rule with undesired/missing policy options.
> > +#
> > +# Rules with MMAP_CHECK and MMAP_CHECK_REQPROT are considered as an exception.
> > +# They overlap, despite they have a different name. In addition, combinations of
> > +# them are reported as interference, since they are matched depending on
> > +# external factors, not inferrable from the policy (a MMAP_CHECK rule might
> > +# cause a measurement, while a MMAP_CHECK_REQPROT one might not).
> > +#
> > +# More/less specific rules are considered as overlapping.
> > +#
> > +# Overlapping rules must have the same policy options, or tests might match
> > +# policy rules set by other tests with undesired policy options.
> > +
> > +BEGIN {
> > +	keywords_str="func mask fsmagic fsuuid fsname uid euid gid egid fowner fgroup subj_user subj_role subj_type obj_user obj_role obj_type";
> > +	split(keywords_str, keywords_array, " ");
> > +	options_str="digest_type template permit_directio appraise_type appraise_flag appraise_algos keyrings";
> > +	split(options_str, options_array, " ");
> > +	key_type_unknown=0;
> > +	key_type_keyword=1;
> > +	key_type_option=2;
> > +	for (keyword in keywords_array)
> > +		key_types[keywords_array[keyword]]=key_type_keyword;
> > +	for (option in options_array)
> > +		key_types[options_array[option]]=key_type_option;
> > +	new_rule=1;
> > +	mmap_check_interference=0;
> > +}
> > +{
> > +	if (new_rule) {
> > +		new_rule_action=$1;
> > +		# Strip dont_ from the action of the new rule.
> > +		new_rule_action_sub=new_rule_action;
> > +		gsub(/dont_/, "", new_rule_action_sub);
> > +	} else {
> > +		current_action=$1;
> > +		# Strip dont_ from the action of the current rule.
> > +		current_action_sub=current_action;
> > +		gsub(/dont_/, "", current_action_sub);
> > +		# Unrelated action, ignore.
> > +		if (new_rule_action_sub != current_action_sub) {
> > +			next;
> > +		}
> > +		# Store policy options of the new rule into an array, to compare with the options of the current rule.
> > +		delete new_rule_extra_options;
> > +		for (key in new_rule_array) {
> > +			if (key_types[key] == key_type_option) {
> > +				new_rule_extra_options[key]=new_rule_array[key];
> > +			}
> > +		}
> > +		current_rule_extra_options=0;
> > +	}
> > +	for (i=2; i<=NF; i++) {
> > +		# Parse key/value pair.
> > +		split($i, key_value_array, "=");
> > +		key=key_value_array[1];
> > +		value=key_value_array[2];
> > +		if (key == "func") {
> > +			# Normalize values of IMA hooks.
> > +			if (value == "FILE_MMAP") {
> > +				value="MMAP_CHECK";
> > +			} else if (value == "PATH_CHECK") {
> > +				value="FILE_CHECK";
> > +			}
> > +		}
> > +		# Store key/value pair from the new rule into an array.
> > +		if (new_rule) {
> > +			# Check if the key is valid.
> > +			if (key_types[key] == key_type_unknown) {
> > +				exit 1;
> > +			}
> > +			new_rule_array[key]=value;
> > +		} else {
> > +			if (key_types[key] == key_type_keyword) {
> > +				# No overlap and no operators, no interference.
> > +				if (key in new_rule_array && new_rule_array[key] != value && value !~ /^[<,>,^]/) {
> > +					# Exception: MMAP_CHECK and MMAP_CHECK_REQPROT overlap and have different behavior, interference if overlap (cannot be determined yet).
> > +					if (key == "func" && new_rule_array[key] ~ /MMAP_CHECK/ && value ~ /MMAP_CHECK/) {
> > +						mmap_check_interference=1;
> > +						continue;
> > +					}
> > +					next;
> > +				}
> > +			} else if (key_types[key] == key_type_option) {
> > +				# Possible overlap and different policy options, interference if overlap (cannot be determined yet).
> > +				if (!(key in new_rule_extra_options)) {
> > +					current_rule_extra_options=1;
> > +				# Possible overlap, same policy option and same value, current option can be deleted from the new_rule_extra_options array.
> > +				} else if (new_rule_extra_options[key] == value) {
> > +					delete new_rule_extra_options[key];
> > +				}
> > +				# Possible overlap and same policy option but with different value, interference if overlap (cannot be determined yet).
> > +			}
> > +		}
> > +	}
> > +	# Always ok to parse a new rule.
> > +	if (new_rule) {
> > +		new_rule=0;
> > +		next;
> > +	}
> > +	# Overlap and different related action, interference.
> > +	if (current_action != new_rule_action) {
> > +		exit 1;
> > +	}
> > +	# Overlap and different policy options or different option values, interference.
> > +	for (key in new_rule_extra_options) {
> > +		exit 1;
> > +	}
> > +	if (current_rule_extra_options) {
> > +		exit 1;
> > +	}
> > +	# Overlap and MMAP_CHECK/MMAP_CHECK_REQPROT, interference.
> > +	if (mmap_check_interference) {
> > +		exit 1;
> > +	}
> > +	# Overlap with same related action and same policy options, ok.
> > +}
> > diff --git a/tests/ima_policy_check.test b/tests/ima_policy_check.test
> > new file mode 100755
> > index 00000000000..f1e79ca451f
> > --- /dev/null
> > +++ b/tests/ima_policy_check.test
> > @@ -0,0 +1,319 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
> > +#
> > +# Test for ima_policy_check.awk
> > +
> > +trap '_report_exit_and_cleanup' SIGINT SIGTERM EXIT
> > +
> > +cd "$(dirname "$0")" || exit 1
> > +. ./functions.sh
> > +
> > +export PATH=$PWD:$PATH
> > +
> > +# Base VERBOSE on the environment variable, if set.
> > +VERBOSE="${VERBOSE:-0}"
> > +
> > +check_interference() {
> > +	echo -e "\nTest: $1"
> > +	echo "New rule: $2"
> > +	echo "IMA policy: $3"
> > +
> > +	if [ "$TFAIL" != "yes" ]; then
> > +		echo -n "Result (expect no interference): "
> > +	else
> > +		echo -n "Result (expect interference): "
> > +	fi
> > +
> > +	if ! echo -e "$2\n$3" | ima_policy_check.awk; then
> > +		if [ "$TFAIL" != "yes" ]; then
> > +			echo "${RED}interference${NORM}"
> > +		else
> > +			echo "${GREEN}interference${NORM}"
> > +		fi
> > +		return "$FAIL"
> > +	fi
> > +
> > +	if [ "$TFAIL" != "yes" ]; then
> > +		echo "${GREEN}no interference${NORM}"
> > +	else
> > +		echo "${RED}no interference${NORM}"
> > +	fi
> > +	return "$OK"
> > +}
> > +
> > +# Basic check.
> > +desc="empty IMA policy"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy=""
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Wrong new rule.
> > +desc="Wrong new rule"
> > +rule="measure fun=FILE_CHECK"
> > +ima_policy=""
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Unrelated/related actions.
> > +desc="unrelated actions measure/appraise"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="appraise func=FILE_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="unrelated actions appraise/measure"
> > +rule="appraise func=FILE_CHECK"
> > +ima_policy="measure func=FILE_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="unrelated actions appraise/dont_measure"
> > +rule="appraise func=FILE_CHECK"
> > +ima_policy="dont_measure func=FILE_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="related actions measure/dont_measure"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="dont_measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="related actions dont_measure/measure"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="dont_measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="related actions dont_appraise/appraise"
> > +rule="dont_appraise func=FILE_CHECK"
> > +ima_policy="appraise func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Unrelated rules by different values for policy keywords.
> > +desc="same action, unrelated by func"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="measure func=MMAP_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, unrelated by func"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="dont_measure func=MMAP_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, unrelated by mask"
> > +rule="measure func=FILE_CHECK mask=MAY_EXEC"
> > +ima_policy="dont_measure func=FILE_CHECK mask=MAY_READ"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, unrelated by fowner"
> > +rule="measure func=FILE_CHECK fowner=1 mask=MAY_EXEC"
> > +ima_policy="dont_measure func=FILE_CHECK mask=MAY_EXEC fowner=0"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Unrelated rules with different policy options.
> > +desc="different action, unrelated by fowner, different policy options"
> > +rule="measure func=FILE_CHECK fowner=1 mask=MAY_EXEC"
> > +ima_policy="dont_measure func=FILE_CHECK mask=MAY_EXEC fowner=0 permit_directio"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, unrelated by fowner, different policy options"
> > +rule="measure func=FILE_CHECK fowner=1 mask=MAY_EXEC"
> > +ima_policy="measure func=FILE_CHECK mask=MAY_EXEC fowner=0 permit_directio"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Related rules by different policy keywords.
> > +desc="same action, add with uid, existing with func, no policy options"
> > +rule="measure uid=0"
> > +ima_policy="measure func=FILE_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, add with uid, existing with func, no policy options"
> > +rule="measure uid=0"
> > +ima_policy="dont_measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with uid, existing with func, different policy options"
> > +rule="measure uid=0 permit_directio"
> > +ima_policy="measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with uid, existing with func, different policy options"
> > +rule="measure uid=0"
> > +ima_policy="measure func=FILE_CHECK permit_directio"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with uid, existing with func, same policy options"
> > +rule="measure uid=0 permit_directio"
> > +ima_policy="measure func=FILE_CHECK permit_directio"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Related rules by same policy keywords and same value, with policy options.
> > +desc="same action, add with func, existing with func, same policy options"
> > +rule="measure func=FILE_CHECK permit_directio"
> > +ima_policy="measure func=FILE_CHECK permit_directio"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func, existing with func, different policy options"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="measure func=FILE_CHECK permit_directio"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func, existing with func, different policy options"
> > +rule="measure func=FILE_CHECK permit_directio"
> > +ima_policy="measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, add with func, existing with func, no policy options"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="dont_measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, add with func, existing with func, no policy options"
> > +rule="dont_measure func=FILE_CHECK"
> > +ima_policy="measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, add with func, existing with func, same policy options"
> > +rule="dont_measure func=FILE_CHECK permit_directio"
> > +ima_policy="measure func=FILE_CHECK permit_directio"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, add with func, existing with func, same policy options"
> > +rule="measure func=FILE_CHECK permit_directio"
> > +ima_policy="dont_measure func=FILE_CHECK permit_directio"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Related rules by same policy keywords and different value but with unsupported operator.
> > +desc="different action, add with func and uid, existing with func and different uid"
> > +rule="dont_measure func=FILE_CHECK uid=>0"
> > +ima_policy="measure func=FILE_CHECK uid=>1"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func and different uid"
> > +rule="measure func=FILE_CHECK uid=>0"
> > +ima_policy="measure func=FILE_CHECK uid=>1"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func and different uid, different policy options"
> > +rule="measure func=FILE_CHECK uid=>0 permit_directio"
> > +ima_policy="measure func=FILE_CHECK uid=>1"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func and different uid, same policy options"
> > +rule="measure func=FILE_CHECK uid=>0 permit_directio"
> > +ima_policy="measure func=FILE_CHECK uid=>1 permit_directio"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Related rules by subset/superset policy keywords.
> > +desc="different action, add with func and uid, existing with func"
> > +rule="dont_measure func=FILE_CHECK uid=0"
> > +ima_policy="measure func=FILE_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func"
> > +rule="measure func=FILE_CHECK uid=0"
> > +ima_policy="measure func=FILE_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func"
> > +rule="dont_measure func=FILE_CHECK uid=0"
> > +ima_policy="dont_measure func=FILE_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func, different policy options"
> > +rule="measure func=FILE_CHECK uid=0"
> > +ima_policy="measure func=FILE_CHECK permit_directio"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func, same policy options"
> > +rule="measure func=FILE_CHECK uid=0 permit_directio"
> > +ima_policy="measure func=FILE_CHECK permit_directio"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func, existing with func and uid, same policy options (multiple)"
> > +rule="measure func=FILE_CHECK uid=0 permit_directio appraise_type=imasig"
> > +ima_policy="measure func=FILE_CHECK permit_directio appraise_type=imasig"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, add with func, existing with func and uid"
> > +rule="dont_measure func=FILE_CHECK"
> > +ima_policy="measure func=FILE_CHECK uid=0"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func, existing with func and uid"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="measure func=FILE_CHECK uid=0"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func, existing with func and uid"
> > +rule="dont_measure func=FILE_CHECK"
> > +ima_policy="dont_measure func=FILE_CHECK uid=0"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func and uid, existing with func, different policy options"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="measure func=FILE_CHECK uid=0 permit_directio"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func, existing with func and uid, same policy options"
> > +rule="measure func=FILE_CHECK permit_directio"
> > +ima_policy="measure func=FILE_CHECK uid=0 permit_directio"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, add with func, existing with func and uid, same policy options (multiple)"
> > +rule="measure func=FILE_CHECK permit_directio appraise_type=imasig"
> > +ima_policy="measure func=FILE_CHECK uid=0 permit_directio appraise_type=imasig"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Different policy options in a non-overlapping rule.
> > +desc="same action, add with func, existing with func and uid, no policy options"
> > +rule="measure func=FILE_CHECK uid=1"
> > +ima_policy="measure func=FILE_CHECK permit_directio uid=0"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Same policy option with different value in an overlapping rule.
> > +desc="same action, add with func, existing with func and uid, same policy option with different value"
> > +rule="measure func=FILE_CHECK permit_directio appraise_type=imasig"
> > +ima_policy="measure func=FILE_CHECK uid=0 permit_directio appraise_type=sigv3"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Same policy option with different value in an non-overlapping rule.
> > +desc="same action, add with func and uid, existing with func and different uid, same policy option with different value"
> > +rule="measure func=FILE_CHECK uid=1 permit_directio appraise_type=imasig"
> > +ima_policy="measure func=FILE_CHECK uid=0 permit_directio appraise_type=sigv3"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Same policy option with different value in an non-overlapping rule, uid is the last.
> > +desc="same action, add with func and uid, existing with func and different uid, same policy option with different value"
> > +rule="measure func=FILE_CHECK permit_directio appraise_type=imasig uid=1"
> > +ima_policy="measure func=FILE_CHECK permit_directio appraise_type=sigv3 uid=0"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# MMAP_CHECK and MMAP_CHECK_REQPROT hooks.
> > +desc="same action, MMAP_CHECK and MMAP_CHECK_REQPROT hooks"
> > +rule="measure func=MMAP_CHECK"
> > +ima_policy="measure func=MMAP_CHECK_REQPROT"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="different action, MMAP_CHECK and MMAP_CHECK_REQPROT hooks"
> > +rule="measure func=MMAP_CHECK"
> > +ima_policy="dont_measure func=MMAP_CHECK_REQPROT"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, MMAP_CHECK and MMAP_CHECK_REQPROT hooks, overlapping rules and IMA policy more specific"
> > +rule="measure func=MMAP_CHECK"
> > +ima_policy="measure func=MMAP_CHECK_REQPROT uid=0"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, MMAP_CHECK and MMAP_CHECK_REQPROT hooks, non-overlapping rules"
> > +rule="measure func=MMAP_CHECK uid=1"
> > +ima_policy="measure func=MMAP_CHECK_REQPROT uid=0"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +desc="same action, same hook MMAP_CHECK"
> > +rule="measure func=MMAP_CHECK"
> > +ima_policy="measure func=MMAP_CHECK"
> > +expect_pass check_interference "$desc" "$rule" "$ima_policy"
> > +
> > +# Hook aliases.
> > +desc="different action, FILE_CHECK hook and its alias"
> > +rule="measure func=FILE_CHECK"
> > +ima_policy="dont_measure func=PATH_CHECK"
> > +expect_fail check_interference "$desc" "$rule" "$ima_policy"
> 


