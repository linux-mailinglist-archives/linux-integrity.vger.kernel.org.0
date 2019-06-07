Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBA38214
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 02:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfFGAX5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Jun 2019 20:23:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40768 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfFGAX5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Jun 2019 20:23:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id a93so99615pla.7;
        Thu, 06 Jun 2019 17:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7baCNdLYbYtbBAPVnrR79aDif7IQ3JuxKMalrA0cRxA=;
        b=ZbBcKB07wsg9y7AD+2DP8kQU5c3rUKUoc0Ed/BLK4KML4KtGql3UPPMpgRb4Wv/hAR
         syKZOuXPtLp3OZDEC1DaJou9faUFDUCzX+BvR4sumhJ0UM4C+Rdo6tKsf/Y/cgKuMKur
         iisQURKAMJC/qmrFsavP0/73UJnmk6NN7EiKJlt1U5n5Gr0kgrZNZTv/S1wtCUgwGu28
         NK57IpeCsxT2rZPD/91layNcGKX+HcTI+5+FxdutgowrZEAYHKhjv6JAUSY3MGfVcROW
         Qn6gPzQ29eywCCfFdjnmG0v90VxleYZk5AF9ZnNJ+CZiCYDeQ3g8SeNCIkGBdZbGBkvm
         m0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7baCNdLYbYtbBAPVnrR79aDif7IQ3JuxKMalrA0cRxA=;
        b=GmMyFl9K7/hEGScKrA5fRoWKPyER+Q8zXN6M0cPAgdPB/afGFnOKq6O+L1VDSNfLvF
         zywuH60405WinIh2D+2rBgTe9FfuWFEtrd3xFVSxFTK12CnrnrrdOIa374qjeV3TNMCY
         Uj1POIlaehGfGiYMTdIQzIX481nbS9geHB0dEe/WxQ3+HotWI2shQK/st45MuAlYB1PQ
         /FW4qmn1fChB4dDOOlvNxPRmvF6umOfFkocloyOxfwZKC2H8AIQlltmiytFdb9ctZqws
         h16gMQVRto4J3wLIoVqQ7YHJhFqyQh+zn8kDd5Lg7NYF+b7jjn+Z4KhwZbxlJEdoSFJr
         Cvdw==
X-Gm-Message-State: APjAAAV5/TFpStT13vKACW8D+z/QhsbflG/f8vo8M2dYQ7CIOXNq5yw0
        nb/IP+1uleLxYAghLsGnMqM9bsq+
X-Google-Smtp-Source: APXvYqxtaG/tzrII8Zf6fcs7LA9Fi0ya9WLZ0bXdbFajZQo6MNRju4UsO8VUXVamzAmikc0WynKdhA==
X-Received: by 2002:a17:902:d701:: with SMTP id w1mr46986994ply.12.1559867036005;
        Thu, 06 Jun 2019 17:23:56 -0700 (PDT)
Received: from localhost.localdomain ([167.220.98.69])
        by smtp.gmail.com with ESMTPSA id o13sm324179pfh.23.2019.06.06.17.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 17:23:55 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, roberto.sassu@huawei.com, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v7 0/3] add new ima hook ima_kexec_cmdline to measure kexec boot cmdline args
Date:   Thu,  6 Jun 2019 17:23:27 -0700
Message-Id: <20190607002330.2999-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
running kernel's measurement list.
On a soft reboot like kexec, no cmdline arguments measurement takes place.

To achive the above the patch series does the following
  -adds a new ima hook: ima_kexec_cmdline which measures the cmdline args
   into the ima log, behind a new ima policy entry KEXEC_CMDLINE.
  -since the cmldine args cannot be appraised, a new template field(buf) is
   added. The template field contains the buffer passed(cmldine args), which
   can be used to appraise/attest at a later stage.
  -call the ima_kexec_cmdline(...) hook from kexec_file_load call.

The ima logs need to be carried over to the next kernel, which will be followed
up by other patchsets for x86_64 and arm64.

The kexec cmdline hash can be verified using
sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | 
  grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum

Changelog:
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

