Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4791F37239F
	for <lists+linux-integrity@lfdr.de>; Tue,  4 May 2021 01:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhECXf6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 19:35:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57694 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhECXf6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 19:35:58 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AD68872C8B5;
        Tue,  4 May 2021 02:35:02 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.250])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8FAA94A46E8;
        Tue,  4 May 2021 02:35:02 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 0/2] ima-evm-utils: Add --keyid option
Date:   Tue,  4 May 2021 02:34:50 +0300
Message-Id: <20210503233452.4048462-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These commits create backward compatible ABI change for libimaevm,
because of adding additional parameter to imaevm_params - older
libimaevm can work with newer client.

Changes since rfc version:
- `imaevm_params.keyid' now stored as native integer (instead of network
  order). Suggested by Stefan Berger.
  - Added support for `--keyid=@filename'.

Vitaly Chikunov (2):
  ima-evm-utils: Allow manual setting keyid for signing
  ima-evm-utils: Allow manual setting keyid from a cert file

 README                 |  2 ++
 src/evmctl.c           | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/imaevm.h           |  1 +
 src/libimaevm.c        |  8 +++--
 tests/sign_verify.test |  2 ++
 5 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.11.0

