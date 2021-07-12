Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B1E3C4389
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 07:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhGLFrp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 01:47:45 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34282 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhGLFro (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 01:47:44 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 100DC72C8B4;
        Mon, 12 Jul 2021 08:44:56 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id EB0CE4A46ED;
        Mon, 12 Jul 2021 08:44:55 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils v8 0/3] ima-evm-utils: Add --keyid option
Date:   Mon, 12 Jul 2021 08:44:45 +0300
Message-Id: <20210712054448.2471236-1-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Certificate filename could be used instead of the hex number with
`--keyid-from-cert' option. And, third option is to read keyid from the
cert appended to the key file.

These commits create backward incompatible ABI change for libimaevm,
thus soname should be incremented on release.

Changes from v7:
- Multiple functions are merged back into read_keyid_from_cert().
- OpenSSL portable way of reading of SKID.
- Fixed 'unaligned pointer' access bug (introduced in v7).
- Fixed incorrect return value of imaevm_read_keyid() (in v7).
- Remove kerneldoc markers from comments.
- Tested on GA CI.

Changes from v6:
- Applied changes requested by Mimi Zohar (intermediate variable for if,
  annotation update, new option '--keyid-from-cert' instead of '@').
  Added more comments for questioned cases.
- Read_keyid functions are reworked in hopefully more understandable way
  (two new static functions: extract_keyid and read_cert).
- Test for key+cert case added.

Changes from v5:
- ima_read_keyid renamed to imaevm_read_keyid and its return value
  inverted to match other API functions. Suggested by Stefan Berger
- Rebased over next-testing. Noticed by Mimi Zohar.

Changes from v4:
- ima_read_keyid() API changed. As suggested by Stefan Berger.

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
  Allow manual setting keyid for signing
  Allow manual setting keyid from a cert file
  Read keyid from the cert appended to the key file

 README                 |   6 ++
 src/evmctl.c           |  34 +++++++++++
 src/imaevm.h           |   2 +
 src/libimaevm.c        | 124 ++++++++++++++++++++++++++++++++++++++++-
 tests/gen-keys.sh      |  25 +++++++--
 tests/sign_verify.test |   3 +
 6 files changed, 189 insertions(+), 5 deletions(-)

-- 
2.29.3

