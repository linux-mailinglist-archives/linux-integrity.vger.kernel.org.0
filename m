Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8073215B
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jun 2023 23:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFOVJx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jun 2023 17:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjFOVJv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jun 2023 17:09:51 -0400
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D226AA
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jun 2023 14:09:47 -0700 (PDT)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 248064251A; Thu, 15 Jun 2023 22:09:46 +0100 (BST)
Date:   Thu, 15 Jun 2023 22:09:46 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Subject: Avoiding EBUSY on TPM writes
Message-ID: <20230615210946.GA13094@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We're running into a situation where concurrent TPM accesses can trigger 
EBUSY on write due to there either being a queued command or a response 
not yet having been read. Obviously one approach would be to retry, but 
that involves us either spinning or waiting for an arbitrary amount of 
time between attempts, which doesn't seem ideal. There's a poll 
interface that tells us whether there's a response to read but (a) that 
doesn't help in the enqueued command situation and (b) this would still 
be racy - we could be notified that the response has been read, be 
preempted, and have another process perform a write before we get the 
opportunity to.

What's the right way to fix this? One approach would simply be to 
replace the EBUSY with an interruptible sleep and wake the process when 
the TPM is available, but that feels like it's technically an ABI break.
