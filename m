Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E422A6F876A
	for <lists+linux-integrity@lfdr.de>; Fri,  5 May 2023 19:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjEERTa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 May 2023 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjEERTa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 May 2023 13:19:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11E513288;
        Fri,  5 May 2023 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XKocbXJ3Lq6iRPF1r1APTgPMV6TLzhj+9VGiviht+rY=; b=qwJYwoC/sW9KZQnL/aQ9hvcuyl
        tO5idmF5gUIEUZWJB07xlcCOlmj4gEKnOEb9Z5SIQyXPm605JJsVT2ugAt+KCs0y0bSpvQVbcJKg0
        lytsfv9BlXlwf6ejXo7v8MoEwHmcN3qa5wZxGv/Bi3AJvgTKTC+pDjrjM7XTx9+Falguaq5goHkXC
        F9mnhDGEnmybuigEIEbBsyd/xiSkXoPFJX8XxqiJRUvfBh4vRMChQGgys3PE3AQqSHwdsgqt2NbMC
        Wnt8Fv1fDJ8mV7sOm4MXbjUVDEEykGRMqgjJ1hcpDQOOh5vkW1NDtz3cyOPXrNZ/OX8T8nEnNc1sm
        lYIgI19Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puz5S-003Ivw-1I;
        Fri, 05 May 2023 17:19:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50327300635;
        Fri,  5 May 2023 19:19:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BF31201F214F; Fri,  5 May 2023 19:19:16 +0200 (CEST)
Date:   Fri, 5 May 2023 19:19:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, hdegoede@redhat.com,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: tpm_sis IRQ storm on ThinkStation P360 Tiny
Message-ID: <20230505171915.GA1821641@hirez.programming.kicks-ass.net>
References: <20230505130731.GO83892@hirez.programming.kicks-ass.net>
 <toe7jsgedknsqj3dgw2fasjlqcpgpiqgloifxow4vnt3tntabw@l6emb5zpbff5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <toe7jsgedknsqj3dgw2fasjlqcpgpiqgloifxow4vnt3tntabw@l6emb5zpbff5>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 05, 2023 at 08:05:53AM -0700, Jerry Snitselaar wrote:

> It will poll like it has for years with tpm_tis.interrupts=0 so that
> should be working as it was prior to 6.3 when interrupts were re-enabled
> for tpm_tis. Are you seeing this with 6.2 as well? IIRC with that Thinkpad
> case is when it was first realized that interrupts had accidentally been
> disabled for tpm_tis at one point by a change.

v6.2 gets me:

[    8.888394] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1D, rev-id 54)
[    8.891123] tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead

> I guess myself or someone else needs to revisit catching this in
> general when the irq storm happens, and disabling interrupts for
> tpm_tis. I think last time I was incorporating some feedback from
> tglx, let my adhd get me distracted with some other issue and never
> returned to it.
> 
> The diff below should (compile tested) work for the P360, but
> tpm_tis.interrupts=0 is a good work-around.

Yep, I suppose it would. I'll keep the kernel parameter for now, that's
easier than making sure I consistently apply that patch.

Thanks!
