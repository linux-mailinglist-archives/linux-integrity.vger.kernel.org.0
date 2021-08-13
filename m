Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87AF3EBDEC
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Aug 2021 23:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhHMVih (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 13 Aug 2021 17:38:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44266 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbhHMVih (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Aug 2021 17:38:37 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7F42720C13EE;
        Fri, 13 Aug 2021 14:38:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F42720C13EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628890689;
        bh=mz0MYEXJuMOOYCbdVEPnOs+zQk2fFOxoTDlcE0SvKpU=;
        h=From:To:Cc:Subject:Date:From;
        b=N//ufxpmcSR77/1pmZr8zumZFKT07fumAlMmAM5CsexHjQ85fKHxovqrv6ndlNhHs
         H1mzZLprjvwE8NCnioH5VBcdNKlXAiVsZSzGjrI7+TQQQWVYT6TJ7MtSOlOpnLddd0
         UT3J1+I/9T8MSXYpq3ddjDe2szqTkH9CfR8QJe7c=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        sfr@canb.auug.org.au, public@thson.de, nramas@linux.microsoft.com,
        tusharsu@linux.microsoft.com
Subject: [PATCH 0/6] updates to device mapper target measurement using ima
Date:   Fri, 13 Aug 2021 14:37:55 -0700
Message-Id: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


There were several improvements suggested for the original device mapper
target measurement patch series [1].

Those improvement suggestions include: 
 - Prefixing hashes for the DM tables being measured in ima log with the
   hash algorithm.
 - Adding version information for DM related events being measured in the
   ima log.
 - Prefixing DM related event names with "dm_".
 - Including the verity target attribute - "root_hash_sig_key_desc"
   in the ima measurement log.

This series incorporates the above suggestions.

This series also has the following fixes:
 - Adding a one-time warning to dmesg during dm_init if
   CONFIG_IMA_DISABLE_HTABLE is set to 'n'.
 - Updating 'integrity' target to remove the duplicate measurement of
   the attribute "mode=%c".
 - Indexing various attributes in 'multipath' target, and adding
   "nr_priority_groups=%u" attribute to the measurements.
 - Fixing 'make htmldocs' warnings in dm-ima.rst.
 - Adding missing documentation for the targets - 'cache', 'integrity',
   'multipath', and 'snapshot' in dm-ima.rst.
 - Updating dm-ima.rst documentation with the grammar for various DM
   events and targets in Backus Naur form.
 - Updating dm-ima.rst documentation to be consistent with the code
   changes described above.

This series is based on top of the following git repo/branch/commit:
 Repo: https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 Branch: dm-5.15
 Commit: commit 5a2a33884f0b ("dm crypt: Avoid percpu_counter spinlock contention in crypt_page_alloc()")


[1] https://patchwork.kernel.org/project/dm-devel/cover/20210713004904.8808-1-tusharsu@linux.microsoft.com/

Tushar Sugandhi (6):
  dm ima: prefix dm table hashes in ima log with hash algorithm
  dm ima: add version info to dm related events in ima log
  dm ima: prefix ima event name related to device mapper with dm_
  dm ima: add a warning in dm_init if duplicate ima events are not
    measured
  dm ima: update dm target attributes for ima measurements
  dm ima: update dm documentation for ima measurement support

 .../admin-guide/device-mapper/dm-ima.rst      | 827 +++++++++++++-----
 drivers/md/dm-ima.c                           |  94 +-
 drivers/md/dm-ima.h                           |  10 +
 drivers/md/dm-integrity.c                     |   1 -
 drivers/md/dm-mpath.c                         |  26 +-
 drivers/md/dm-verity-target.c                 |   2 +
 drivers/md/dm.c                               |   6 +
 7 files changed, 724 insertions(+), 242 deletions(-)

-- 
2.32.0

