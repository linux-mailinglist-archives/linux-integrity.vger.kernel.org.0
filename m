Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5A563F0F
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Jul 2022 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGBIIb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 2 Jul 2022 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBIIa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 2 Jul 2022 04:08:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940B6D137
        for <linux-integrity@vger.kernel.org>; Sat,  2 Jul 2022 01:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FCB7B818AA
        for <linux-integrity@vger.kernel.org>; Sat,  2 Jul 2022 08:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11CAC341C8;
        Sat,  2 Jul 2022 08:08:23 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH] tpm: eventlog: Fix section mismatch for DEBUG_SECTION_MISMATCH
Date:   Sat,  2 Jul 2022 16:09:34 +0800
Message-Id: <20220702080934.1168975-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If DEBUG_SECTION_MISMATCH enabled, __calc_tpm2_event_size() will not be
inlined, this cause section mismatch like this:

WARNING: modpost: vmlinux.o(.text.unlikely+0xe30c): Section mismatch in reference from the variable L0 to the function .init.text:early_ioremap()
The function L0() references
the function __init early_memremap().
This is often because L0 lacks a __init 
annotation or the annotation of early_ioremap is wrong.

Fix it by using __always_inline instead of inline for the called-once
function __calc_tpm2_event_size().

Reported-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/linux/tpm_eventlog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 739ba9a03ec1..20c0ff54b7a0 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -157,7 +157,7 @@ struct tcg_algorithm_info {
  * Return: size of the event on success, 0 on failure
  */
 
-static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
+static __always_inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 					 struct tcg_pcr_event *event_header,
 					 bool do_mapping)
 {
-- 
2.27.0

