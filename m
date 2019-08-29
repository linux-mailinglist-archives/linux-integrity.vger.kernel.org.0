Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4EFA2699
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 21:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfH2TBC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 15:01:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60146 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfH2TBC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 15:01:02 -0400
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 68DA420B7186;
        Thu, 29 Aug 2019 12:01:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68DA420B7186
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     jmorris@namei.org, zohar@linux.ibm.com, bauerman@linux.ibm.com
Subject: [RFC][PATCH v1 0/1] Carry ima measurement log for arm64 via kexec_file_load
Date:   Thu, 29 Aug 2019 12:00:53 -0700
Message-Id: <20190829190054.12440-1-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The patch adds support for arm64 to carry ima measurement log
to the next soft boot session triggered via kexec_file_load.
- Top of Linux 5.3-rc6

Currently during kexec the kernel file signatures are validated
prior to actual load, the information(PE/ima signature) 
is not carried to the next session. 
This lead to loss of information.

This patch addresses the same by carrying forward the ima measurement log
to the next kexec'ed session. This just allows a verifying party to get
the entire runtime event log since the last full reboot since that is
when PCRs were last reset.

The code is in most part same as powerpc, i want to get feedback as to
how/correct way to refactor the code so that cross architecture 
partial helpers can be put in a common place.

Prakhar Srivastava (1):
  Carry ima measurement log for arm64 via kexec_file_load

 arch/arm64/Kconfig                     |   7 +
 arch/arm64/include/asm/ima.h           |  31 ++++
 arch/arm64/include/asm/kexec.h         |   4 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/ima_kexec.c          | 219 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |  39 +++++
 6 files changed, 301 insertions(+)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c

-- 
2.17.1

