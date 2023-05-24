Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE9C70FB4D
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjEXQEb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 May 2023 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXQER (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 May 2023 12:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF510E9;
        Wed, 24 May 2023 09:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5D0E63EF0;
        Wed, 24 May 2023 16:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0E2C4339B;
        Wed, 24 May 2023 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684944226;
        bh=Ef+8gDMEGEy6+nkJmKJ1sPJxegkve0GGQfyCdTFWf0A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PIZ8P4OdbWN9k9z/bsioFchL87vtM8hE6ho3ChU0MWvLfzA/KHf/5h59mR4H2U4aC
         jDwJ44mkUX79YlZi3zzorhVVnEpdUEb4gBFi+hdDVOzCGPortAXWYYAS9CWdNg3taq
         Itcpp8XZlmp7HePmQbK+gSXIuWiBPO29k9fiSbXfdayk0zq62EryxRvj08NH4AC5n4
         D+FtdsINmC+UInlBdwC0x/MQS/70E1ssi3Ry7XJoExzcofKIrZ+AJ6uSNx95mUoNZ1
         /LlCAp7YDTpECVobZN/CVMbqKUCpl+hts7a3uBg9OlOqTaD3gfqZpRrzLAwQQj4L3u
         SkBgAVzRWbpmQ==
Message-ID: <d0b56100e7a8cdea42972637d2c32fce367a8286.camel@kernel.org>
Subject: Re: [PATCH 1/2] tpm: tis_i2c: Limit read bursts to
 I2C_SMBUS_BLOCK_MAX (32) bytes
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "A. Sverdlin" <alexander.sverdlin@siemens.com>,
        linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Michael Haener <michael.haener@siemens.com>
Date:   Wed, 24 May 2023 19:03:43 +0300
In-Reply-To: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
References: <20230524154040.1204030-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2023-05-24 at 17:40 +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
>=20
> Underlying I2C bus drivers not always support longer transfers and
> imx-lpi2c for instance doesn't. SLB 9673 offers 427-bytes packets.
>=20
> Visible symptoms are:
>=20
> tpm tpm0: Error left over data
> tpm tpm0: tpm_transmit: tpm_recv: error -5
> tpm_tis_i2c: probe of 1-002e failed with error -5
>=20
> Fixes: bbc23a07b072 ("tpm: Add tpm_tis_i2c backend for tpm_tis_core")
> Tested-by: Michael Haener <michael.haener@siemens.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
