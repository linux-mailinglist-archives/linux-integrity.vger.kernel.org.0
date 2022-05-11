Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196AF523196
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiEKL24 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiEKL2s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 07:28:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6C823E280;
        Wed, 11 May 2022 04:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96B99B82075;
        Wed, 11 May 2022 11:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FADC340F2;
        Wed, 11 May 2022 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652268511;
        bh=N5xgX5dJUJXdldanftjWLLJPgFd3eQMkcEKdIzdEgh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmM9kI5Lc350ttS7YDauDlzfANOfilw5gnBVzp7rR8aBAFFpaSNnjXCOXz7bfuO/S
         pHFgS7p0O19paJxLFKb5lZKZGSvVd5TXYmgoZX3tVKVxyU0IXJ6OEraHFJykGmUpHb
         9PAqeONJVRxGaP+rBFTESq1XPBtcq25z5h/8cSDS8d6tr9gu/cFXDXJrgpCIe7VrP9
         WdEguRYDE5Bo6C/dC7gmnbQaTGkxwhJm0y+frZEjQeyf9XnUAitZZV2/ZeQWT/cPHA
         lGoIfC4yboBXZaygS0czOnIHNiotve7/0gT1DXWkdDEmR0M0b+SZd1AKfbVzdcbqaM
         UiClxVqQGkyfw==
Date:   Wed, 11 May 2022 14:27:01 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 2/6] tpm, tpm_tis: Claim and release locality only once
Message-ID: <YnudhZZGXf87U3bd@kernel.org>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-3-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509080559.4381-3-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 10:05:55AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> It is not necessary to claim and release the default locality for each TPM
> command. Instead claim the locality once at driver startup and release it
> at driver shutdown.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

We are doing what we're being because of Intel TXT:

https://lore.kernel.org/tpmdd-devel/20170315055738.11088-1-jarkko.sakkinen@iki.fi/

Unfortunately cannot accept this change.

BR, Jarkko
