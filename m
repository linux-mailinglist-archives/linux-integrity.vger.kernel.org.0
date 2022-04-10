Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D074FAF2D
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Apr 2022 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbiDJRNi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Apr 2022 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiDJRNi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Apr 2022 13:13:38 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E3F22B3A;
        Sun, 10 Apr 2022 10:11:25 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 34ADC30057E6C;
        Sun, 10 Apr 2022 19:11:23 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 298284A855; Sun, 10 Apr 2022 19:11:23 +0200 (CEST)
Date:   Sun, 10 Apr 2022 19:11:23 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, =robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/5] tpm: add functions to set and unset the tpm chips
 reset state
Message-ID: <20220410171123.GA24453@wunner.de>
References: <20220407111849.5676-1-LinoSanfilippo@gmx.de>
 <20220407111849.5676-2-LinoSanfilippo@gmx.de>
 <20220407142526.GW64706@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407142526.GW64706@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Apr 07, 2022 at 11:25:26AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 07, 2022 at 01:18:45PM +0200, Lino Sanfilippo wrote:
> > Currently it is not possible to set the tpm chips reset state from within
> > the driver. This is problematic if the chip is still in reset after the
> > system comes up. This may e.g. happen if the reset line is pulled into
> > reset state by a pin configuration in the device tree.
> 
> This kind of system is badly misdesigned.
> 
> TPM PCRs fundementally cannot work if the TPM reset line is under
> software control.

Not every system which incorporates a TPM wants to use or is even capable
of measuring software state of any kind or perform secure boot.

Those systems may merely want to use the TPM to store key material.

Thanks,

Lukas
