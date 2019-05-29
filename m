Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D452DE46
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2019 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfE2Neg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 May 2019 09:34:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32971 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbfE2Neg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 May 2019 09:34:36 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C4463E5CB010485960B9;
        Wed, 29 May 2019 14:34:34 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.32) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 29 May 2019 14:34:24 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/3] ima/evm fixes for v5.2
Date:   Wed, 29 May 2019 15:30:32 +0200
Message-ID: <20190529133035.28724-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changelog

v1:
- remove patch 2/4 (evm: reset status in evm_inode_post_setattr()); file
  attributes cannot be set if the signature is portable and immutable
- patch 3/4: add __ro_after_init to ima_appraise_req_evm variable
  declaration
- patch 3/4: remove ima_appraise_req_evm kernel option and introduce
  'enforce-evm' and 'log-evm' as possible values for ima_appraise=
- remove patch 4/4 (ima: only audit failed appraisal verifications)
- add new patch (ima: show rules with IMA_INMASK correctly)


Roberto Sassu (3):
  evm: check hash algorithm passed to init_desc()
  ima: don't ignore INTEGRITY_UNKNOWN EVM status
  ima: show rules with IMA_INMASK correctly

 .../admin-guide/kernel-parameters.txt         |  3 ++-
 security/integrity/evm/evm_crypto.c           |  3 +++
 security/integrity/ima/ima_appraise.c         |  8 +++++++
 security/integrity/ima/ima_policy.c           | 21 +++++++++++--------
 4 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.17.1

