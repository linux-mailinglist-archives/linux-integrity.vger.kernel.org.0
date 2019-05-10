Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9621A53B
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2019 00:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEJWcn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 May 2019 18:32:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39895 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfEJWcn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 May 2019 18:32:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so3929599pfg.6;
        Fri, 10 May 2019 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+255BtjDrWFcTuDxCj5nFKkQD94X9Yssaoo6B+/8b2U=;
        b=NOmnPjuD04nIc02QXIFKm3QTuHfjzToD3ZgNFSrdPMO5dIOMlT6UXj115797UW6l89
         z4CJNMm9RNlng6Vw/ng67qSHe8A5Agkoo7+4AUcOqLyqpcsZTtaOnmFWWzheItd5gEKM
         QAn/Y5BO1ysNXIZO1aytFtKL7d6qA8AJnADODvtnzEb6tI1KUTiphMe+F+e3o0jVvsEG
         SJM1N7RGI4s62nPlsFssglonQj51X7zfrE8V9dteCGzjRIqRkVEWIs/oVuABx4hp1/sX
         sT3DCtImrnMZ2HMEJRpDZOuEcdQXoDAhIfVe6VaUG+hUMtLHFwjH7g8Xqzk/hZgAlg1K
         h4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+255BtjDrWFcTuDxCj5nFKkQD94X9Yssaoo6B+/8b2U=;
        b=YoAmXTLUm58fOFhHF/k0wRMR6ymluYoYpSZYaBF8Le0D+q5nCjunFHxXq5kKdbhpip
         07yWiQwoG+wo09u7osMina9B3HkEKtSeBKkKGEjYfm9zDhIhi6bDOmGTinExAZ/XMMxh
         pWGR+7tglp6yZgzU9rS02Jc8x8OJly8TbR2DkexxGAYdLfiox8Mm0P70tX5zZ7zrVHfW
         ykH9ebgT35o3elsiLYT4SDE+cppHm8QibOK8zqbgzOcIT107G5A8oG+/IvhQx8A6ZTjN
         QtCQjw6Sa2acok2fXpue5l18LZYREWmxb9o0fkAoVEtmxhayMW0XVx09+ZwAGxDtSesI
         Hh9A==
X-Gm-Message-State: APjAAAVVLcLBHaVem6bHwtw7k39zvDJCg/hHIaW9nTJ1I22YIJVzn2Nc
        pHRl+u85erXfyx7T1B0SgWjt3Ngf+tE=
X-Google-Smtp-Source: APXvYqwMJE223HSR6xQ7XCRMEg4xGyUHCSt1TQlPLe9+3/1iVa9TFbAcIz0VqUX1mkT3E3l5TxyJWA==
X-Received: by 2002:a65:57ce:: with SMTP id q14mr2714727pgr.109.1557527562205;
        Fri, 10 May 2019 15:32:42 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:a:1d1b:db59:93e9:eab5])
        by smtp.gmail.com with ESMTPSA id g72sm16907374pfg.63.2019.05.10.15.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:32:41 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        prsriva@microsoft.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 0/3 v5] Kexec cmdline bufffer measure
Date:   Fri, 10 May 2019 15:32:25 -0700
Message-Id: <20190510223228.9966-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

For secure boot attestation, it is necessary to measure the kernel
command line and the kernel version. For cold boot, the boot loader
can be enhanced to measure these parameters.
(https://mjg59.dreamwidth.org/48897.html)
However, for attestation across soft reboot boundary, these values 
also need to be measured during kexec.

Currently for Kexec(kexec_file_load)/soft reboot scenario the cmdline
args that are used to boot the next kernel is not measured. For 
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
  add a new ima hook and policy to measure the cmdline
  add a new template field buf to contain the buffer
  call ima_kexec_cmdline from kexec_file_load path

 Documentation/ABI/testing/ima_policy      |   1 +
 include/linux/ima.h                       |   2 +
 kernel/kexec_file.c                       |   2 +
 security/integrity/ima/ima.h              |   1 +
 security/integrity/ima/ima_api.c          |   1 +
 security/integrity/ima/ima_main.c         | 107 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |   9 ++
 security/integrity/ima/ima_template.c     |   2 +
 security/integrity/ima/ima_template_lib.c |  21 +++++
 security/integrity/ima/ima_template_lib.h |   4 +
 security/integrity/integrity.h            |   1 +
 11 files changed, 151 insertions(+)

-- 
2.20.1

