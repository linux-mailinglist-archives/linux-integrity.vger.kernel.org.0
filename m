Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35C513578
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2019 00:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfECWZ3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 18:25:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46723 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECWZ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 18:25:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so3348890pgg.13;
        Fri, 03 May 2019 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/tUiDqBf5AmMmz2flFiXm1GfWiuS6OV4yIyE7IsshQ=;
        b=UYDJUrh0TE7xjcRG4i15j10P0GwRx6MerKJFAbvKLnvs4E5PnYWOxPeCGKXVuRm2Tp
         /fmYBeWLAH3k1skmBHXpYebZWPE7VJ9no0yW3VVdq112ZV1G1bJSeKM7QENO+84Xzf4M
         iJ4UuFbQ60B2HfoH/DbKqGQDZnfN160PEk5+WSBK5QWuC9vwruncxMhoOUDUa4ktLhYt
         tjxCEn0Z+tbPicHWUVjeJlzwwr2xnD7o+K0JYOOSuukrXAMiNDczAJJt6b0Ow0//slZB
         CBDh7aeoOXTqXoNdi3HtKKO1ZHXGnfY5cv56Ri5/N+v/K3hw3BVhKSrP6pH/joz2A78+
         JvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U/tUiDqBf5AmMmz2flFiXm1GfWiuS6OV4yIyE7IsshQ=;
        b=JzRjwrQT/4zJjkdqSUjra4LjpA8BG2ZvUQiEfSKZUKJOyPvCEJInv7V2wYxvRPHQTl
         eu5v6RuoM+4eXun0jyuOgToMVpHDl6prL/4Uh6nXGlaf0YvXfz/hoGI74N8Ch649h9B+
         GKG5YyzpqUPzR7kUSOxQjbqeEQhnUO5AGK596Lf6KvxS1xLg/yJYU8pdFPkfITQeyUUn
         g5nb9/3pGX3fFwhxVaGns/wktjxckKpj25B+FEO2LfDn5JWMDUMF/bXcK3XUL3HzWv+Q
         opEEYhMOH7eKBeripA/2c6+06QCEiGtVhCtU5741C7p0kCGxXdtokGAWv0FbTXpOw3Cc
         AFVw==
X-Gm-Message-State: APjAAAWxA+PUADZKSOUXeyamLEg7oBf6lv1RoEN6Kfqa+20x4vmF8Liu
        +zGJRaB6nqknSmpy2cK3H96q3xdWmTs=
X-Google-Smtp-Source: APXvYqyAR8txpw3uBMAtZFHgbBeP+0KhhHXO2G0V/SUnhbzFWzo5RlFn9RAdVJ2bPqNJol0fATKB3g==
X-Received: by 2002:a63:c243:: with SMTP id l3mr13774374pgg.448.1556922328437;
        Fri, 03 May 2019 15:25:28 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:b:3170:1a6b:a13a:7ff])
        by smtp.gmail.com with ESMTPSA id j22sm4314337pfi.139.2019.05.03.15.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:25:27 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, nramas@microsoft.com, prsriva@microsoft.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 0/5 v4] Kexec cmdline bufffer measure
Date:   Fri,  3 May 2019 15:25:18 -0700
Message-Id: <20190503222523.6294-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

For Kexec scenario(kexec_file_load) cmdline args are passed to the
next kerenel. These cmldine args used to load the next kernel can 
have undesired/unwanted configs. To guard against any unwanted cmdline
args being passed to the next kernel. The current kernel should measure
the cmdline args to the next kernel, the same takes place in the EFI
bootloader. Thus on kexec the boot_aggregate does not change.

Currently the cmdline args are not measured, this changeset adds a new
ima and LSM hook for buffer measure and calls into the same to measure
the cmdline args passed to the next kernel.The cdmline args meassured
can then be used as an attestation criteria.

The ima logs need to injected into the next kernel, which will be followed
up by other patchsets.


Changelog:
v4:
  - per feedback from LSM community, removed the LSM hook and renamed the
    IMA policy to KEXEC_CMDLINE[Suggested by: Mimi Zohar]

v3: (rebase changes to next-general)
  - Add policy checks for buffer[suggested by Mimi Zohar]
  - use the IMA_XATTR to add buffer
  - Add kexec_cmdline used for kexec file load
  - Add an LSM hook to allow usage by other LSM.[suggestd by Mimi Zohar]

v2:
  - Add policy checks for buffer[suggested by Mimi Zohar]
  - Add an LSM hook to allow usage by other LSM.[suggestd by Mimi Zohar]
  - use the IMA_XATTR to add buffer instead of sig template

v1:
  -Add kconfigs to control the ima_buffer_check
  -measure the cmdline args suffixed with the kernel file name
  -add the buffer to the template sig field.

Prakhar Srivastava (5):
  added a new ima policy func buffer_check, and ima hook to measure the
    buffer hash into ima
  add the buffer to the xattr
  add kexec_cmdline used to ima
  added LSM hook to call ima_buffer_check
  removed the LSM hook made available, and renamed the ima_policy to be
    KEXEC_CMDLINE

 Documentation/ABI/testing/ima_policy      |   1 +
 include/linux/ima.h                       |   3 +
 include/linux/security.h                  |   2 +
 kernel/kexec_core.c                       |   2 +-
 kernel/kexec_file.c                       |   4 +
 kernel/kexec_internal.h                   |   4 +-
 security/integrity/ima/ima.h              |   1 +
 security/integrity/ima/ima_api.c          |   1 +
 security/integrity/ima/ima_main.c         | 115 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |   8 ++
 security/integrity/ima/ima_template_lib.c |   3 +-
 security/integrity/integrity.h            |   1 +
 12 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.20.1

