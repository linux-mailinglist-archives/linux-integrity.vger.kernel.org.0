Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7445E448E6
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 19:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfFMRME (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 13:12:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42668 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbfFLWQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 18:16:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id l19so7077532pgh.9;
        Wed, 12 Jun 2019 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50PXAoiseRLWKqIb7OtWEpaVhpI7JnjdwO7ARnWibU0=;
        b=icj8iRGZDF/ZJx+loILNNjs4C+KWLauz5lfr+Tccz/X5CVmpJkNCsGxH0RUb1GhDM2
         1hWOGudmDN6yvLFza60VkcIULcXF6I4GobhahVnElVABXWnPwbj8Ad3Z4FFl6pI8bfHv
         6LZkpOiEBGUX1uo2m8H3X0dGKhDnKtYZhEVThebqnrncvdxjfWSH94+YLUsZqjPQq6rq
         cuZ7HRtT+ubNmR8OivEWEbVoH60j0AEgPrKQY6clqDut7e2MAIgOnabRNbVtXZtrXc8Z
         lmWKrq8xiv6/7ryx+De+bmjm1eIObNeBpU2pK5Tvgm6drs9NTLRu9l0nV6xWO/Hl4JOY
         C3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50PXAoiseRLWKqIb7OtWEpaVhpI7JnjdwO7ARnWibU0=;
        b=gFC5xVNe0D+c02vHK5Ip99zDtb6R6j3soLpl4tMLgdT+2TCkHo98/KlwYDdNTNVMEk
         M+JIXyTVYrnWgyG2v5S2srhWkLc4hQifLc7eJEIR/Ae6ninNo0B0csP8vJLaOkn2ucyB
         tcnwdwjHpCimi/eOD+sbYH84B11/GIt4jaEVpB/xUEems05yfuNlhbWM4n2sYGd+Oqy6
         v5tcvwUrdxeNpeio0J3l7axNKRo5O/TwZeDKfpk+85qprMaWSqjAVWYXhsCoh3yuKrfd
         PksfU1JF/85Iif30ukG3vw6HMT4z7+SP4uNoojZdzZ6la7hPaitu1vMOuoPsuxDRshIF
         ZR5g==
X-Gm-Message-State: APjAAAUpNGq4OtRGApOTjZ7AvJxrzZB5h3zfRg3eLTg5O5kJ1E+8/h6A
        sefXAvj96DFh6r1fcRhhYCtfQyGp
X-Google-Smtp-Source: APXvYqycTsh98tnCNefzfzOzPReWZq3/iQw+UWpZ4cK8K3Os/5Wa3dO7FaqfHDGp1094qnYj4yhR8A==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr26516528pgq.399.1560377763876;
        Wed, 12 Jun 2019 15:16:03 -0700 (PDT)
Received: from localhost.localdomain ([167.220.56.169])
        by smtp.gmail.com with ESMTPSA id f7sm506517pfd.43.2019.06.12.15.16.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 15:16:03 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V8 0/3] Add support for measuring the boot command line during kexec_file_load
Date:   Wed, 12 Jun 2019 15:15:46 -0700
Message-Id: <20190612221549.28399-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kexec boot command line arguments are not currently being
measured.

Currently during soft reboot(kexec) 
  - the PCRS are not reset
  - the command line arguments used for the next kernel are not measured.
This gives the impression to the secure boot attestation that a cold boot took
place.
For secure boot attestation, it is necessary to measure the kernel
command line. For cold boot, the boot loader can be enhanced to measure 
these parameters.
(https://mjg59.dreamwidth.org/48897.html)

This patch set aims to address measuring the boot command line during
soft reboot(kexec_file_load).

To achive the above the patch series does the following
  -Add a new ima hook: ima_kexec_cmdline which measures the cmdline args
   into the ima log, behind a new ima policy entry KEXEC_CMDLINE.
   The kexec cmdline hash is stored in the "d-ng" field of the template data.
  -Since the cmldine args cannot be appraised, a new template field(buf) is
   added. The template field contains the buffer passed(cmldine args), which
   can be used to appraise/attest at a later stage.
   The kexec cmdline buffer is stored as HEX in the buf field of the event_data.
  -Call the ima_kexec_cmdline(...) hook from kexec_file_load call.

The ima logs need to be carried over to the next kernel, which will be followed
up by other patchsets for x86_64 and arm64.

The kexec cmdline hash is stored in the "d-ng" field of the template data.
and can be verified using
sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | 
  grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum

Changelog:
V8(since V7):
  - added a new ima template name "ima-buf" 
  - code cleanup

V7:
  - rebased to next-queued-testing
  https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/log/?h=next-queued-testing

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

