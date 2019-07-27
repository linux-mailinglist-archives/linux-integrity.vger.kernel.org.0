Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569CA77634
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Jul 2019 05:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfG0DTG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 23:19:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44670 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfG0DTF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 23:19:05 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2279272CC6C;
        Sat, 27 Jul 2019 06:19:04 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [185.6.174.98])
        by imap.altlinux.org (Postfix) with ESMTPSA id CF37B4A4AE8;
        Sat, 27 Jul 2019 06:19:03 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] ima-evm-utils: Never exit with -1 code
Date:   Sat, 27 Jul 2019 06:19:00 +0300
Message-Id: <20190727031900.7140-2-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190727031900.7140-1-vt@altlinux.org>
References: <20190727031900.7140-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change main() return code from -1 to 125 as -1 is not really valid exit
code. 125 is choosen because exit codes for signals start from 126.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index d33a91e..e0a835f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2100,6 +2100,8 @@ int main(int argc, char *argv[])
 				break;
 			log_err("%s\n", ERR_error_string(error, NULL));
 		}
+		if (err < 0)
+			err = 125;
 	}
 
 	if (eng) {
-- 
2.11.0

