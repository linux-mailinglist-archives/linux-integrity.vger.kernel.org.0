Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3814C7E6
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 09:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfFTHNN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Jun 2019 03:13:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39466 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTHNN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Jun 2019 03:13:13 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7ABC672CC64;
        Thu, 20 Jun 2019 10:13:11 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 390874A4A29;
        Thu, 20 Jun 2019 10:13:11 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v6 00/11] ima-evm-utils: Convert v2 signatures from RSA to EVP_PKEY API
Date:   Thu, 20 Jun 2019 10:12:53 +0300
Message-Id: <20190620071304.24495-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Convert sign v2 from RSA API (with manual formatting PKCS1) to more generic
EVP_PKEY API, allowing to generate more types of OpenSSL supported signatures.
This is done to enable EC-RDSA signatures, which are already supported in the
Kernel. With some small fixes.

All patches tested on x86_64 to not break anything.

Changes since v5:
- Squash calc keyid v2 with cmd_import patch.
- Add log_err messages to verify_hash_v2 and sign_hash_v2.
- Fix sign and hash generation error processing to show errors instead
  of assert failures.

Changes since v4:
- Split conversion into more patches, as suggested by Mimi Zohar.
- Small fixes suggested by Mimi Zohar.

Changes since v3:
- As suggested by Mimi Zohar this is v3 splitted into several patches to
  simplify review. No code changes.

Changes since v2:
- Just rebase over newer commits.

Changes since v1:
- More key neutral code in calc_keyid_v1().
- Fix uninitialized sigsize for EVP_PKEY_sign().
- Fix memory leaks for openssl types.

Vitaly Chikunov (11):
  ima-evm-utils: Make sure sig buffer is always MAX_SIGNATURE_SIZE
  ima-evm-utils: Convert read_pub_key to EVP_PKEY API
  ima-evm-utils: Convert read_priv_key to EVP_PKEY API
  ima-evm-utils: Convert cmd_import and calc keyid v2 to EVP_PKEY API
  ima-evm-utils: Start converting find_keyid to EVP_PKEY API
  ima-evm-utils: Convert verify_hash_v2 to EVP_PKEY API
  ima-evm-utils: Replace find_keyid with find_keyid_pkey
  ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API
  ima-evm-utils: Replace calc_keyid_v2 with calc_pkeyid_v2
  ima-evm-utils: Remove RSA_ASN1_templates
  ima-evm-utils: Pass status codes from sign and hash functions to the
    callers

 src/evmctl.c    |  43 +++++----
 src/imaevm.h    |   4 +-
 src/libimaevm.c | 277 +++++++++++++++++++++++++++-----------------------------
 3 files changed, 158 insertions(+), 166 deletions(-)

-- 
2.11.0

