Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FD7245991
	for <lists+linux-integrity@lfdr.de>; Sun, 16 Aug 2020 23:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgHPVC7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 16 Aug 2020 17:02:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33724 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgHPVC7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 16 Aug 2020 17:02:59 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0DA5F20B4908;
        Sun, 16 Aug 2020 14:02:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DA5F20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597611778;
        bh=yNLvSz8q8nGFbazyxhAPfvdMl5GSQ0kjaIDg928QEww=;
        h=From:To:Cc:Subject:Date:From;
        b=Gz5lcFKet034Fkhpxd191bC6VM6lAFqQP3y+uVN1RuR8EtQFoWe4W35A+0bpVl8rn
         +5Sdfu51FQ4wToT1uq46VJ/J0RTql943UJHqJB/5MtabvesoSjapo+DLotfaTQR4Dy
         buTzQhPPh9VGr3QoISFpIzaC1r/Z2RY1nP7yKeaA=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 0/2] dm-devel:dm-crypt: infrastructure for measurement of DM target data using IMA
Date:   Sun, 16 Aug 2020 14:02:48 -0700
Message-Id: <20200816210250.11506-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are several device-mapper targets which contribute to verify
the integrity of the mapped devices e.g. dm-integrity, dm-verity,
dm-crypt etc.

But they do not use the capabilities provided by kernel integrity
subsystem (IMA). For instance, the IMA capability that measures several
in-memory constructs and files to detect if they have been accidentally
or maliciously altered, both remotely and locally. IMA also has the
capability to include these measurements in the IMA measurement list and
use them to extend a TPM PCR so that it can be quoted. These TPM PCR
extend operations ensure that the tampering with the order of constructs
being measured, and tampering with the measured constructs themselves -
doesn't go undetected. In general, this capability is used for remote
attestation of in-memory constructs and files of interest. As of today,
device-mapper targets don't use the benefits of extended TPM PCR
quotes and ultimately the benefits of remote attestation.

This series bridges this gap, so that all device-mapper targets
could take advantage of IMA's measuring and quoting abilities - thus
ultimately enabling remote attestation for device-mapper targets.

This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit 3db0d0c276a7 ("integrity: remove redundant initialization of variable ret")

This series also has a dependency on the following patch series and
should be applied in the following order:
 1. https://patchwork.kernel.org/patch/11709527/
 2. https://patchwork.kernel.org/patch/11711249/
 3. https://patchwork.kernel.org/patch/11712729/

Tushar Sugandhi (2):
  dm-devel: collect target data and submit to IMA to measure
  dm-crypt: collect data and submit to DM to measure

 drivers/md/Makefile            |   1 +
 drivers/md/dm-crypt.c          | 170 +++++++++++++++++++
 drivers/md/dm-ima.c            | 296 +++++++++++++++++++++++++++++++++
 include/linux/device-mapper.h  |  58 +++++++
 security/integrity/ima/Kconfig |   2 +-
 5 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 drivers/md/dm-ima.c

-- 
2.17.1

