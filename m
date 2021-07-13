Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39763C679F
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 02:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhGMAwB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 20:52:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53334 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbhGMAwB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 20:52:01 -0400
Received: from Lenovo-Legion-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id E8A3620B6C50;
        Mon, 12 Jul 2021 17:49:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8A3620B6C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626137352;
        bh=4qGGRzN0D7FTQ/1ChCiZ6HBr23/qrNg8xeM7B/SY+3o=;
        h=From:To:Cc:Subject:Date:From;
        b=sTeWRcRtFlGgNEbe5dDZvQvkoEAdhhyIQSWOwFZ2TPhUkppbZ0o2po8v7DdA9tPZ5
         6jW1vxkXxWdOMdo6X7QnqYOnHvhs8QxhtfMxbtvzK8dYDlIUcJuA+5mdpJSM5rqLJM
         HQdsYH3/kZfn7iRIqCzOR8oBQltQNY+7K1Yqllu8=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com
Subject: [PATCH 0/7] device mapper target measurements using IMA
Date:   Mon, 12 Jul 2021 17:48:57 -0700
Message-Id: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For a given system, various external services/infrastructure tools
(including the attestation service) interact with it - both during the
setup and during rest of the system run-time.  They share sensitive data
and/or execute critical workload on that system.  The external services
may want to verify the current run-time state of the relevant kernel
subsystems before fully trusting the system with business-critical
data/workload.

Device mapper is one such kernel subsystem that plays a critical role on
a given system by providing various important functionalities to the
block devices with various target types like crypt, verity, integrity 
etc.  Each of these target types’ functionalities can be configured with
various attributes.  The attributes chosen to configure these target types
can significantly impact the security profile of the block device,
and in-turn, of the system itself.  For instance, the type of encryption
algorithm and the key size determines the strength of encryption for a
given block device.

Therefore, verifying the current state of various block devices as well
as their various target attributes is crucial for external services
before fully trusting the system with business-critical data/workload.

IMA provides the necessary functionality for device mapper to measure the
state and configuration of various block devices -
  - BY device mapper itself, from within the kernel,
  - in a tamper resistant way,
  - and re-measured - triggered on state/configuration change.

This patch series uses this IMA functionality, by calling the function
ima_measure_critical_data(), when a block device state is changed (e.g.
on device create, resume, rename, remove etc.)  It measures the device
state and configuration and stores it in IMA logs, so that it can be
used by external services for managing the system.


Tushar Sugandhi (7):
  dm: measure data on table load
  dm: measure data on device resume
  dm: measure data on device remove
  dm: measure data on table clear
  dm: measure data on device rename
  dm: update target specific status functions to measure data
  dm: add documentation for IMA measurement support

 .../admin-guide/device-mapper/dm-ima.rst      | 306 ++++++++
 .../admin-guide/device-mapper/index.rst       |   1 +
 drivers/md/Makefile                           |   2 +
 drivers/md/dm-cache-target.c                  |  24 +
 drivers/md/dm-clone-target.c                  |   7 +
 drivers/md/dm-core.h                          |   5 +
 drivers/md/dm-crypt.c                         |  29 +
 drivers/md/dm-delay.c                         |   4 +
 drivers/md/dm-dust.c                          |   4 +
 drivers/md/dm-ebs-target.c                    |   3 +
 drivers/md/dm-era-target.c                    |   4 +
 drivers/md/dm-flakey.c                        |   4 +
 drivers/md/dm-ima.c                           | 725 ++++++++++++++++++
 drivers/md/dm-ima.h                           |  56 ++
 drivers/md/dm-integrity.c                     |  24 +
 drivers/md/dm-ioctl.c                         |  24 +-
 drivers/md/dm-linear.c                        |   8 +
 drivers/md/dm-log-userspace-base.c            |   3 +
 drivers/md/dm-log-writes.c                    |   4 +
 drivers/md/dm-log.c                           |  10 +
 drivers/md/dm-mpath.c                         |  29 +
 drivers/md/dm-ps-historical-service-time.c    |   3 +
 drivers/md/dm-ps-io-affinity.c                |   3 +
 drivers/md/dm-ps-queue-length.c               |   3 +
 drivers/md/dm-ps-round-robin.c                |   4 +
 drivers/md/dm-ps-service-time.c               |   3 +
 drivers/md/dm-raid.c                          |  39 +
 drivers/md/dm-raid1.c                         |  18 +
 drivers/md/dm-snap-persistent.c               |   4 +
 drivers/md/dm-snap-transient.c                |   4 +
 drivers/md/dm-snap.c                          |  13 +
 drivers/md/dm-stripe.c                        |  16 +
 drivers/md/dm-switch.c                        |   4 +
 drivers/md/dm-thin.c                          |   8 +
 drivers/md/dm-unstripe.c                      |   4 +
 drivers/md/dm-verity-target.c                 |  45 ++
 drivers/md/dm-writecache.c                    |   3 +
 drivers/md/dm-zoned-target.c                  |   3 +
 drivers/md/dm.c                               |   3 +
 include/linux/device-mapper.h                 |   6 +-
 include/uapi/linux/dm-ioctl.h                 |   6 +
 41 files changed, 1464 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/admin-guide/device-mapper/dm-ima.rst
 create mode 100644 drivers/md/dm-ima.c
 create mode 100644 drivers/md/dm-ima.h

-- 
2.25.1

