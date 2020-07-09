Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8B219862
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 08:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgGIGTq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jul 2020 02:19:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGIGTq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jul 2020 02:19:46 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 271A420B4908;
        Wed,  8 Jul 2020 23:19:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 271A420B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275585;
        bh=PBJR2VWSgQiKNw2usFRS07g0Idy48d89Sf0Uz877qMU=;
        h=From:To:Cc:Subject:Date:From;
        b=NCC+5K5ASbIROo4qc8xOcOx5xhuHzN8+hSan+HnxFIwZNWU3Xdp7zWWrDZssdjvrZ
         oale286AwkWColrA7SY3VWs6DQBBnM+peOE2X4pjQM0NMfJqKxuHtKicjoJN0p9msd
         CbC1nDd7H/I+OmWfhWJDoHvXX0z9UJO4NZu2oj14=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v3 00/12] ima: Fix rule parsing bugs and extend KEXEC_CMDLINE rule support
Date:   Thu,  9 Jul 2020 01:18:59 -0500
Message-Id: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series ultimately extends the supported IMA rule conditionals for
the KEXEC_CMDLINE hook function. As of today, there's an imbalance in
IMA language conditional support for KEXEC_CMDLINE rules in comparison
to KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK rules. The KEXEC_CMDLINE
rules do not support *any* conditionals so you cannot have a sequence of
rules like this:

 dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
 dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
 dont_measure func=KEXEC_CMDLINE obj_type=foo_t
 measure func=KEXEC_KERNEL_CHECK
 measure func=KEXEC_INITRAMFS_CHECK
 measure func=KEXEC_CMDLINE

Instead, KEXEC_CMDLINE rules can only be measured or not measured and
there's no additional flexibility in today's implementation of the
KEXEC_CMDLINE hook function.

With this series, the above sequence of rules becomes valid and any
calls to kexec_file_load() with a kernel and initramfs inode type of
foo_t will not be measured (that includes the kernel cmdline buffer)
while all other objects given to a kexec_file_load() syscall will be
measured. There's obviously not an inode directly associated with the
kernel cmdline buffer but this patch series ties the inode based
decision making for KEXEC_CMDLINE to the kernel's inode. I think this
will be intuitive to policy authors.

While reading IMA code and preparing to make this change, I realized
that the buffer based hook functions (KEXEC_CMDLINE and KEY_CHECK) are
quite special in comparison to longer standing hook functions. These
buffer based hook functions can only support measure actions and there
are some restrictions on the conditionals that they support. However,
the rule parser isn't enforcing any of those restrictions and IMA policy
authors wouldn't have any immediate way of knowing that the policy that
they wrote is invalid. For example, the sequence of rules above parses
successfully in today's kernel but the
"dont_measure func=KEXEC_CMDLINE ..." rule is incorrectly handled in
ima_match_rules(). The dont_measure rule is *always* considered to be a
match so, surprisingly, no KEXEC_CMDLINE measurements are made.

While making the rule parser more strict, I realized that the parser
does not correctly free all of the allocated memory associated with an
ima_rule_entry when going down some error paths. Invalid policy loaded
by the policy administrator could result in small memory leaks.

I envision patches 1-7 going to stable. The series is ordered in a way
that has all the fixes up front, followed by cleanups, followed by the
feature patch. The breakdown of patches looks like so:

 Memory leak fixes: 1-3
 Parser strictness fixes: 4-7
 Code cleanups made possible by the fixes: 8-11
 Extend KEXEC_CMDLINE rule support: 12

Perhaps the most logical ordering for code review is:

 1, 2, 3, 8, 9, 4, 5, 6, 7, 10, 11, 12

If you'd like me to re-order or split up the series, just let me know.
Thanks for considering these patches!

* Series-wide v3 changes
  - Indentation changes in patch #4 which caused some churn
  - Added patch #7
  - Significant changes to patch #10 to address Mimi's requests
* Series-wide v2 changes
  - Rebased onto next-integrity-testing
  - Squashed patches 2 and 3 from v1
    + Updated this cover letter to account for changes to patch index
      changes
    + See patch 2 for specific code changes

Tyler

Tyler Hicks (12):
  ima: Have the LSM free its audit rule
  ima: Free the entire rule when deleting a list of rules
  ima: Free the entire rule if it fails to parse
  ima: Fail rule parsing when buffer hook functions have an invalid
    action
  ima: Fail rule parsing when the KEXEC_CMDLINE hook is combined with an
    invalid cond
  ima: Fail rule parsing when the KEY_CHECK hook is combined with an
    invalid cond
  ima: Fail rule parsing when appraise_flag=blacklist is unsupportable
  ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
  ima: Use correct type for the args_p member of ima_rule_entry.lsm
    elements
  ima: Move comprehensive rule validation checks out of the token parser
  ima: Use the common function to detect LSM conditionals in a rule
  ima: Support additional conditionals in the KEXEC_CMDLINE hook
    function

 include/linux/ima.h                          |   4 +-
 kernel/kexec_file.c                          |   2 +-
 security/integrity/ima/ima.h                 |  13 +-
 security/integrity/ima/ima_api.c             |   2 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  23 ++-
 security/integrity/ima/ima_modsig.c          |  20 --
 security/integrity/ima/ima_policy.c          | 206 ++++++++++++++-----
 security/integrity/ima/ima_queue_keys.c      |   2 +-
 10 files changed, 182 insertions(+), 94 deletions(-)

-- 
2.25.1

