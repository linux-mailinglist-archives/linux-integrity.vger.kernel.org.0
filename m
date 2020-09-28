Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11E27A607
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 05:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI1D4T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 23:56:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39226 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1D4T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 23:56:19 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id BCECB20B7178;
        Sun, 27 Sep 2020 20:56:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCECB20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601265379;
        bh=/ZKbn+BtdcYwqnMPh/CImefmolSKnKyfq10Qq7zbHdE=;
        h=From:To:Cc:Subject:Date:From;
        b=F8PplHXIjEOHGi7H/NErKYjuXhYbC344HjpTmKTcLkLWUyybK+1UCGN/7nyd3cFfI
         tzBEMBP8o43/3vfW+YfTXx7mJYKpbtPvgBwebqP6DLDt9xy4xL616KoGdm+tEgpP+G
         svAaDFwQ9ngxmSbjpHE7whQeq8HdpPWCL9Zz7EZE=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, pvorel@suse.cz
Cc:     nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        dm-devel@redhat.com, ltp@lists.linux.it
Subject: [PATCH v2 0/2] IMA: Add test for dm-crypt measurement
Date:   Sun, 27 Sep 2020 20:56:03 -0700
Message-Id: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

New functionality is being added to IMA to measure data provided by
kernel components. With this feature, IMA policy can be set to enable
measuring data provided by device-mapper targets. Currently one such
device-mapper target - dm-crypt, is being updated to use this
functionality. This new functionality needs test automation in LTP.

Some of the existing functionality in ima_keys.sh can be reused for
this, but it needs to be refactored into generic functions first.

Add a testcase which verifies that the IMA subsystem correctly measures
the data coming from a device-mapper target - dm-crypt.
Refactor common functionality in ima_keys.sh for this, and move the
generic functions to ima_setup.sh.

This series needs a kernel built on the following repo/branch/patches:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit aa662fc04f5b ("ima: Fix NULL pointer dereference in ima_file_hash")

And the following patch series should be applied in the following order:
 1. https://patchwork.kernel.org/patch/11795559/
 2. https://patchwork.kernel.org/patch/11801525/
 3. https://patchwork.kernel.org/patch/11743715/

Change Log v2:
Incorporated feedback from Petr Vorel on v1.
 - Updated TST_NEEDS_CMDS to correctly reflects commands used in tests.
 - Removed unnecessary debugging info.
 - Refactored common functionality in ima_keys.sh, and moved the generic
   functions to ima_setup.sh.
 - Removed the use of eval, and replaced it with the recommended ROD()
   function.
 - All temporary files now get created under $TST_TMPDIR, instead of
   current directory.
 - Removed unnecessary TFAIL, to avoid double counting failures.
 - Updated log messages to be consistent.
 - Moved code to cleanup() to avoid code duplication.

Tushar Sugandhi (2):
  IMA: generalize key measurement tests
  IMA: Add test for dm-crypt measurement

 runtest/ima                                   |  1 +
 .../kernel/security/integrity/ima/README.md   | 20 +++++
 .../integrity/ima/tests/ima_dm_crypt.sh       | 60 ++++++++++++++
 .../security/integrity/ima/tests/ima_keys.sh  | 62 +++------------
 .../security/integrity/ima/tests/ima_setup.sh | 79 +++++++++++++++++++
 5 files changed, 173 insertions(+), 49 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh

-- 
2.17.1

