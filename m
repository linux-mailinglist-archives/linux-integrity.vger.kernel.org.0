Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5D372520
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 06:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhEDEft (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 00:35:49 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:35442 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhEDEft (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 00:35:49 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A9A8472C8B5;
        Tue,  4 May 2021 07:34:53 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id 81F0D4A46E8;
        Tue,  4 May 2021 07:34:53 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Elvira Khabirova <lineprinter0@gmail.com>
Subject: [PATCH v2 0/3] ima-evm-utils: Add --keyid option
Date:   Tue,  4 May 2021 07:33:54 +0300
Message-Id: <20210504043357.4093409-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow user to set signature's keyid using `--keyid' option. Keyid should
correspond to SKID in certificate, when keyid is calculated using SHA-1
in libimaevm it may mismatch keyid extracted by the kernel from SKID of
certificate (the way public key is presented to the kernel), thus making
signatures not verifiable. This may happen when certificate is using non
SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
As a last resort user may specify arbitrary keyid using the new option.
Third option is to read keyid from the cert appended to the key file.

These commits create backward compatible ABI change for libimaevm,
because of adding additional parameter to imaevm_params - older
libimaevm can work with newer client.

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

 README                 |  4 +++
 src/evmctl.c           | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/imaevm.h           |  1 +
 src/libimaevm.c        | 52 ++++++++++++++++++++++++++++--
 tests/sign_verify.test |  2 ++
 5 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.11.0

