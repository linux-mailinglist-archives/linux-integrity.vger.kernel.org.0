Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AABEA242F45
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Aug 2020 21:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHLTbO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Aug 2020 15:31:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51134 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHLTbM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Aug 2020 15:31:12 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 32A8220B4908;
        Wed, 12 Aug 2020 12:31:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32A8220B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597260671;
        bh=KE/92PDDZwu4+k6LDHiyjL8+Ar+TjmWoK4GzA/T5QF4=;
        h=From:To:Cc:Subject:Date:From;
        b=KJj/pX9xq2FHGRlMhOZ/5SreGEMcU7inXjdZ+rK/e3Ix8aGEt12tiW+8q/acQ1hkr
         nCpQ6OlP5R63mkdpdllHunhLW+5//8fh2v0qxHadb/O1gNh/vvFMe3atTe6+gm6FP+
         G0qI25BTsW7+G+NBRtWg/wSG4HiFEmI/GnSl0fz0=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        nramas@linux.microsoft.com
Subject: [PATCH 0/3] IMA: Infrastructure for measurement of critical kernel data
Date:   Wed, 12 Aug 2020 12:30:59 -0700
Message-Id: <20200812193102.18636-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are several kernel components that contain critical data which if
accidentally or maliciously altered, can compromise the security of the
kernel. Example of such components would include LSMs like SELinux, or
AppArmor; or device-mapper targets like dm-crypt, dm-verity etc.

Many of these components do not use the capabilities provided by kernel
integrity subsystem (IMA), and thus they don't use the benefits of
extended TPM PCR quotes and ultimately the benefits of remote attestation.

This series bridges this gap, so that potential kernel components that
contain data critical to the security of the kernel could take advantage
of IMA's measuring and quoting abilities - thus ultimately enabling
remote attestation for their specific data.

System administrators may want to pick and choose which kernel
components they would want to enable for measurements, quoting, and
remote attestation. To enable that, a new IMA policy is introduced.

And lastly, the functionality is exposed through a function
ima_measure_critical_data(). The functionality is generic enough to
measure the data of any kernel component at runtime.

This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity

This series also has a dependency on the following patch series:
 https://patchwork.kernel.org/patch/11709527/

Tushar Sugandhi (3):
  IMA: generalize keyring specific measurement constructs
  IMA: add policy to support measuring critical data from kernel
    components
  IMA: define IMA hook to measure critical data from kernel components

 Documentation/ABI/testing/ima_policy |   6 +-
 include/linux/ima.h                  |   9 ++
 security/integrity/ima/ima.h         |  12 +--
 security/integrity/ima/ima_api.c     |   8 +-
 security/integrity/ima/ima_main.c    |  46 +++++++---
 security/integrity/ima/ima_policy.c  | 120 ++++++++++++++++++++-------
 6 files changed, 147 insertions(+), 54 deletions(-)

-- 
2.17.1

