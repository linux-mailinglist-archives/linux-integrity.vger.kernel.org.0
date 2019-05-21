Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B2A244E0
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2019 02:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfEUAGu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 May 2019 20:06:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38562 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfEUAGt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 May 2019 20:06:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so7466513plb.5;
        Mon, 20 May 2019 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LZa++BrYOfKaDAjYx2CGBvGNn51YJo85WGkTuEuNxpQ=;
        b=eA8VpAZGxR9ZgtFPqco0xH037UTt9tECb93K+cuckwJpP9b5GxzU6LGblkEtz/moKu
         gMWye9uPKj8vmQNWgiSRlQOil59G7Lu59TJ42Gfwr+X/geGrTEpmrGWycx+WH+8jhUC1
         slA+KaeC6PrPa4pcSjj9u0pt8YGjLdfYM0i6U+wYNh/KdavsHfAgN/uOzcXXoll0vmaO
         HOQXdc6vMZKBYniarXKeIIQLKoie7le0ealVOeOXt7vMPpW2ac4a5JPnlmzlaVU0yF5f
         3KqW2pKCLV+qUWwGTg+/luApbEqt8Bdn4VHKFijfmLgn8i09vwzVl1m2gXLI3aI47qnA
         sSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LZa++BrYOfKaDAjYx2CGBvGNn51YJo85WGkTuEuNxpQ=;
        b=hWdTCxZ4//1qSR/0w0/sCXmRV5Q3SA526igPAQPctV+XKrzPPhF6Tzfucy3ocYa8r5
         xmo0wWmXdhwsH1NuFbvK85iKUPwOWe7+9pUJGXtz0oaAKWkDcA/Cyz9mRhKEf9GJEj+T
         NE6nlx9YR2IrQIeWipDQ7Lo11gP07VTeJKOB5CY3oGctsLGGu0TFePdHYd1s1Ub181m6
         GWvOU4jzkIdKfuQBqqeFyeRy2fiS3qvx2qs4s6QZAokiO2C3y8fJOtVqlaNklimIYux6
         oKN2yNOkuJsnW409X1SeelOc+YC+lSy8nTnOe18JGUZkbK50zxSA2RjqPJAvvnwQmfhj
         YuzA==
X-Gm-Message-State: APjAAAW/A9qHXpPbzE3odc2XQnh4fJbIFPp4TH1Yzuf+x2kVGKBWsnZA
        OWNZdmgunlM0hh0oAAcd+hnSO4065FECSw==
X-Google-Smtp-Source: APXvYqznvpaJKk3LUwFJojm3izNi1A7mm57rC7UA90cj+HcReiN2d5/4j27Nw7pKrAIm6rvhGJDYUA==
X-Received: by 2002:a17:902:b949:: with SMTP id h9mr35567145pls.50.1558397208812;
        Mon, 20 May 2019 17:06:48 -0700 (PDT)
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com ([2001:4898:80e8:1:e5e3:4312:180a:c25e])
        by smtp.gmail.com with ESMTPSA id i16sm5939149pfd.100.2019.05.20.17.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 17:06:48 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mjg59@google.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        vgoyal@redhat.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v6 0/3] add new ima hook ima_kexec_cmdline to measure kexec boot cmdline args
Date:   Mon, 20 May 2019 17:06:42 -0700
Message-Id: <20190521000645.16227-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The motive behind the patch series is to measure the boot cmdline args
used for soft reboot/kexec case.

For secure boot attestation, it is necessary to measure the kernel
command line and the kernel version. For cold boot, the boot loader
can be enhanced to measure these parameters.
(https://mjg59.dreamwidth.org/48897.html)
However, for attestation across soft reboot boundary, these values 
also need to be measured during kexec_file_load.

Currently for Kexec(kexec_file_load)/soft reboot scenario the boot cmdline
args for the next kernel are not measured. For 
normal case of boot/hardreboot the cmdline args are measured into the TPM.

The hash of boot command line is calculated and added to the current 
running kernel's measurement list.  On a soft reboot like kexec, the PCRs
are not reset to zero.  Refer to commit 94c3aac567a9 ("ima: on soft 
reboot, restore the measurement list") patch description.

To achive the above the patch series does the following
  -adds a new ima hook: ima_kexec_cmdline which measures the cmdline args
   into the ima log, behind a new ima policy entry KEXEC_CMDLINE.
  -since the cmldine args cannot be appraised, a new template field(buf) is
   added. The template field contains the buffer passed(cmldine args), which
   can be used to appraise/attest at a later stage.
  -call the ima_kexec_cmdline(...) hook from kexec_file_load call.

The ima logs need to carried over to the next kernel, which will be followed
up by other patchsets for x86_64 and arm64.

Changelog:
V6:
  -add a new ima hook and policy to measure the cmdline
    args(ima_kexec_cmdline)
  -add a new template field buf to contain the buffer measured.
  [suggested by Mimi Zohar]
   add new fields to ima_event_data to store/read buffer data.
  [suggested by Roberto]
  -call ima_kexec_cmdline from kexec_file_load path

v5:
  -add a new ima hook and policy to measure the cmdline
    args(ima_kexec_cmdline)
  -add a new template field buf to contain the buffer measured.
    [suggested by Mimi Zohar]
  -call ima_kexec_cmdline from kexec_file_load path

v4:
  - per feedback from LSM community, removed the LSM hook and renamed the
    IMA policy to KEXEC_CMDLINE

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

Prakhar Srivastava (3):
  Add a new ima hook ima_kexec_cmdline to measure cmdline args
  add a new ima template field buf
  call ima_kexec_cmdline to measure the cmdline args

 Documentation/ABI/testing/ima_policy      |  1 +
 Documentation/security/IMA-templates.rst  |  2 +-
 include/linux/ima.h                       |  2 +
 kernel/kexec_file.c                       |  8 ++-
 security/integrity/ima/ima.h              |  3 +
 security/integrity/ima/ima_api.c          |  5 +-
 security/integrity/ima/ima_init.c         |  2 +-
 security/integrity/ima/ima_main.c         | 80 +++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |  9 +++
 security/integrity/ima/ima_template.c     |  2 +
 security/integrity/ima/ima_template_lib.c | 20 ++++++
 security/integrity/ima/ima_template_lib.h |  4 ++
 12 files changed, 131 insertions(+), 7 deletions(-)

-- 
2.17.1

