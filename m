Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC0276BC23
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjHASTa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 14:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjHAST2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 14:19:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CBB22130
        for <linux-integrity@vger.kernel.org>; Tue,  1 Aug 2023 11:19:27 -0700 (PDT)
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 25642238AE99;
        Tue,  1 Aug 2023 11:19:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25642238AE99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690913966;
        bh=b4OdcS9sda7T2b0PHVgizsmccOm9TXwQxgnEJfHhAx0=;
        h=From:To:Cc:Subject:Date:From;
        b=eS8FMRFIyDnqlgfFkDfZxDa/G5VqNOJ6/fDUQwPB0pU/HNFouLWc1OUHO9MraPEvv
         UTleLgGK+Qy6d/+7fXseSeLfG2uECVRl8l11t3dZF+A+q0OCb65ziVTTb5UES0gwpr
         rjgCE5Ye22xF3DeTjmFHQU1NdUuysEYAsL4O6jDU=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com,
        ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Subject: [PATCH 0/6] Measuring TPM update counter in IMA
Date:   Tue,  1 Aug 2023 11:19:11 -0700
Message-Id: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Entries in IMA log may be lost due to code bugs, certain error conditions
being met etc.  This can result in TPM PCRs getting out of sync with the
IMA log.  One such example is events between kexec 'load' and kexec
'execute' getting lost from the IMA log when the system soft-boots into
the new Kernel using kexec[1].  The remote attestation service does not
have any information if the PCR mismatch with IMA log is because of loss
of entries in the IMA log or something else.  TPM 2.0 provides an update
counter which is incremented each time a PCR is updated [2]. Measuring the
TPM PCR update counter in IMA subsystem will help the remote attestation
service to validate if there are any missing entries in the IMA log, when
the system goes through certain important state changes (e.g. kexec soft
boot, IMA log snapshotting etc.)

This patch series provides the required functionality to measure the
update counter through IMA subsystem by -
 - introducing a function to retrieve PCR update counter in the TPM
   subsystem.
 - IMA functionality to acquire the update counter from the TPM subsystem.
 - Measuring the update counter at system boot and at kexec Kernel
   load.


This patch series would be a prerequisite for the next version of kexec
load/execute series[1] and the future IMA log snapshotting patch series.

[1] https://lore.kernel.org/all/20230703215709.1195644-1-tusharsu@linux.microsoft.com/
    ima: measure events between kexec load and execute

[2] https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part3_Commands_pub.pdf
    Section 22.4.2, Page 206.

Tushar Sugandhi (6):
  tpm: implement TPM2 function to get update counter
  tpm: provide functionality to get update counter
  ima: get TPM update counter
  ima: implement functionality to measure TPM update counter
  ima: measure TPM update counter at ima_init
  kexec: measure TPM update counter in ima log at kexec load

 drivers/char/tpm/tpm-interface.c   | 28 +++++++++++++++++
 drivers/char/tpm/tpm.h             |  3 ++
 drivers/char/tpm/tpm2-cmd.c        | 48 ++++++++++++++++++++++++++++++
 include/linux/ima.h                |  1 +
 include/linux/tpm.h                |  8 +++++
 kernel/kexec_file.c                |  3 ++
 security/integrity/ima/ima.h       |  2 ++
 security/integrity/ima/ima_init.c  |  3 ++
 security/integrity/ima/ima_main.c  | 29 ++++++++++++++++++
 security/integrity/ima/ima_queue.c | 16 ++++++++++
 10 files changed, 141 insertions(+)

-- 
2.25.1

