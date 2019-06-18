Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9334A2E5
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFRN5L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:57:11 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52786 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFRN5L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:57:11 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2776872CC58;
        Tue, 18 Jun 2019 16:57:09 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 093904A4A14;
        Tue, 18 Jun 2019 16:57:09 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v5 00/11] ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY API
Date:   Tue, 18 Jun 2019 16:56:12 +0300
Message-Id: <20190618135623.6861-1-vt@altlinux.org>
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
Kernel.

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
  ima-evm-utils: Change read_pub_key to use EVP_PKEY API
  ima-evm-utils: Change read_priv_key to use EVP_PKEY API
  ima-evm-utils: Start converting calc keyid v2 to EVP_PKEY API
  ima-evm-utils: Convert cmd_import to use EVP_PKEY API
  ima-evm-utils: Start converting find_keyid to use EVP_PKEY API
  ima-evm-utils: Convert verify_hash_v2 to EVP_PKEY API
  ima-evm-utils: Finish conversion of find_keyid to EVP_PKEY API
  ima-evm-utils: Convert sign_hash_v2 to use EVP_PKEY API
  ima-evm-utils: Finish converting calc keyid v2 to EVP_PKEY API
  ima-evm-utils: Remove RSA_ASN1_templates

 src/evmctl.c    |  29 ++++---
 src/imaevm.h    |   4 +-
 src/libimaevm.c | 261 +++++++++++++++++++++++++-------------------------------
 3 files changed, 136 insertions(+), 158 deletions(-)

-- 
2.11.0

