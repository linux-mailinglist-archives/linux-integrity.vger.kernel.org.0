Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E9E20642D
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 23:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393376AbgFWVRH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 17:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52275 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390450AbgFWU1B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 16:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592944020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LsRPxMKdg3wg3/L+rwnuc4Avfs5K49uylfJOpJywC20=;
        b=aqX51ZCYV3UDvqTsUUgO2awydbpLkONCAlaEZcuMKgl/OnC/RhP6KyWsMdc/WOaDRe1xGa
        48syNEhRB17Eneg6MbCwyd+lM6mW90C4Y7h/tzYSq/OdzhyORf4seUy2E1/sWqGWkbyqKz
        lEL5rmOCv25T27RLDoOLKDOXgRf1eKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-84sBE2vBO8mcm2IjICeKGw-1; Tue, 23 Jun 2020 16:26:58 -0400
X-MC-Unique: 84sBE2vBO8mcm2IjICeKGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDD86363F8;
        Tue, 23 Jun 2020 20:26:46 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10B7A70C37;
        Tue, 23 Jun 2020 20:26:42 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, erichte@linux.ibm.com, nayna@linux.ibm.com,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v3 0/2] ima: make appraisal state runtime dependent on secure boot
Date:   Tue, 23 Jun 2020 17:26:38 -0300
Message-Id: <20200623202640.4936-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To switch APPRAISE_BOOTPARAM and ARCH_POLICY dependency from compile time to
run time the secure boot checking code (specific to each arch) had to be
slightly modified to include, in the PowerPC arch, the Trusted Boot state,
which is also relevant to the arch policy choice and also required the
ima_appraise to be enforced. 

With that I changed the checking order: instead of first check the
arch_policy and then the secure/trusted boot state, now we first check the
boot state, set ima_appraise to be enforced and then the existence of arch
policy. In other words, whenever secure/trusted boot is enabled,
(ima_appraise & IMA_APPRAISE_ENFORCE) == true.

I've tested these patches in a x86_64 platform with and without secure boot
enabled and in a PowerPC without secure boot enabled:

1) with secure boot enabled (x86_64) and ima_policy=appraise_tcb, the
ima_appraise= options were completly ignored and the boot always failed with
"missing-hash" for /sbin/init, which is the expected result;

2) with secure boot enabled (x86_64), but no ima_policy:

[    1.396111] ima: Allocated hash algorithm: sha256
[    1.424025] ima: setting IMA appraisal to enforced
[    1.424039] audit: type=1807 audit(1592927955.557:2): action=measure func=KEXEC_KERNEL_CHECK res=1
[    1.424040] audit: type=1807 audit(1592927955.557:3): action=measure func=MODULE_CHECK res=1

3) with secure boot disabled (PowerPC and x86_64) and
"ima_policy=appraise_tcb ima_appraise=fix", audit messages were triggered
with "op=appraisal_data cause=missing-hash" but the system worked fine due
to "fix".

Bruno Meneguele (2):
  arch/ima: extend secure boot check to include trusted boot
  ima: move APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime

 arch/powerpc/kernel/ima_arch.c      |  5 +++--
 arch/s390/kernel/ima_arch.c         |  2 +-
 arch/x86/kernel/ima_arch.c          |  4 ++--
 include/linux/ima.h                 |  4 ++--
 security/integrity/ima/Kconfig      |  2 +-
 security/integrity/ima/ima_main.c   |  2 +-
 security/integrity/ima/ima_policy.c | 20 ++++++++++++++------
 7 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.26.2

