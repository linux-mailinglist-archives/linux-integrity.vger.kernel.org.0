Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBD70EBC7
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 05:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbjEXDQF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239314AbjEXDPe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 23:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3631735;
        Tue, 23 May 2023 20:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C09106382F;
        Wed, 24 May 2023 03:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0213BC433D2;
        Wed, 24 May 2023 03:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684898063;
        bh=KIWo62hjuIIQjA6MUc+tEoVlrU/qrhKfIVtzXSXkHW4=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Ww54UMhzlzXsB6DNy7UABtfpofJS3dGNZxoo9gMXj4mMGmsAPK0jsmAxFk/gP5xgu
         Tw/3rxo0pFWRAek6vLcNSkDhLKj5idly1Q71EUqwonQY4FucM5ApwyZ7FdGzx3Jx6d
         vx69BlFGVKkEeEwl2pbdwy07KDNO4xUu4ttnvOol4dMvd00HIyUhc8qfGeH9KOdofs
         UQ9L0extPBEmMfuOgHqBkdRKkspU0NcCnbArALRZ0TXQCNLZ1ypCC0G8MmLK/6YR/e
         r4mrwlLVOIa4hN9tELhUlmggdR54CrVFIXVX6o0YX6elLdjk0fiYUvGL3mRKJwEGqO
         AsY/5o50J3n4Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 06:14:20 +0300
Message-Id: <CSU6IJAP1LIT.1278627S9KWPC@suppilovahvero>
Subject: Re: [PATCH v3] tpm_tis_spi: Release chip select when flow control
 fails
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <shaopeijie@cestc.cn>, <pmenzel@molgen.mpg.de>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230522070140.33719-1-shaopeijie@cestc.cn>
 <20230523024536.4294-1-shaopeijie@cestc.cn>
In-Reply-To: <20230523024536.4294-1-shaopeijie@cestc.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 23, 2023 at 5:45 AM EEST,  wrote:
> From: Peijie Shao <shaopeijie@cestc.cn>
>
> The failure paths in tpm_tis_spi_transfer() do not deactivate
> chip select. Send an empty message (cs_select =3D=3D 0) to overcome
> this.
>
> The patch is tested by two ways.
> One way needs to touch hardware:
>    1. force pull MISO pin down to GND, it emulates a forever
>       'WAIT' timing.
>    2. probe cs pin by an oscilloscope.
>    3. load tpm_tis_spi.ko.
> After loading, dmesg prints:
>     "probe of spi0.0 failed with error -110"
> and oscilloscope shows cs pin goes high(deactivated) after
> the failure. Before the patch, cs pin keeps low.
>
> Second way is by writing a fake spi controller.
>    1. implement .transfer_one method, fill all rx buf with 0.
>    2. implement .set_cs method, print the state of cs pin.
>    we can see cs goes high after the failure.
>
> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>

Thanks I substitute the patch that I applied with this.

Again:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
