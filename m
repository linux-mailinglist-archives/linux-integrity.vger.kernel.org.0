Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EED24DF58
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Aug 2020 20:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgHUSVS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 14:21:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42916 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgHUSVR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 14:21:17 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 947F020B4908;
        Fri, 21 Aug 2020 11:21:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 947F020B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598034077;
        bh=jnKN/0o6ga2bWvn4K8enZulq7Q+WGRizfYc70OIvU5c=;
        h=From:To:Cc:Subject:Date:From;
        b=dl9KO6qt8EGWHaif1XCF5RmRVBVNHM5//G9NMMco8U20lNs7+vjJmJz7dmodxS3e6
         iwxVddFMdNksVb3x/i15h0ZB0zsd/JPX1mwZSVNImu/Tvr8jsbPCmw+KdAOeXZtGFL
         cIkSqIzhtJCqyAEyKgQQiSaX5RYoGGkLLxCK5G/0=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2 0/3] IMA: Infrastructure for measurement of critical kernel data
Date:   Fri, 21 Aug 2020 11:21:04 -0700
Message-Id: <20200821182107.5328-1-tusharsu@linux.microsoft.com>
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
measure the data of any kernel component at run-time.

This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity

This series also has a dependency on the following patch series:
 https://patchwork.kernel.org/patch/11709527/

Change Log v2:
 - Reverted the unnecessary indentations in existing #define.
 - Updated the description to replace the word 'enlightened' with
   'supported'.
 - Reverted the unnecessary rename of attribute size to buf_len.
 - Introduced a boolean parameter measure_buf_hash as per community
   feedback to support measuring hash of the buffer, instead of the
   buffer itself.

Tushar Sugandhi (3):
  IMA: generalize keyring specific measurement constructs
  IMA: add policy to support measuring critical data from kernel
    components
  IMA: define IMA hook to measure critical data from kernel components

 Documentation/ABI/testing/ima_policy         |   6 +-
 include/linux/ima.h                          |  11 ++
 security/integrity/ima/ima.h                 |  12 ++-
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  69 +++++++++++--
 security/integrity/ima/ima_policy.c          | 100 +++++++++++++++----
 security/integrity/ima/ima_queue_keys.c      |   3 +-
 9 files changed, 167 insertions(+), 46 deletions(-)

-- 
2.17.1

