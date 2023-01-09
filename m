Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3062661F7A
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Jan 2023 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAIHw5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Jan 2023 02:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjAIHwz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Jan 2023 02:52:55 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4634113D46
        for <linux-integrity@vger.kernel.org>; Sun,  8 Jan 2023 23:52:53 -0800 (PST)
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Mon, 9 Jan 2023
 10:52:48 +0300
Received: from msexch01.omp.ru ([fe80::4020:d881:621a:6b6b]) by
 msexch01.omp.ru ([fe80::4020:d881:621a:6b6b%5]) with mapi id 15.02.0986.014;
 Mon, 9 Jan 2023 10:52:48 +0300
From:   Alberto Mardegan <a.mardegan@omp.ru>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: [PATCH] libimaevm: do not crash if the certificate cannot be read
Thread-Topic: [PATCH] libimaevm: do not crash if the certificate cannot be
 read
Thread-Index: AQHZI/9dfJNfwkhsDk2eAu6wq9tXpA==
Date:   Mon, 9 Jan 2023 07:52:48 +0000
Message-ID: <20230109075230.20484-1-a.mardegan@omp.ru>
References: <f4359a91a31b9b46f5cb7eb0e96c45c0c46ac282.camel@linux.ibm.com>
In-Reply-To: <f4359a91a31b9b46f5cb7eb0e96c45c0c46ac282.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.188.4.41]
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 1/9/2023 3:20:00 AM
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This code path can be triggered if someone inadvertedly swaps the key
with the certificate in the evmctl command line. Our `x` variable would
be NULL, and we need to abort further processing of the certificate.

Signed-off-by: Alberto Mardegan <a.mardegan@omp.ru>
---
 src/libimaevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index c09ed98..5b22462 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -923,6 +923,7 @@ static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile, int tr
 		ERR_print_errors_fp(stderr);
 		log_err("read keyid: %s: Error reading x509 certificate\n",
 			certfile);
+		return -1;
 	}
 
 	if (!(skid = x509_get_skid(x, &skid_len))) {
-- 
2.34.1
