Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D23292CA6
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Oct 2020 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgJSR0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Oct 2020 13:26:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43074 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgJSR0Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Oct 2020 13:26:24 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6544920B4905;
        Mon, 19 Oct 2020 10:26:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6544920B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603128383;
        bh=QLYSVsWBQqF4v9zjJGLLb6QFJkF/2yIoBobzSOob9bI=;
        h=From:To:Cc:Subject:Date:From;
        b=K0gvC0duHMBd+GVGRAUvay8neDuDbA1AjMvqj6XHwwmwjXSBzeZsS/4a7xY3uaCCZ
         d2wgU7/zWjnwmSgWpvhwKaky1jdLBFm16KdrB8ELl9RDiU7MRhlSMBkwSQM6E2/5zN
         GGUdPlK6La8svDbySHg0rR1MLkrMWpt9ZrvRBgIo=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v4 0/2] dm-devel:dm-crypt: infrastructure for measurement of DM target data using IMA
Date:   Mon, 19 Oct 2020 10:26:05 -0700
Message-Id: <20201019172607.16714-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are several device-mapper targets which contribute to verify
the integrity of the mapped devices e.g. dm-integrity, dm-verity,
dm-crypt etc.

But they do not use the capabilities provided by kernel integrity
subsystem (IMA). For instance, the IMA capability that measures several
in-memory constructs and files to detect if they have been accidentally
or maliciously altered. IMA also has the capability to include these
measurements in the IMA measurement list and use them to extend a TPM
PCR so that they can be quoted. These TPM PCR extend operations ensure
that the tampering with the order of constructs being measured, and
tampering with the measured constructs themselves - doesn't go
undetected. In general, this capability is used for remote attestation
of in-memory constructs and files of interest. As of today,device-mapper
targets don't use the benefits of extended TPM PCR quotes and ultimately
the benefits of remote attestation.

This series bridges this gap, so that all device-mapper targets
could take advantage of IMA's measuring and quoting abilities - thus
ultimately enabling remote attestation for device-mapper targets.

This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit aa662fc04f5b ("ima: Fix NULL pointer dereference in ima_file_hash")

This series also has a dependency on the following patch series and
should be applied in the following order:
 1. https://patchwork.kernel.org/patch/11795559/
 2. https://patchwork.kernel.org/patch/11801525/


Change Log v4:
Incorporated feedback from Milan Broz <gmazyland@gmail.com> on v3 series.
 - Added device name of both base disk and target device for
   measurement, along with their major:minor.
 - Introduced a function get_devname_from_maj_min() in dm-ima.c, to
   get the device name from device major:minor. Currently it is used
   for dm-crypt measurements, but it would be helpful for measuring 
   other device-mapper targets as well.
 - Added dm_target members - len and begin - to measurement list. 
 - Taken dependency on the updated base series v4 (1. above)
 - Taken dependency on the updated early boot measurement series v3
   (2. above).

Change Log v3:
 - Added dm-crypt as a supported data source to measure in ima.h.
 - Taken dependency on the updated base series v3 (2. above)
 - Taken dependency on the updated early boot measurement series v2
   (3. above).

Change Log v2:
 - Removed the references to "local" measurement from the description -
   as this series only support remote attestation, and not local
   integrity enforcement.
 - Taken dependency on the updated base series (2. above), which 
   introduced a boolean parameter measure_buf_hash as per community
   feedback to support measuring hash of the buffer, instead of the
   buffer itself.
 - Taken dependency on the updated early boot measurement series
   (3. above).

Tushar Sugandhi (2):
  dm-devel: collect target data and submit to IMA to measure
  dm-crypt: collect data and submit to DM to measure

 block/genhd.c                           |   2 +
 drivers/md/Makefile                     |   1 +
 drivers/md/dm-crypt.c                   | 217 ++++++++++++++
 drivers/md/dm-ima.c                     | 378 ++++++++++++++++++++++++
 include/linux/device-mapper.h           |  67 +++++
 include/linux/genhd.h                   |   1 +
 security/integrity/ima/ima.h            |   1 +
 security/integrity/ima/ima_queue_data.c |   3 +-
 8 files changed, 669 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-ima.c

-- 
2.17.1

