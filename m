Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17BA19500D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2020 05:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgC0EZ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Mar 2020 00:25:57 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45658 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgC0EZ5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Mar 2020 00:25:57 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0B9E672CCF8;
        Fri, 27 Mar 2020 07:25:56 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [83.220.44.62])
        by imap.altlinux.org (Postfix) with ESMTPSA id DAD344A4A14;
        Fri, 27 Mar 2020 07:25:55 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v8 0/2] ima-evm-utils: Add some tests for evmctl
Date:   Fri, 27 Mar 2020 07:25:13 +0300
Message-Id: <20200327042515.22315-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series adds simple evmctl tests for hash, sign, and verify operations.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
Changelog since v7:
- Absence of key file cause test skip instead of fail.
- Mono patch is split into two by Mimi Zohar request.

Changelog since v6:
- ima_hash.test: Compare generated hashes with known values.
  I found that on power8 qemu with default -cpu calculates hashes wrongly.
  For exmaple: `openssl dgst -sha224 -hex /dev/null' results in
  83b2514951547ee00c7062fa3eb42079ff19f280ec81eedbdb0e3997 instead of
  d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f.
- Make `_keyid' use temporary files to not rely on presence of `/des/stdout'.
- evm sign: add `--generation 0' option.
  I found that on overlay fs (with ext4 over 9p) FS_IOC_GETVERSION does
  not work.
- gen-keys.sh: allows `force' argument to regenerate all test keys.

Changelog since v5:
- Fix tests if gost-engine is not present. Thx to Mimi Zohar for testing on
  Xenial.

Changelog since v4:
- Fix bugs found by Mimi Zohar:
 - Fix typos in variable names
 - Fix `-out -' in asn1parse for openssl 1.0.x

Changelog since v3:
- Apply changes based on some suggestions from Petr Vorel, such as
- Add .gitignore
- Do not color output if stdout is not tty.
- Fix blkid error with --uuid option.
- Remove or change some comments
- Replace ENGINE with EVMCTL_ENGINE and OPENSSL_ENGINE.
- All tests pass over next branch.

Changelog since v2:
- ima_sign.test and ima_verify.test merged into sign_verify.test
  which is also able to test evm signatures.
- Apply Mimi Zohar suggestions regarding commenting, variable renaming,
  code rearranging, etc. with intent to simplify the code and review.

Changelog since v1:
- Apply suggestions by Petr Vorel:
 - Rename function names and variables to be more understandable.
 - Rename tests/functions to tests/functions.sh.
 - Define exit codes (77, 99, ...) as variables.
- Added more comments and remove single letter variables (for Mimi Zohar).
- Move getfattr check into function.
- Move evmctl run and check into single function.
- Add sign/verify tests for v1 signatures.
- Minor improvements.
- Since I still edit all 5 files I did not split the patch into multiple
  commits to separate the files, otherwise editing will become too
  complicated, as I ought to continuously rebase and edit different
  commits. This was really non-productive suggestion.

Vitaly Chikunov (2):
  ima-evm-utils: Add some tests for evmctl
  ima-evm-utils: Add sign/verify tests for evmctl

 .gitignore             |   2 +-
 Makefile.am            |   2 +-
 configure.ac           |   1 +
 tests/.gitignore       |  16 +++
 tests/Makefile.am      |  12 ++
 tests/functions.sh     | 272 ++++++++++++++++++++++++++++++++++++
 tests/gen-keys.sh      |  97 +++++++++++++
 tests/ima_hash.test    |  80 +++++++++++
 tests/sign_verify.test | 364 +++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 844 insertions(+), 2 deletions(-)
 create mode 100644 tests/.gitignore
 create mode 100644 tests/Makefile.am
 create mode 100755 tests/functions.sh
 create mode 100755 tests/gen-keys.sh
 create mode 100755 tests/ima_hash.test
 create mode 100755 tests/sign_verify.test

-- 
2.11.0

