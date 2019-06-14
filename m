Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78E5A45162
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jun 2019 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfFNBy1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 21:54:27 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41112 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfFNBy1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 21:54:27 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 736B772CA65;
        Fri, 14 Jun 2019 04:54:25 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 554924A4AE7;
        Fri, 14 Jun 2019 04:54:25 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 0/5] ima-avm-utils: Convert sign v2 from RSA to EVP_PKEY API
Date:   Fri, 14 Jun 2019 04:54:05 +0300
Message-Id: <20190614015410.26039-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changes since v3:
- As suggested by Mimi Zohar this is v3 splitted into several patches to
  simplify review. No code changes.

Changes since v2:
- Just rebase over newer commits.

Changes since v1:
- More key neutral code in calc_keyid_v1().
- Fix uninitialized sigsize for EVP_PKEY_sign().
- Fix memory leaks for openssl types.

Vitaly Chikunov (5):
  ima-avm-utils: Make sure sig buffer is always MAX_SIGNATURE_SIZE
  ima-avm-utils: Change read_pub_key to use EVP_PKEY API
  ima-avm-utils: Change read_priv_key to use EVP_PKEY API
  ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY API
  ima-avm-utils: Remove RSA_ASN1_templates

 src/evmctl.c    |  29 +++---
 src/imaevm.h    |   4 +-
 src/libimaevm.c | 269 ++++++++++++++++++++++++++------------------------------
 3 files changed, 146 insertions(+), 156 deletions(-)

-- 
2.11.0

