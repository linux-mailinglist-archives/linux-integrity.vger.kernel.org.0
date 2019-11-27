Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78DEC10A8E7
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 03:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfK0CwT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 21:52:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46224 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfK0CwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 21:52:19 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1914F20B7185;
        Tue, 26 Nov 2019 18:52:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1914F20B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574823138;
        bh=5NAfEhRtIEbYB3sZQhH1wdDrrAoygkICB/b+f2Pif8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=FwpBrdMxjpmskLNKYPt2BHzMJ9kKsMp3v7k869peyKZgBYEX4Sl99gUang9A6gIMm
         mW380/LFnK6xkH6jLwLmMtd4vTUmxm/VBh7+h/Ha1lONigDNMPdWO99hEDCqwkon2j
         XN5Xjw7mlnR0vgukP3GZBaBB2Qk0IhAATbpk6wVs=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v0 0/2] IMA: Deferred measurement of keys
Date:   Tue, 26 Nov 2019 18:52:10 -0800
Message-Id: <20191127025212.3077-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patchset extends the previous version[1] by adding support for
deferred processing of keys.

With the patchset referenced above, the IMA subsystem supports
measuring keys when the key is created or updated. But the keys
created or updated before IMA subsystem is initialized are not
handled. This includes keys added to, for instance,
.builtin_trusted_keys which happens very early in the boot process.

This change adds support for queuing keys when IMA is not ready
and process the keys (including queued keys) when IMA is initialized.

[1] https://lore.kernel.org/linux-integrity/20191127015654.3744-1-nramas@linux.microsoft.com/

Testing performed:

  * Booted the kernel with this change.
  * Added .builtin_trusted_keys in "keyrings=" option in
    the IMA policy and verified the keys added to this
    keyring are measured.
  * Specified only func=KEY_CHECK and not "keyrings=" option,
    and verified the keys added to builtin_trusted_keys keyring
    are processed.
  * Added keys at runtime and verified they are measured
    if the IMA policy permitted.
      => For example, added keys to .ima keyring and verified.

Changelog:

  v0

  => Based changes on v5.4-rc8
  => The following patchsets should be applied in that order
     https://lore.kernel.org/linux-integrity/1572492694-6520-1-git-send-email-zohar@linux.ibm.com
     https://lore.kernel.org/linux-integrity/20191127015654.3744-1-nramas@linux.microsoft.com/
  => Added functions to queue and dequeue keys, and process
     the queued keys when custom IMA policies are applied.

Lakshmi Ramasubramanian (2):
  IMA: Defined queue functions
  IMA: Call queue and dequeue functions to measure keys

 security/integrity/ima/ima.h                 |  15 ++
 security/integrity/ima/ima_asymmetric_keys.c | 151 ++++++++++++++++++-
 security/integrity/ima/ima_policy.c          |  12 ++
 3 files changed, 174 insertions(+), 4 deletions(-)

-- 
2.17.1

