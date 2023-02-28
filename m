Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871416A5E79
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 18:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjB1R73 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Feb 2023 12:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjB1R73 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Feb 2023 12:59:29 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4490241F0
        for <linux-integrity@vger.kernel.org>; Tue, 28 Feb 2023 09:59:25 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PR4dk24fdz9xtRv
        for <linux-integrity@vger.kernel.org>; Wed,  1 Mar 2023 01:50:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3wVjoQP5jjvlbAQ--.5659S2;
        Tue, 28 Feb 2023 18:59:10 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v3] Add ima_policy_check.awk and ima_policy_check.test
Date:   Tue, 28 Feb 2023 18:58:59 +0100
Message-Id: <20230228175859.193798-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwD3wVjoQP5jjvlbAQ--.5659S2
X-Coremail-Antispam: 1UD129KBjvAXoWfZw4fKFW3ZrWDZw1DuFWDXFb_yoW8trWfto
        WfKrs8tF4UKFW5Cw1UCFsrtrWUWa4Sgr4kJrW5XFnYyFn2gr4kKa95Xw15ZFWkGan8XF1a
        ka4xW3s3JFZ7Gas3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5i7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Gr0_Zr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0rhL5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj4YNjgACsy
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add ima_policy_check.awk to check for possible overlapping of a rule being
added by a test with the existing IMA policy (policy replacement by IMA at
the first policy load is not taken into account).

ima_policy_check.awk expects as input the rule to be added, followed by the
IMA policy.

It returns a bit mask with the following values:
- 1: invalid new rule;
- 2: overlap of the new rule with an existing rule in the IMA policy;
- 4: new rule exists in the IMA policy.

Values can be individually checked by the test executing the awk script, to
determine what to do (abort loading, print a warning in case of overlap,
avoid adding an existing rule).

The bit mask allows the test to see multiple statements regarding the new
rule. For example, if the test added anyway an overlapping rule, it could
also see that the policy already contains it at the next test execution,
and does not add it again.

Since ima_policy_check.awk uses GNU extensions (such as the or() function,
or the fourth argument of split()), add gawk as dependency for the CI.

Finally add ima_policy_check.test, to ensure that the awk script behaves as
expected.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---

Changelog

v2:
- Introduce new non-overlap criteria (unrelated actions, no combination
  of appraise with a do action)
- Add the _idx suffix to variables in for() to better represent their use
- Fix comment in the test with fun= (suggested by Mimi)
- Add four tests at the beginning of the "Non-overlapping rules" section,
  to check the new non-overlap criteria
- For the policy keyword non-overlap criteria, use the same action
  (reported by Mimi)
- Use the related/unrelated words in the test description to better
  specify the relationship between the two actions
- Add a missing 'with alias' in the description of a test
- Same action -> same actions, for consistency
- Add same func and mask in the last two tests
- Add explanation of ima_policy_check.awk return values in
  ima_policy_check.test (suggested by Mimi)

v1:
- Add gawk dependency
- Just check overlapping, so that possible interference can be reported
  (suggested by Mimi)
- Return a bit mask with different statements from the overlap analysis
- Consider different actions as overlapping (appraise rules could interfer
  with measure rules)
- Store the new and current rule in two separate arrays, and check
  differences for each possible key
- Correctly handle < > operators (format: key>value and key<value)
- Differentiate between < > operators and ^ modifier (modifier after =)
- Adjust tests according to the new goal, which is to detect overlapping

 ci/alpine.sh                |   3 +-
 ci/debian.sh                |   3 +-
 ci/tumbleweed.sh            |   3 +-
 tests/Makefile.am           |   2 +-
 tests/ima_policy_check.awk  | 204 ++++++++++++++++++++++++++++++
 tests/ima_policy_check.test | 245 ++++++++++++++++++++++++++++++++++++
 6 files changed, 456 insertions(+), 4 deletions(-)
 create mode 100755 tests/ima_policy_check.awk
 create mode 100755 tests/ima_policy_check.test

diff --git a/ci/alpine.sh b/ci/alpine.sh
index 6b17942a43f..0ab648e45e8 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -45,7 +45,8 @@ apk add \
 	util-linux \
 	wget \
 	which \
-	xxd
+	xxd \
+	gawk
 
 if [ ! "$TSS" ]; then
 	apk add git
