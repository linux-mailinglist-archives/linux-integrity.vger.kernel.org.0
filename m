Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320442552D2
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 03:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgH1B5S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 21:57:18 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38412 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1B5S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:18 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 144F720B7178;
        Thu, 27 Aug 2020 18:57:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 144F720B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598579837;
        bh=xcLyoCG73RULVdbULRTyICyaCH1/+89JRVwjrVGQQYk=;
        h=From:To:Cc:Subject:Date:From;
        b=auHHUx3zzRaZqF2Q4uil4Xmb8tLHAUDUJEujc7H8AwWfF1cjlY6ItPMOwkN0NRma2
         22TYlVQEhEKk5FtO3MSm8qJhQNIO9G/h5E8tO/Tt5qbEsLeGJOr18e9REC2gPa3GeD
         cWp/mFEwXt7v150PHt3uMz+16nU3GgdiE9ya1nL0=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 0/6] IMA: Infrastructure for measurement of critical kernel data
Date:   Thu, 27 Aug 2020 18:56:58 -0700
Message-Id: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
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
measure the data of any kernel component at run-time. To ensure that only
data from supported sources are measured, the kernel component needs to
be added to a compile-time list of supported sources (an "allowed list
of components"). IMA validates the source passed to
ima_measure_critical_data() against this allowed list at run-time. 

This series is based on the following repo/branch:

 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit d012a7190fc1 ("Linux 5.9-rc2")

This series also has a dependency on the following patch series:
 https://patchwork.kernel.org/patch/11709527/

Change Log v3:
Incorporated feedback from Mimi on v2.
 - Renamed the policy "data_sources" to
   "critical_kernel_data_sources".
 - Added "critical_kernel_data_sources" description in
   Documentation/ima-policy.
 - Split CRITICAL_DATA + critical_kernel_data_sources into two separate
   patches.
 - Merged hook ima_measure_critical_data() + CRITICAL_DATA into a single
   patch.
 - Added functionality to validate data sources before measurement.

Change Log v2:
 - Reverted the unnecessary indentations in existing #define.
 - Updated the description to replace the word 'enlightened' with
   'supported'.
 - Reverted the unnecessary rename of attribute size to buf_len.
 - Introduced a boolean parameter measure_buf_hash as per community
   feedback to support measuring hash of the buffer, instead of the
   buffer itself.


Tushar Sugandhi (6):
  IMA: generalize keyring specific measurement constructs
  IMA: change process_buffer_measurement return type from void to int
  IMA: update process_buffer_measurement to measure buffer hash
  IMA: add policy to measure critical data from kernel components
  IMA: add hook to measure critical data from kernel components
  IMA: validate supported kernel data sources before measurement

 Documentation/ABI/testing/ima_policy         |  11 +-
 include/linux/ima.h                          |  11 ++
 security/integrity/ima/ima.h                 |  41 +++++++-
 security/integrity/ima/ima_api.c             |   8 +-
 security/integrity/ima/ima_appraise.c        |   2 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_main.c            |  72 +++++++++++--
 security/integrity/ima/ima_policy.c          | 101 +++++++++++++++----
 security/integrity/ima/ima_queue_keys.c      |   3 +-
 9 files changed, 205 insertions(+), 46 deletions(-)

-- 
2.17.1

