Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5A70E5E7
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 21:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjEWTq7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 15:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEWTq7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 15:46:59 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C3AE5;
        Tue, 23 May 2023 12:46:58 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A58C330000CCC;
        Tue, 23 May 2023 21:46:54 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8D62741432; Tue, 23 May 2023 21:46:54 +0200 (CEST)
Date:   Tue, 23 May 2023 21:46:54 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, jsnitsel@redhat.com, hdegoede@redhat.com,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        peter.ujfalusi@linux.intel.com, peterz@infradead.org,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <20230523194654.GB5820@wunner.de>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <CSTW066CTZ5M.2JR61D32CFSZL@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSTW066CTZ5M.2JR61D32CFSZL@suppilovahvero>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 23, 2023 at 10:00:10PM +0300, Jarkko Sakkinen wrote:
> I feel also a bit resistant because leaf driver framework is really
> a wrong location in the kernel tree for IRQ storm detection.
> 
> It would be better to have it signaled above the TPM driver, and the
> driver would then just act on it.

That would require changing the logic in kernel/irq/spurious.c.

At this point in the cycle, such a change would definitely not be
eligible as a fix for v6.4.

Thanks,

Lukas
