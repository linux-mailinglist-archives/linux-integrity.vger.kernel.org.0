Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F85A373510
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhEEGuZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 02:50:25 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59522 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhEEGuW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 02:50:22 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1403472C8B5;
        Wed,  5 May 2021 09:49:25 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id E503F4A46E8;
        Wed,  5 May 2021 09:49:24 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 0/3] ima-evm-utils: Add --keyid option
Date:   Wed,  5 May 2021 09:48:40 +0300
Message-Id: <20210505064843.111900-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow user to set signature's keyid using `--keyid' option. Keyid should
correspond to SKID in certificate. When keyid is calculated using SHA-1
in libimaevm it may mismatch keyid extracted by the kernel from SKID of
certificate (the way public key is presented to the kernel), thus making
signatures not verifiable. This may happen when certificate is using non
SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
As a last resort user may specify arbitrary keyid using the new option.
Certificate @filename could be used instead of the hex number. And,
third option is to read keyid from the cert appended to the key file.

These commits create backward incompatible ABI change for libimaevm,
 thus soname should be incremented on release.

Changes from v3:
- ima_read_keyid() is improved to better support both use cases.

Changes from v2:
- Add ima_read_keyid() function to libemaevm and use it in both evmctl
  (for --keyid) and sign_hash_v2() (for concatenated PEMs). Suggested
  by Stefan Berger.
- Autodetect PEM by openssl reading it instead of magic string.
  Suggested by Stefan Berger.
- Trivial change: s/unsigned long int/unsigned long/ for keyid type.

Changes from v1:
- Extract keyid from cert associated to key file.
- Use sizeof instead of constant.

Changes since rfc version:
- `imaevm_params.keyid' now stored as native integer (instead of network
  order). Suggested by Stefan Berger.
- Added support for `--keyid=@filename'.

Vitaly Chikunov (3):
  ima-evm-utils: Allow manual setting keyid for signing
  ima-evm-utils: Allow manual setting keyid from a cert file
  ima-evm-utils: Read keyid from the cert appended to the key file

 README                 |  5 +++
 src/evmctl.c           | 27 ++++++++++++++
 src/imaevm.h           |  2 ++
 src/libimaevm.c        | 95 ++++++++++++++++++++++++++++++++++++++++++++++++--
 tests/sign_verify.test |  2 ++
 5 files changed, 128 insertions(+), 3 deletions(-)

-- 
2.11.0

