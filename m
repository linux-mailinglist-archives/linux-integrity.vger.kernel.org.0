Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A231637FC
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2020 01:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBSAGW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Feb 2020 19:06:22 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44374 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBSAGW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 19:06:22 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 74E4F20B9C02;
        Tue, 18 Feb 2020 16:06:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74E4F20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582070781;
        bh=UT3TrhMzxCCip80EgbqalVA8034WZCrq8uLhLeB3VQg=;
        h=From:To:Cc:Subject:Date:From;
        b=RP35KWjmK2GFDkIyBlJLJs1+sHTDTHTyov/LsVHgK8HK9FySzcuetUOcXfqUEbRC4
         DqnUF666iT69/ClpA3mLw0wBrEZA0fcl4LUxt/wsgdtterQETbkOL6wGai1epJ0072
         E2PGxNMj/gAZMOJ0qkOSsY8WqPKWyv1uGZeAeA3s=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] integrity: improve log messages
Date:   Tue, 18 Feb 2020 16:06:08 -0800
Message-Id: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The log messages from integrity subsystem should be consistent for better
diagnosability and discoverability.

This patch set improves the logging by removing duplicate log formatting
macros, adding a consistent prefix to the log messages, and adding new 
log messages where necessary.

Tushar Sugandhi (3):
  add log prefix
  add log message to process_buffer_measurement failure conditions
  add module name prefix to log statements

 security/integrity/digsig.c                  | 2 --
 security/integrity/digsig_asymmetric.c       | 2 --
 security/integrity/evm/evm_crypto.c          | 2 --
 security/integrity/evm/evm_main.c            | 2 --
 security/integrity/evm/evm_secfs.c           | 2 --
 security/integrity/ima/Makefile              | 6 +++---
 security/integrity/ima/ima_asymmetric_keys.c | 2 --
 security/integrity/ima/ima_crypto.c          | 2 --
 security/integrity/ima/ima_fs.c              | 2 --
 security/integrity/ima/ima_init.c            | 2 --
 security/integrity/ima/ima_kexec.c           | 1 -
 security/integrity/ima/ima_main.c            | 5 +++--
 security/integrity/ima/ima_policy.c          | 2 --
 security/integrity/ima/ima_queue.c           | 2 --
 security/integrity/ima/ima_queue_keys.c      | 2 --
 security/integrity/ima/ima_template.c        | 2 --
 security/integrity/ima/ima_template_lib.c    | 2 --
 security/integrity/integrity.h               | 6 ++++++
 18 files changed, 12 insertions(+), 34 deletions(-)

-- 
2.17.1

