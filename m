Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B089574F63
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jul 2022 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbiGNNkn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jul 2022 09:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiGNNkm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jul 2022 09:40:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A5ED60516
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PG1WsGRWRvVRe8I3xrLjHusVh6PAsG2ZTZ2d691+jyw=;
        b=BQoh5CWFiRkyRi9H8I5vgO0L6bdAD5/bLA7od3QL8SwVYpRUhUpOBvtBig4nKo+4E8hpmn
        9kl6hTHk0vwD5XW45484nimiRhHiplPcDTQO7TlQHoxhA5MZJMtR0rAlbCVDBCCy6JFASH
        b97+Mtw87CSxFp19zsF1iul4dHvooSo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-FaXdbTiDMFmngZ_ZC6G4mA-1; Thu, 14 Jul 2022 09:40:38 -0400
X-MC-Unique: FaXdbTiDMFmngZ_ZC6G4mA-1
Received: by mail-pj1-f70.google.com with SMTP id k7-20020a17090a62c700b001ef9c16ba10so3725352pjs.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Jul 2022 06:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PG1WsGRWRvVRe8I3xrLjHusVh6PAsG2ZTZ2d691+jyw=;
        b=MyuI2LnNfcVoIVuB6jiWnurp5f/ib2TxVttg8ptjVhNnwLTFp/qn7JHEzIupsYyqfy
         /M1FwWJtXhvktkVl57C4gy6DN27ygDKgMcvYq9VAD2aDtLS2dQJmM8DwlGGZtCSqmjXs
         fr7tex2vhJv9N2mwIuk+bB+9k9B3tUhsHsItzW6yZv0G82By9sO3sbtgFZOTl03CXP57
         qlsOHCvRCJyEe20Px7eG+sU2e/1rLFvR3DiideeE9pcMjSoYBRIieuygtUeMIBYlGxRg
         Kh3IFoYe4roDnYMh9tyZ7NGz/WIS4ov9OSM/NeL6QkCIea3JbstW8b7mpagnvPbsCGt8
         vHQw==
X-Gm-Message-State: AJIora89pIh35epOM7hhwvuYfFkItjUrAfbQ78Sh03lkx+Uej3CccBAd
        n9O3dITd9UijK4pL/bdbdTLl07uDUYvAmsxCSAqBq+X0o2qwAj2RW8smrTIKbiNk1+D2LKhhw+7
        hyCkOOBY0XRLQvo/9iOTl/yTFk1mw
X-Received: by 2002:a63:68c7:0:b0:405:1da9:ab69 with SMTP id d190-20020a6368c7000000b004051da9ab69mr7922149pgc.233.1657806036911;
        Thu, 14 Jul 2022 06:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uVKyvFxKJJVTEcre0pPRg6laUS8s7uC3NACW6lW/xJmM7S6uGd27qyh4tX8GUQRRZJI8PDrg==
X-Received: by 2002:a63:68c7:0:b0:405:1da9:ab69 with SMTP id d190-20020a6368c7000000b004051da9ab69mr7922129pgc.233.1657806036590;
        Thu, 14 Jul 2022 06:40:36 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902650300b0016a0bf0ce32sm1489511plk.70.2022.07.14.06.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:40:36 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH v10 0/4] unify the keyrings of arm64 and s390 with x86 to verify kexec'ed kernel signature
Date:   Thu, 14 Jul 2022 21:40:23 +0800
Message-Id: <20220714134027.394370-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The 3rd arm64 patch depends on Naven's patch "[PATCH 1/2] kexec_file:
Drop weak attribute from functions" [2] and the first two patches.
With Naven's patch first applied to the next-integrity branch, I can
confirm these patches are directly appliable to the next-integrity
branch without any conflict. The 4th s390 patch can be applied
independently.

In v9, I've tested the patch set on 5.19.0-rc2 and it works as expected.

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

v10:
 - resolve conflict with Naveen's patch which drops weak attribute of
   arch_kexec_kernel_verify_sig

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
[2] https://lore.kernel.org/lkml/cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com/T/#mbd23f46b3714c3c9eecc7484c832a5af49bfa340

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
 kernel/kexec_file.c                   | 50 ++++++++++++++++-----------
 5 files changed, 49 insertions(+), 56 deletions(-)

-- 
2.35.3