diff --git a/ci/debian.sh b/ci/debian.sh
index 431203aabb4..76761912a81 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -53,7 +53,8 @@ $apt \
 	sudo \
 	util-linux \
 	wget \
-	xsltproc
+	xsltproc \
+	gawk
 
 $apt xxd || $apt vim-common
 $apt libengine-gost-openssl1.1$ARCH || true
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index 6f70b0fcc76..c4bd75ea413 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -42,7 +42,8 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	vim \
 	wget \
 	which \
-	xsltproc
+	xsltproc \
+	gawk
 
 zypper --non-interactive install --force-resolution --no-recommends \
 	gnutls openssl-engine-libp11 softhsm || true
diff --git a/tests/Makefile.am b/tests/Makefile.am
index a0463b7b5b5..9a7d8a1f989 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -2,7 +2,7 @@ check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
 check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test \
-		 fsverity.test portable_signatures.test
+		 fsverity.test portable_signatures.test ima_policy_check.test
 
 .PHONY: check_logs
 check_logs:
diff --git a/tests/ima_policy_check.awk b/tests/ima_policy_check.awk
new file mode 100755
index 00000000000..33c0ea8d6b1
--- /dev/null
+++ b/tests/ima_policy_check.awk
@@ -0,0 +1,204 @@
+#! /usr/bin/gawk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
+#
+# Check a new rule against the loaded IMA policy.
+#
+# Documentation/ABI/testing/ima_policy (Linux kernel)
+# base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
+#	[uid=] [euid=] [gid=] [egid=]
+#	[fowner=] [fgroup=]]
+# lsm:	[[subj_user=] [subj_role=] [subj_type=]
+#	[obj_user=] [obj_role=] [obj_type=]]
+# option:	[digest_type=] [template=] [permit_directio]
+#		[appraise_type=] [appraise_flag=]
+#		[appraise_algos=] [keyrings=]
+#
+# Rules don't overlap if their actions are unrelated (cannot be matched without
+# dont_) and there is no combination of appraise with another do action (e.g.
+# measure, audit, hash). The second condition is due to the fact that appraise
+# might still forbid other actions expected to be performed by a test that did
+# not setup appraisal. Checking appraise for new rules is not sufficient,
+# because that rule could be added anyway. By checking existing rules as well,
+# a warning will be displayed when tests inserting rules with other do actions
+# are reexecuted.
+#
+# Also, rules don't overlap if both include the same policy keyword(s) (in base
+# or lsm), at least one, with a different value. Currently, the < > operators
+# and the ^ modifier are not supported and overlap is asserted even if intervals
+# are disjoint. Also, despite the MMAP_CHECK and MMAP_CHECK_REQPROT hooks have
+# different names, they are basically the same hook but with different behavior
+# depending on external factors, so also in this case overlap has to be
+# asserted. Finally, the existing aliases PATH_CHECK and FILE_MMAP are converted
+# to the current hook names, respectively FILE_CHECK and MMAP_CHECK.
+#
+# Rule equivalence is determined by checking each key/value pair, regardless of
+# their order. However, the action must always be at the beginning of the rules.
+# Rules with aliases are considered equivalent.
+#
+# Return a bit mask with the following values:
+# - 1: invalid new rule;
+# - 2: overlap of the new rule with an existing rule in the IMA policy;
+# - 4: new rule exists in the IMA policy.
+
+BEGIN {
+	# Policy definitions.
+	actions_str="measure dont_measure appraise dont_appraise audit hash dont_hash"
+	split(actions_str, actions_array);
+	keywords_str="func mask fsmagic fsuuid fsname uid euid gid egid fowner fgroup subj_user subj_role subj_type obj_user obj_role obj_type";
+	split(keywords_str, keywords_array);
+	options_str="digest_type template permit_directio appraise_type appraise_flag appraise_algos keyrings";
+	split(options_str, options_array);
+
+	# Key types.
+	key_type_unknown=0;
+	key_type_action=1;
+	key_type_keyword=2;
+	key_type_option=3;
+
+	# Result values.
+	ret_invalid_rule=1;
+	ret_rule_overlap=2;
+	ret_same_rule_exists=4;
+
+	for (action_idx in actions_array)
+		key_types[actions_array[action_idx]]=key_type_action;
+	for (keyword_idx in keywords_array)
+		key_types[keywords_array[keyword_idx]]=key_type_keyword;
+	for (option_idx in options_array)
+		key_types[options_array[option_idx]]=key_type_option;
+
+	new_rule=1;
+	result=0;
+}
+{
+	# Delete arrays from previous rule.
+	if (!new_rule) {
+		delete current_rule_array;
+		delete current_rule_operator_array;
+	}
+
+	# Check empty rules.
+	if (!length($0)) {
+		if (new_rule) {
+			result=or(result, ret_invalid_rule);
+			exit;
+		}
+		next;
+	}
+
+	for (i=1; i<=NF; i++) {
+		# Parse key/value pair.
+		split($i, key_value_array, /[=,>,<]/, separator_array);
+		key=key_value_array[1];
+		value=key_value_array[2];
+
+		if (key == "func") {
+			# Normalize values of IMA hooks to what IMA will print.
+			if (value == "FILE_MMAP")
+				value="MMAP_CHECK";
+			else if (value == "PATH_CHECK")
+				value="FILE_CHECK";
+		}
+
+		# Basic validity check (not necessary in general for the IMA policy, but useful to find typos in the tests).
+		if (key_types[key] == key_type_unknown ||
+		    (i == 1 && key_types[key] != key_type_action)) {
+			result=or(result, ret_invalid_rule);
+			exit;
+		}
+
+		# Store key/value pair and operator into an array.
+		if (new_rule) {
+			new_rule_array[key]=value;
+			new_rule_operator_array[key]=separator_array[1];
+		} else {
+			current_rule_array[key]=value;
+			current_rule_operator_array[key]=separator_array[1];
+		}
+
+		# Store original action and action without dont_.
+		if (i == 1) {
+			if (new_rule) {
+				new_rule_action=key;
+				new_rule_action_sub=key;
+				gsub(/dont_/, "", new_rule_action_sub);
+			} else {
+				current_rule_action=key;
+				current_rule_action_sub=key;
+				gsub(/dont_/, "", current_rule_action_sub);
+			}
+		}
+	}
+
+	# Go to the next line, to compare the new rule with rules in the IMA policy.
+	if (new_rule) {
+		new_rule=0;
+		next;
+	}
+
+	# No overlap by action (unrelated rules and no combination appraise - <do action>), new rule safe to add to the IMA policy.
+	if (current_rule_action_sub != new_rule_action_sub &&
+	    (current_rule_action != "appraise" || new_rule_action ~ /^dont_/) &&
+	    (new_rule_action != "appraise" || current_rule_action ~ /^dont_/))
+		next;
+
+	same_rule=1;
+	overlap_rule=1;
+
+	for (key in key_types) {
+		if (!(key in new_rule_array)) {
+			# Key in current rule but not in new rule.
+			if (key in current_rule_array)
+				same_rule=0;
+			# Key not in new rule and not in current rule.
+			continue;
+		}
+
+		if (!(key in current_rule_array)) {
+			# Key in new rule but not in current rule.
+			if (key in new_rule_array)
+				same_rule=0;
+			# Key not in current rule and not in new rule.
+			continue;
+		}
+
+		# Same value and operator.
+		if (new_rule_array[key] == current_rule_array[key] &&
+		    new_rule_operator_array[key] == current_rule_operator_array[key])
+			continue;
+
+		# Different value and/or operator.
+		same_rule=0;
+
+		# Not a policy keyword, not useful to determine overlap.
+		if (key_types[key] != key_type_keyword)
+			continue;
+
+		# > < operators are not supported, cannot determine overlap.
+		if (new_rule_operator_array[key] != "=" || current_rule_operator_array[key] != "=")
+			continue;
+
+		# ^ modifier is not supported, cannot determine overlap.
+		if (new_rule_array[key] ~ /^\^/ || current_rule_array[key] ~ /^\^/)
+			continue;
+
+		# MMAP_CHECK and MMAP_CHECK_REQPROT are basically the same hook but with different behavior, cannot determine overlap.
+		if (key == "func" && new_rule_array[key] ~ /MMAP_CHECK/ && current_rule_array[key] ~ /MMAP_CHECK/) {
+			continue;
+		}
+
+		# No overlap by policy keyword, new rule safe to add to the IMA policy.
+		overlap_rule=0;
+		next;
+	}
+
+	if (same_rule)
+		result=or(result, ret_same_rule_exists);
+	else if (overlap_rule)
+		result=or(result, ret_rule_overlap);
+}
+END {
+	exit result;
+}
diff --git a/tests/ima_policy_check.test b/tests/ima_policy_check.test
new file mode 100755
index 00000000000..3549009bb1c
--- /dev/null
+++ b/tests/ima_policy_check.test
@@ -0,0 +1,245 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2023 Roberto Sassu <roberto.sassu@huawei.com>
+#
+# Test for ima_policy_check.awk
+
+trap '_report_exit_and_cleanup' SIGINT SIGTERM EXIT
+
+cd "$(dirname "$0")" || exit 1
+. ./functions.sh
+
+export PATH=$PWD:$PATH
+
+check_result() {
+	local result
+
+	echo -e "\nTest: $1"
+	echo "New rule: $2"
+	echo "IMA policy: $3"
+
+	echo -n "Result (expect $4): "
+
+	echo -e "$2\n$3" | ima_policy_check.awk
+	result=$?
+
+	if [ "$result" -ne "$4" ]; then
+		echo "${RED}$result${NORM}"
+		return "$FAIL"
+	fi
+
+	echo "${GREEN}$result${NORM}"
+	return "$OK"
+}
+
+# ima_policy_check.awk returns a bit mask with the following values:
+# - 1: invalid new rule;
+# - 2: overlap of the new rule with an existing rule in the IMA policy;
+# - 4: new rule exists in the IMA policy.
+
+# Basic checks.
+desc="empty IMA policy"
+rule="measure func=FILE_CHECK"
+ima_policy=""
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Empty new rule"
+rule=""
+ima_policy=""
+expect_pass check_result "$desc" "$rule" "$ima_policy" 1
+
+desc="Unknown policy keyword fun"
+rule="measure fun=FILE_CHECK"
+ima_policy=""
+expect_pass check_result "$desc" "$rule" "$ima_policy" 1
+
+desc="Missing action"
+rule="func=FILE_CHECK"
+ima_policy=""
+expect_pass check_result "$desc" "$rule" "$ima_policy" 1
+
+# Non-overlapping rules.
+desc="Non-overlapping by action measure/dont_appraise, same func"
+rule="measure func=FILE_CHECK"
+ima_policy="dont_appraise func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by action audit/dont_appraise, same func"
+rule="audit func=FILE_CHECK"
+ima_policy="dont_appraise func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by action appraise/dont_measure, same func"
+rule="appraise func=FILE_CHECK"
+ima_policy="dont_measure func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by action dont_measure/hash, same func"
+rule="dont_measure func=FILE_CHECK"
+ima_policy="hash func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by func"
+rule="measure func=FILE_CHECK"
+ima_policy="measure func=MMAP_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by uid, func is equal"
+rule="measure func=FILE_CHECK uid=0"
+ima_policy="measure uid=1 func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by uid, func is equal, same policy options"
+rule="measure func=FILE_CHECK uid=0 permit_directio"
+ima_policy="measure uid=1 func=FILE_CHECK permit_directio"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by mask, func and uid are equal, same policy options"
+rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
+ima_policy="measure uid=0 mask=MAY_EXEC func=FILE_CHECK permit_directio"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="Non-overlapping by mask, func and uid are equal, different policy options"
+rule="measure func=FILE_CHECK uid=0 permit_directio mask=MAY_READ"
+ima_policy="measure uid=0 mask=MAY_EXEC func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+# Overlapping and different rules.
+desc="same actions, different keywords"
+rule="appraise func=FILE_CHECK"
+ima_policy="appraise uid=0"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="unrelated actions with appraise and a do action, same func"
+rule="appraise func=FILE_CHECK"
+ima_policy="measure func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="related actions, same func"
+rule="measure func=FILE_CHECK"
+ima_policy="dont_measure func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="related actions, same func, different policy options"
+rule="measure func=FILE_CHECK"
+ima_policy="dont_measure func=FILE_CHECK permit_directio"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="related actions, same func, different policy options"
+rule="measure func=FILE_CHECK permit_directio"
+ima_policy="dont_measure func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="same actions, same func, same mask with different modifier"
+rule="measure func=FILE_CHECK mask=MAY_EXEC"
+ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="same actions, same func, different mask with same modifier"
+rule="measure func=FILE_CHECK mask=^MAY_READ"
+ima_policy="measure func=FILE_CHECK mask=^MAY_EXEC"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="same actions, same func, different policy options"
+rule="measure func=FILE_CHECK"
+ima_policy="measure func=FILE_CHECK permit_directio"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="same actions, same func, different policy options"
+rule="measure func=FILE_CHECK permit_directio"
+ima_policy="measure func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="same actions, MMAP_CHECK and MMAP_CHECK_REQPROT hooks"
+rule="measure func=MMAP_CHECK"
+ima_policy="measure func=MMAP_CHECK_REQPROT"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="related actions, same func, same mask with same modifier"
+rule="measure func=FILE_CHECK mask=^MAY_EXEC"
+ima_policy="dont_measure func=FILE_CHECK mask=^MAY_EXEC"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="same actions, same func, different uid with same operator"
+rule="measure func=FILE_CHECK uid>0"
+ima_policy="measure func=FILE_CHECK uid>1"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+desc="same actions, same func, same uid with different operator"
+rule="measure func=FILE_CHECK uid>1"
+ima_policy="measure func=FILE_CHECK uid<1"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 2
+
+# Overlapping and same rules.
+desc="same actions, same func"
+rule="appraise func=FILE_CHECK"
+ima_policy="appraise func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+desc="same actions, same func, same mask"
+rule="appraise mask=MAY_READ func=FILE_CHECK"
+ima_policy="appraise func=FILE_CHECK mask=MAY_READ"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+desc="same actions, same func, same mask, same policy options"
+rule="appraise mask=MAY_READ func=FILE_CHECK permit_directio appraise_type=imasig"
+ima_policy="appraise func=FILE_CHECK mask=MAY_READ permit_directio appraise_type=imasig"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+desc="same actions, same func"
+rule="measure func=MMAP_CHECK_REQPROT"
+ima_policy="measure func=MMAP_CHECK_REQPROT"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+desc="same actions, same func with alias"
+rule="measure func=FILE_CHECK"
+ima_policy="measure func=PATH_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+desc="same actions, same func with alias, same mask with same modifiers"
+rule="measure mask=^MAY_READ func=FILE_CHECK"
+ima_policy="measure func=PATH_CHECK mask=^MAY_READ"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+desc="same actions, same func with alias and same mask with same modifiers, same uid with same operators"
+rule="measure mask=^MAY_READ uid>0 func=FILE_CHECK"
+ima_policy="measure func=PATH_CHECK mask=^MAY_READ uid>0"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+desc="same actions, same func with alias and same mask with same modifiers, same uid with same operators"
+rule="measure mask=^MAY_READ uid<1 func=FILE_CHECK"
+ima_policy="measure func=PATH_CHECK mask=^MAY_READ uid<1"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
+
+# Overlapping and two rules (one same, one different).
+desc="first: same actions, same func, second: unrelated actions with appraise and a do action"
+rule="appraise func=FILE_CHECK"
+ima_policy="appraise func=FILE_CHECK\nmeasure func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 6
+
+desc="first: unrelated actions with appraise and a do action, same func, second: same actions"
+rule="appraise func=FILE_CHECK"
+ima_policy="measure func=FILE_CHECK\nappraise func=FILE_CHECK"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 6
+
+desc="first: same actions, same func, same mask, second: different policy options"
+rule="appraise mask=MAY_READ func=FILE_CHECK"
+ima_policy="appraise func=FILE_CHECK mask=MAY_READ\nappraise func=FILE_CHECK mask=MAY_READ permit_directio"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 6
+
+desc="first: same actions, same func with alias, same mask, second: different policy options"
+rule="appraise mask=MAY_READ func=FILE_CHECK"
+ima_policy="appraise func=PATH_CHECK mask=MAY_READ\nappraise func=FILE_CHECK mask=MAY_READ permit_directio"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 6
+
+# Non-overlapping and three rules.
+desc="same actions, same func and mask, different uid"
+rule="appraise mask=MAY_READ func=FILE_CHECK uid=0"
+ima_policy="appraise mask=MAY_READ func=FILE_CHECK uid=1\nappraise mask=MAY_READ func=FILE_CHECK uid=2\nappraise mask=MAY_READ func=FILE_CHECK uid=3"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 0
+
+desc="same actions, same func and mask, different uid, except one that is the same"
+rule="appraise mask=MAY_READ func=FILE_CHECK uid=0"
+ima_policy="appraise mask=MAY_READ func=FILE_CHECK uid=1\nappraise mask=MAY_READ func=FILE_CHECK uid=0\nappraise mask=MAY_READ func=FILE_CHECK uid=3"
+expect_pass check_result "$desc" "$rule" "$ima_policy" 4
-- 
2.25.1

