Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2224F564B5C
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jul 2022 03:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiGDBwV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 3 Jul 2022 21:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGDBwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 3 Jul 2022 21:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7AB8271B
        for <linux-integrity@vger.kernel.org>; Sun,  3 Jul 2022 18:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656899536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FG09NB0u+itbKukOM5H/RLays7V1RS1EZPZR3jC98rI=;
        b=gFk4+IhRC8H4KN5aAEL04iIQcRSAnJ6tpc0aD7XOuEk3s5ycHOevQJzqVZcmF7pzM5LImS
        x4WAzYuBR3JPaQdzp0zvkRUkC9SxtsBfgU6Qj/KEit1Us4NAMFfyshjMpVJDbAIslpQbh1
        pxr76fK4NG+2qLoeQ2oAdnP8kp8sQIE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-xLi7Trv5NyawqYEvjXUr9g-1; Sun, 03 Jul 2022 21:52:15 -0400
X-MC-Unique: xLi7Trv5NyawqYEvjXUr9g-1
Received: by mail-pg1-f198.google.com with SMTP id s129-20020a632c87000000b00411564fe1feso3315127pgs.7
        for <linux-integrity@vger.kernel.org>; Sun, 03 Jul 2022 18:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FG09NB0u+itbKukOM5H/RLays7V1RS1EZPZR3jC98rI=;
        b=ij1yAU85kKhBTZh/AWiWR+tMW7M1O/TETDMm0mL/U55f8nxaI1Kfyr0zY6TWChBy6b
         PkCdIz7RCRoQU1zGprd51qgeY9J0WTIpbjSN4nm9xS//YwwCWyg1IQD82pfldZXDLWRF
         WxeRpmrXNzjhLZa0MfiYJU0lJVYDoZ51Q33fzWJ6f2qH/1QIJGisNzsBA7cHnBN2RETx
         /S2kd5I0GnANStsG2HGRhyKMfvjsQ1n06Z5WP9WYHJB9ljKR/2QmY6rrg4yKXnV4zv4z
         QIp1MmoOY6O8o1CPJUfTeVvPWbL9Hojfv/W4bd2nbhLxmZRnodZW7rvThoEZfRbSKlL9
         7yOA==
X-Gm-Message-State: AJIora90ja5ZVplMFwtW0HzXucXgZHO3LEC5SHmAx7T1Fp+Sw2N5qHbo
        urFNK7w+DdqK0tIIlNMXSHmVccEpObYrqDDhX/2DVeoB7/bv8meSBoPLphvWHLP/K2oSZsLsGoY
        5sv5UXYGNta/8SFoQY41i9z3PnE53
X-Received: by 2002:a17:902:d292:b0:16b:e6a4:5768 with SMTP id t18-20020a170902d29200b0016be6a45768mr979389plc.128.1656899533747;
        Sun, 03 Jul 2022 18:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tg48NWmOzfaIjIwWMZGLTLkGUFf7ZRE5pa/sLMc785xjASL9MdcB56k/sQgVST+0LLk+zSIw==
X-Received: by 2002:a17:902:d292:b0:16b:e6a4:5768 with SMTP id t18-20020a170902d29200b0016be6a45768mr979365plc.128.1656899533455;
        Sun, 03 Jul 2022 18:52:13 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a25-20020aa79719000000b0052551c1a413sm19825856pfg.204.2022.07.03.18.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:52:13 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to verify kexec'ed kernel signature
Date:   Mon,  4 Jul 2022 09:51:57 +0800
Message-Id: <20220704015201.59744-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently when loading a kernel image via the kexec_file_load() system
call, x86 can make use of three keyrings i.e. the .builtin_trusted_keys,
.secondary_trusted_keys and .platform keyrings to verify a signature.
However, arm64 and s390 can only use the .builtin_trusted_keys and
.platform keyring respectively. For example, one resulting problem is
kexec'ing a kernel image  would be rejected with the error "Lockdown:
kexec: kexec of unsigned images is restricted; see man
kernel_lockdown.7".

This patch set enables arm64 and s390 to make use of the same keyrings
as x86 to verify the signature kexec'ed kernel image.

The recently introduced .machine keyring impacts the roots of trust by
linking the .machine keyring to the .secondary keyring. The roots of
trust for different keyrings are described as follows,

.builtin_trusted_keys:

Keys may be built into the kernel during build or inserted into memory
reserved for keys post build. The root of trust is based on verification
of the kernel image signature. For example, on a physical system in a
secure boot environment, this trust is rooted in hardware.

.machine:

If the end-users choose to trust the keys provided by first-stage UEFI
bootloader shim i.e. Machine Owner Keys (MOK keys), the keys will be
added to this keyring which is linked to the .secondary_trusted_keys
keyring as the same as the .builtin_trusted_keys keyring. Shim has
built-in keys from a Linux distribution or the end-users-enrolled keys.
So the root of trust of this keyring is either a Linux distribution
vendor or the end-users.

.secondary_trusted_keys:

Certificates signed by keys on the .builtin_trusted_keys, .machine, or
existing keys on the .secondary_trusted_keys keryings may be loaded
onto the .secondary_trusted_keys keyring. This establishes a signature
chain of trust based on keys loaded on either the .builtin_trusted_keys
or .machine keyrings, if configured and enabled.

.platform:

The .platform keyring consist of UEFI db and MOK keys which are used by
shim to verify the first boot kernel's image signature. If end-users
choose to trust MOK keys and the kernel has the .machine keyring
enabled, the .platform keyring only consists of UEFI db keys since the
MOK keys are added to the .machine keyring instead. Because the
end-users could also enroll their own MOK keys, the root of trust could
be hardware and the end-users.

The 3rd arm64 patch depends on the first two patches. The 4th s390 patch
can be applied independently.

I've tested the patch set on 5.19.0-rc2 and it works as expected. 

For arm64, the tests were done as follows,
  1. build 5.19.0-rc2
  2. generate keys and add them to .secondary_trusted_keys, MOK, UEFI
     db;
  3. sign different kernel images with different keys including keys
     from .builtin_trusted_key, .secondary_trusted_keys keyring, a UEFI db
     key and MOK key
  4. Without lockdown, all kernel images can be kexec'ed; with lockdown
     enabled, only the kernel image signed by the key from the
     .builtin_trusted_key keyring can be kexec'ed

For 390, I commented out the code that skips signature verification when
secure boot is not enabled since the testing machine doesn't supports
secure boot and can confirm before applying the patch, kernel images
signed by keys from .builtin_trusted_key, .secondary_trusted_keys
couldn't be kexec'ed when lockdown is enabled; after applying the patch,
those kernel images could be kexec'ed.

v9:
 - improve cover letter, subject line and commit messages, expecially
   regarding the root of trust of different keyrings and the .machine
   keyring [Mimi]
 - fix two code format issues [Mimi]
 - add test results [Mimi]

v8:
 - drop "Cc: stable@vger.kernel.org" for the first two prerequisite
   patches [Baoquan]

v7:
 - drop the Fixes tag for the 2nd patch and add patch prerequisites
   [Baoquan]
 - improve cover letter

v6:
 - integrate the first three patches of "[PATCH 0/4] Unifrom keyring
   support across architectures and functions" from Michal [1]
 - improve commit message [Baoquan, Michal]
 - directly assign kexec_kernel_verify_pe_sig to
   kexec_file_ops->verify_sig [Michal]

v5:
 - improve commit message [Baoquan]

v4:
 - fix commit reference format issue and other checkpatch.pl warnings [Baoquan]

v3:
 - s/arch_kexec_kernel_verify_pe_sig/kexec_kernel_verify_pe_sig [Eric]
 - clean up arch_kexec_kernel_verify_sig [Eric]

v2:
 - only x86_64 and arm64 need to enable PE file signature check [Dave]

[1] https://lore.kernel.org/lkml/cover.1644953683.git.msuchanek@suse.de/

Coiby Xu (3):
  kexec: clean up arch_kexec_kernel_verify_sig
  kexec, KEYS: make the code in bzImage64_verify_sig generic
  arm64: kexec_file: use more system keyrings to verify kernel image
    signature

Michal Suchanek (1):
  kexec, KEYS, s390: Make use of built-in and secondary keyring for
    signature verification

 arch/arm64/kernel/kexec_image.c       | 11 +-----
 arch/s390/kernel/machine_kexec_file.c | 18 +++++++---
 arch/x86/kernel/kexec-bzimage64.c     | 20 +----------
 include/linux/kexec.h                 |  6 ++--
 kernel/kexec_file.c                   | 51 ++++++++++++++++-----------
 5 files changed, 49 insertions(+), 57 deletions(-)

-- 
2.35.3

