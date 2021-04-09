Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558F7359D9C
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhDILn6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 07:43:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2818 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhDILn5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 07:43:57 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGx1305h1z687PM;
        Fri,  9 Apr 2021 19:36:39 +0800 (CST)
Received: from fraphisprd00473.huawei.com (7.182.8.141) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 13:43:42 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 0/7] ima/evm: Small enhancements
Date:   Fri, 9 Apr 2021 13:43:06 +0200
Message-ID: <20210409114313.4073-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [7.182.8.141]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set provides some small enhancements for IMA and EVM.

Patch 1 avoids measurement and audit when access to the file will be denied
by IMA itself.

Patch 2 introduces a new policy keyword meta_immutable to protect the label
transition during binary execution.

Patch 3-5 add new hard-coded policies aiming at producing measurement or
enforcing access to files that likely are provided by software vendors.

Patch 6 increases the crypto resistance of EVM by allowing the choice of
the hash algorithm for the HMAC.

Patch 7 adds two new values for the evm= option in the kernel command line
to facilitate the setup of EVM.

Roberto Sassu (7):
  ima: Avoid measurement and audit if access to the file will be denied
  ima: Add meta_immutable appraisal type
  ima: Introduce exec_tcb and tmpfs policies
  ima: Introduce appraise_exec_tcb and appraise_tmpfs policies
  ima: Introduce appraise_exec_immutable policy
  evm: Allow choice of hash algorithm for HMAC
  evm: Extend evm= with allow_metadata_writes and complete values

 Documentation/ABI/testing/ima_policy          |  2 +-
 .../admin-guide/kernel-parameters.txt         | 36 +++++++-
 security/integrity/evm/Kconfig                | 34 +++++++
 security/integrity/evm/evm.h                  |  2 +
 security/integrity/evm/evm_crypto.c           | 55 ++++++++++--
 security/integrity/evm/evm_main.c             | 29 ++++--
 security/integrity/ima/ima_appraise.c         |  9 ++
 security/integrity/ima/ima_main.c             | 20 +++--
 security/integrity/ima/ima_policy.c           | 90 ++++++++++++++-----
 security/integrity/integrity.h                |  4 +-
 10 files changed, 232 insertions(+), 49 deletions(-)

-- 
2.26.2

