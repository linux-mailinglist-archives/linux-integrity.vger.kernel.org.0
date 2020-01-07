Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554B5132FB4
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jan 2020 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgAGTnz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jan 2020 14:43:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34188 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgAGTnz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jan 2020 14:43:55 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 523E72007683;
        Tue,  7 Jan 2020 11:43:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 523E72007683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1578426234;
        bh=WXotn1iSKnCuEmTsYF5Dp7o6kjEJuPdeZMzgjAtruXM=;
        h=From:To:Cc:Subject:Date:From;
        b=tQksiQGLBVmnl3G2L1YmWnC0O1yK837EQZwDmMfDuhiQKynyq7CgUiemLfgpblsms
         mLq/l6byFh6QZ4YG4QTvgPciMO6ejyx9hQBT/9Hi4phAPvzxWIFJ3X8a3uQ9jwZsBx
         YHVuaC/2AyR524O0oVlCslwFS9ULsKqUToXYsmZQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH 0/4] KEYS: Measure keys when they are created or updated
Date:   Tue,  7 Jan 2020 11:43:46 -0800
Message-Id: <20200107194350.3782-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

commit 88e70da170e8 ("IMA: Define an IMA hook to measure keys")
in next-integrity added an IMA hook to measure keys when they
are created or updated in the system. This hook is defined in
ima_asymmetric_keys.c which was built if
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was defined.
But this config is a tristate (and not a bool type).
If CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE was set to "m" in
the .config, ima_asymmetric_keys.c was built as a kernel module
when it is not a kernel module. This issue was reported by
"kbuild test robot <lkp@intel.com>".

This change defines a new config namely
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS to enable building
ima_asymmetric_keys.c. This new config is enabled when both
CONFIG_IMA and CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE are defined.

Lakshmi Ramasubramanian (4):
  IMA: Define an IMA hook to measure keys
  KEYS: Call the IMA hook to measure keys
  IMA: Add support to limit measuring keys
  IMA: Read keyrings= option from the IMA policy

 Documentation/ABI/testing/ima_policy         | 10 ++-
 include/linux/ima.h                          | 14 +++
 security/integrity/ima/Kconfig               |  9 ++
 security/integrity/ima/Makefile              |  1 +
 security/integrity/ima/ima.h                 |  8 +-
 security/integrity/ima/ima_api.c             |  8 +-
 security/integrity/ima/ima_appraise.c        |  4 +-
 security/integrity/ima/ima_asymmetric_keys.c | 58 +++++++++++++
 security/integrity/ima/ima_main.c            |  9 +-
 security/integrity/ima/ima_policy.c          | 91 ++++++++++++++++++--
 security/keys/key.c                          | 10 +++
 11 files changed, 204 insertions(+), 18 deletions(-)
 create mode 100644 security/integrity/ima/ima_asymmetric_keys.c

-- 
2.17.1

