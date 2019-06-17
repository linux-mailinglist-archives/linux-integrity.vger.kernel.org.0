Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC09748C25
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFQShv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 14:37:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44980 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQShv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 14:37:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id t7so4449185plr.11;
        Mon, 17 Jun 2019 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4OHwdYbt/r9QOgUFQk/+P05Y1e0rv2+F/B2pG+BHiA=;
        b=iGNTNPGSOgtvFH/gdtfFHCgrCEao9MyKk/SilMJoxxKExyimgQb+BEg+9w4yLGFIb1
         3ZECqBHf/b3mfL6okhY7EktJdKhpdBoTwbTUUw7rg3rRYpWqrDn7tUVe9ubwY8ViQJTz
         3tJxsmdc1Aja3O/TVMMfM9QgdK4FJI1v5NvMZjfhR5l8Tsu0p5pAyQMQKYhGl+36onw/
         GwX9XyHV3Mr3MwPZpva7eDbTzjbWC4GSDsOmjulOwsuFP39ZlPXr6ScmtHdEEfrhFTao
         NaYBnFqKO4qIWqvERBw5r6hWKNwQJpx4Vm2uWw2QWWEG8mnz2SyFTWSHB48n4DUsz0o7
         iXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4OHwdYbt/r9QOgUFQk/+P05Y1e0rv2+F/B2pG+BHiA=;
        b=MwIAa2kP8y0omIAF/MJrHfMpi92UYNQfo92iDeFKwHYnJ9qlvxHJ/i72lnUlOucKZB
         UgKaRbBtgclySYAzDe+b96IGS7Wi8BKm1plfA0vnG/7eDFM/wDtacN80h8WseBYi/p+w
         hy3HtiDudaHSHmkEuoGQKl4EXfpBLafQpK+GZy6foUBEK624I/ocis4X79dS9PDqs716
         lZF84G54APAOzbd+UvijKy1h0vtXF55emCa6GHxzyfEkafzquvRkCn0RK5z53J2B3FYf
         6O7HvBOHlsNtz8L+GPqB9DxjFgMLmMKMyfC4wgar2aJwKwCWUi17tzafHYCrA65keSqp
         eXDg==
X-Gm-Message-State: APjAAAXrssxmBOtlUOSMX1MGerTfxSmk/WyPz0J+l7WGLqINZQr3bCz6
        sODDncyDGitfpginUhJ0Tceo5VL9
X-Google-Smtp-Source: APXvYqzScM+RDnyzesVs86Qc4NlCbVdlwq1/7jteA+j3W3d9g1CMR7R3tx27w1WqgkmcVy/avETPtQ==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr86162012plp.194.1560796670075;
        Mon, 17 Jun 2019 11:37:50 -0700 (PDT)
Received: from localhost.localdomain ([167.220.56.169])
        by smtp.gmail.com with ESMTPSA id f17sm13104817pgv.16.2019.06.17.11.37.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:37:49 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH V8 0/3] Add support for measuring the boot command line during kexec_file_load
Date:   Mon, 17 Jun 2019 11:37:35 -0700
Message-Id: <20190617183738.14484-1-prsriva02@gmail.com>
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
V9(since V8):
  - code cleanup

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

