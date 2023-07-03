Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E714B746531
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGCV5U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGCV5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 17:57:19 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37445195
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 14:57:18 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 672DB20AECAD;
        Mon,  3 Jul 2023 14:57:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 672DB20AECAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688421437;
        bh=dwctAI29NeVxstN9AppFfzgU8gouR8gPuHq2XSTUx58=;
        h=From:To:Cc:Subject:Date:From;
        b=St9ZAhsrUCG3wAr0ZPa6Cgc4Xs1jmnGB1Lj4arnsu5l4YrgOeaAnMQna6VByM+VuA
         Y0TLsYHIJ+RuFKl1rc/yFYv9qtbYu6UN6jY5Q9tyezCSoWNmJXuhIs+Ib2XYOY7/XY
         83Box1gXOTk7fP9rttAVLGGiFxgZcUjERtLYF2Y0=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 00/10] ima: measure events between kexec load and execute
Date:   Mon,  3 Jul 2023 14:56:59 -0700
Message-Id: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The current Kernel behavior is IMA measurements snapshot is taken at
kexec 'load' and not at kexec 'execute'.  IMA log is then carried
over to the new Kernel after kexec 'execute'.

Some devices can be configured to call kexec 'load' first, and followed
by kexec 'execute' after some time. (as opposed to calling 'load' and
'execute' in one single kexec command).  In such scenario, if new IMA
measurements are added between kexec 'load' and kexec 'execute', the
TPM PCRs are extended with the IMA events between 'load' and 'execute';
but those IMA events are not carried over to the new kernel after kexec
soft reboot.  This results in mismatch between TPM PCR quotes and the
actual IMA measurements list after the device boots into the new kexec
image.  This mismatch results in the remote attestation failing for that
device.

This patch series proposes a solution to solve this problem by allocating
the necessary buffer at kexec 'load' time, and populating the buffer
with the IMA measurements at kexec 'execute' time. 

The solution includes:
 - addition of new functionality to allocate a buffer to hold IMA
   measurements at kexec 'load', 

 - ima functionality to suspend and resume measurements as needed during
   buffer copy at kexec 'execute',

 - ima functionality for mapping the measurement list from the current
   Kernel to the subsequent one, 

 - necessary changes to the kexec_file_load syscall, enabling it to call
   the ima functions

 - registering a reboot notifier which gets called during kexec 'execute',

 - and removal of deprecated functions.

The modifications proposed in this series ensure the integrity of the ima
measurements is preserved across kexec soft reboots, thus significantly
improving the security of the Kernel post kexec soft reboots.

There were previous attempts to fix this issue [1], [2], [3].  But they
were not merged into the mainline Kernel.  

We took inspiration from the past work [1] and [2] while working on this
patch series.

References:
-----------

[1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/

[2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
https://lkml.org/lkml/2016/8/16/577

[3] [PATCH 1/6] kexec_file: Add buffer hand-over support
https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/

Tushar Sugandhi (10):
  ima: implement function to allocate buffer at kexec load
  ima: implement function to populate buffer at kexec execute
  ima: allocate buffer at kexec load to hold ima measurements
  ima: implement functions to suspend and resume measurements
  kexec: implement functions to map and unmap segment to kimage
  ima: update buffer at kexec execute with ima measurements
  ima: remove function ima_dump_measurement_list
  ima: implement and register a reboot notifier function to update kexec
    buffer
  ima: suspend measurements while the kexec buffer is being copied
  kexec: update kexec_file_load syscall to call ima_kexec_post_load

 include/linux/ima.h                |   3 +
 include/linux/kexec.h              |  13 ++
 kernel/kexec_core.c                |  72 +++++++++-
 kernel/kexec_file.c                |   7 +
 kernel/kexec_internal.h            |   1 +
 security/integrity/ima/ima.h       |   4 +
 security/integrity/ima/ima_kexec.c | 211 +++++++++++++++++++++++------
 security/integrity/ima/ima_queue.c |  32 +++++
 8 files changed, 295 insertions(+), 48 deletions(-)

-- 
2.25.1

