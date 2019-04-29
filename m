Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1325FEC40
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2019 23:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfD2Vrv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 17:47:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39780 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbfD2Vrv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 17:47:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so5797179pgj.6;
        Mon, 29 Apr 2019 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBUcc2CKF+g+0S5WLNXWMjpaMCDOiWiifFzLFrXOrh4=;
        b=YEVXM/ke3RubBHfTN7y4oEVjSQScjcsOAWWKNiJKSLt1Y+lyo+ed77sTMUMuwmvhxL
         rZbXVxe1GEpdK7BWoYZxR3qEoCM/8QTQKxgohAEKq87NUK2x3WmJ2mTBffSpHgNHpKUQ
         76QPiwlbdq+sPLKXOc5NW980ONZaaN3FX9Is9z73QccXXLgRhlcFr6nQgOVBYGYQ6Bkn
         PP5V3H7W6a822iVbYKaTuGUMLI4lGyrDq001E9iAgg6N/MGmdEhVWHq+Azl7UpV9glKs
         4zvLmhiJ98fM3WFNS8lAs8SV8tCI5goyO/ncJSTB/z9oiCs6t9rXHMmBpBZi1Ud/XClT
         RmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MBUcc2CKF+g+0S5WLNXWMjpaMCDOiWiifFzLFrXOrh4=;
        b=CxZmJ/C/+44z2vxwpaOzy+YfgskAEoRFP8e891usTFDapx3iV6guZoRApMVRMlOj7k
         S6mpmYfwICjt32fx2/GANjtNYFOE1h8uW28jOQLu2Uwu3y85RI6y3vRClLUVys/O0kbh
         xWnQu5bykF6NSlp2iWuGdo0WEftoDEPmg62Oo9tByHOGeE8QoSLuAKN/0FavlYK7ODre
         lh7T++00Fo/bpE7bg8/BnS/4hxDrk1oWkXCdw4/kkrXbXVt4mayYz0YcQwfgWXMV5k1P
         c1YWiDG6UyFBYAU/3l/Nrh1uR+gCeQoWZhkqX82VOUD/ppNxoIKG8QpzI2/yaq37KFVL
         HpKg==
X-Gm-Message-State: APjAAAVVdorPl9a3NMJ8wXeiDk1XaLoSH+iqcd1BmLMXbYERqlNf0dVR
        j46SCREwMfw7SQf/u1eP5n8DiQZsReo=
X-Google-Smtp-Source: APXvYqxg9x34IcLeO8szE54iKKYBk/jVn6ulPOkPrsun980rDATa8A+EslOQQq1X7Aw8ozgjL7CDTw==
X-Received: by 2002:a62:1d83:: with SMTP id d125mr29237912pfd.74.1556574470266;
        Mon, 29 Apr 2019 14:47:50 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:9:445d:9822:2ddb:fb8c])
        by smtp.gmail.com with ESMTPSA id f66sm1941623pfg.55.2019.04.29.14.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:47:49 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v3 0/4] Add a new ima_hook buffer_check to measure buffers critical for attestation
Date:   Mon, 29 Apr 2019 14:47:39 -0700
Message-Id: <20190429214743.4625-1-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
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
Prakhar Srivastava (4):
  added a new ima policy func buffer_check, and ima hook to measure the
    buffer hash into ima
  add the buffer to the xattr
  add kexec_cmdline used to ima
  added LSM hook to call ima_buffer_check

 Documentation/ABI/testing/ima_policy      |   1 +
 include/linux/ima.h                       |   5 +
 include/linux/lsm_hooks.h                 |   3 +
 include/linux/security.h                  |   3 +
 kernel/kexec_core.c                       |  57 +++++++++++
 kernel/kexec_file.c                       |  14 +++
 kernel/kexec_internal.h                   |   4 +-
 security/integrity/ima/ima.h              |   1 +
 security/integrity/ima/ima_api.c          |   1 +
 security/integrity/ima/ima_main.c         | 116 ++++++++++++++++++++++
 security/integrity/ima/ima_policy.c       |   8 ++
 security/integrity/ima/ima_template_lib.c |   3 +-
 security/integrity/integrity.h            |   1 +
 security/security.c                       |   6 ++
 14 files changed, 221 insertions(+), 2 deletions(-)

-- 
2.19.1

