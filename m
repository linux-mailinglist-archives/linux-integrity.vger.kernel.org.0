Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F821F903
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 20:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgGNSRP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 14:17:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36906 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgGNSRO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 14:17:14 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id B678A20B4908;
        Tue, 14 Jul 2020 11:17:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B678A20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594750634;
        bh=Ad1/fz3D4iUrimekvzH9B6xVELSEZ6B4e+CTu5517NI=;
        h=From:To:Cc:Subject:Date:From;
        b=i4/dMu7hq4Y2kgrmFnCbTIwVzF7vcAQw2qmUsG3TrwkROk3LhSYxgXtJ5ANvLQxcW
         FbkDF9SxSU4ZEg2VDjFxUluaesHlebHkm4yResWMqbgq4eKIr+Hdrul5JWOppy8eP1
         6o032koryCUWBisMBX4gMbxk1W3R2T5vrKCZPdDo=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 0/2] IMA: Verify measurement of certificates
Date:   Tue, 14 Jul 2020 14:17:01 -0400
Message-Id: <20200714181703.6374-1-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA subsystem is capable of importing and measuring certificates. This
set of patches adds tests for verifying that keys are imported and measured
correctly.


Changelog:

v5
- Fix failure case of key measurement test.

v4
- Clarify documentation about required certificate.
- Fix case where multiple KEY_CHECK rules are present.

v3
- Document requirements for running the ima key tests and provide resources
  for generating keys.

v2
- Un-linebreak a few strings
- Enforce that some commands are available before running
- Move compute_digest function to ima_setup.sh
- Fix file permissions on ima_key.sh
- Move IMA_POLICY variable to ima_setup.sh
- Add keycheck.policy datafile

v1
- The following patchsets should be applied in that order.
- Add tests that verify measurement of keys and importing certificates.


Lachlan Sneff (2):
  IMA: Add a test to verify measurment of keys
  IMA: Add a test to verify importing a certificate into keyring

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |  22 ++++
 .../integrity/ima/datafiles/keycheck.policy   |   1 +
 .../security/integrity/ima/tests/ima_keys.sh  | 111 ++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   |  36 +-----
 .../integrity/ima/tests/ima_policy.sh         |   1 -
 .../security/integrity/ima/tests/ima_setup.sh |  35 ++++++
 7 files changed, 171 insertions(+), 36 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_keys.sh

-- 
2.25.1

