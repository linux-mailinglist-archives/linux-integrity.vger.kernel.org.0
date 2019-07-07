Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B577961891
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 01:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfGGXsz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Jul 2019 19:48:55 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42936 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfGGXsz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Jul 2019 19:48:55 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4673772CC6C;
        Mon,  8 Jul 2019 02:48:54 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id 080454A4AE8;
        Mon,  8 Jul 2019 02:48:54 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 0/5] ima-evm-utils: Assorted fixes and improvements
Date:   Mon,  8 Jul 2019 02:48:32 +0300
Message-Id: <20190707234837.4866-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is small fixes and improvements to ima-evm-utils.
Tested on x86_64.

Vitaly Chikunov (5):
  ima-evm-utils: Fix EVP_MD_CTX leak in ima_calc_hash
  ima-evm-utils: Fix memory leak in init_public_keys
  ima-evm-utils: Preload public keys for ima_verify
  ima-evm-utils: Allow multiple files in ima_verify
  ima-evm-utils: Fix clang warning about possible unaligned pointer for
    hdr->keyid

 src/evmctl.c    | 11 ++++++++---
 src/libimaevm.c | 38 ++++++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 15 deletions(-)

-- 
2.11.0

