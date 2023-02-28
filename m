Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38636A51A3
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 04:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjB1DKs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Feb 2023 22:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjB1DKs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Feb 2023 22:10:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39062006F
        for <linux-integrity@vger.kernel.org>; Mon, 27 Feb 2023 19:10:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE403B80CA7
        for <linux-integrity@vger.kernel.org>; Tue, 28 Feb 2023 03:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E99C4339B;
        Tue, 28 Feb 2023 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677553822;
        bh=j2xdflKv8i4Zuj0XM0kKC4gbLoS7YwCsyp4qjAzR95o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i99vprYrvUQnMIH+t26KyWjrpfvL/xX9eXYqtyO3MavxZCwNh6M71p4FB7qEdQzyg
         PHQrUBbLKcv9mEdBIDbp4UXeTbpRykM53equnX/GhcCTw19amy1YXYkTVvj7T3Pazr
         O4dRGl5pDzqK7sGxrnBwWSdgx6vT+8xhOVC5CmaL2SoBKTXCdduUVZiRN6hcJOizTV
         PsAUEtBEJm3OLVAJ9Z+BDC6UQlJrVN82UEfiilAOyH0aDruo65cPp5bfkA5GXyAGvk
         DlV4DXP01ByQWOsSVFr/G/9LJrhv/iTO/00a/wSWV8BWn0ok+0ImC3UzpRErEVm5FK
         e3TE5C0mxHyFg==
Date:   Tue, 28 Feb 2023 05:10:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        yangyingliang@huawei.com, eajames@linux.ibm.com, jgg@ziepe.ca,
        peterhuewe@gmx.de
Subject: Re: [PATCH 1/2] powerpc/tpm: Create linux,sml-base/size as big endian
Message-ID: <Y/1wm3kmsto5tzeB@kernel.org>
References: <20230224032508.3331281-1-mpe@ellerman.id.au>
 <c2afd163-5f23-acab-fd39-3a5593ed6257@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2afd163-5f23-acab-fd39-3a5593ed6257@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 27, 2023 at 06:08:31PM -0500, Stefan Berger wrote:
> 
> 
> On 2/23/23 22:25, Michael Ellerman wrote:
> > There's code in prom_instantiate_sml() to do a "SML handover" (Stored
> > Measurement Log) from OF to Linux, before Linux shuts down Open
> > Firmware.
> > 
> > This involves creating a buffer to hold the SML, and creating two device
> > tree properties to record its base address and size. The kernel then
> > later reads those properties from the device tree to find the SML.
> > 
> > When the code was initially added in commit 4a727429abec ("PPC64: Add
> > support for instantiating SML from Open Firmware") the powerpc kernel
> > was always built big endian, so the properties were created big endian
> > by default.
> > 
> > However since then little endian support was added to powerpc, and now
> > the code lacks conversions to big endian when creating the properties.
> > 
> > This means on little endian kernels the device tree properties are
> > little endian, which is contrary to the device tree spec, and in
> > contrast to all other device tree properties.
> > 
> > To cope with that a workaround was added in tpm_read_log_of() to skip
> > the endian conversion if the properties were created via the SML
> > handover.
> > 
> > A better solution is to encode the properties as big endian as they
> > should be, and remove the workaround.
> > 
> > Typically changing the encoding of a property like this would present
> > problems for kexec. However the SML is not propagated across kexec, so
> > changing the encoding of the properties is a non-issue.
> > 
> > Fixes: e46e22f12b19 ("tpm: enhance read_log_of() to support Physical TPM event log")
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

2/2 does not have a fixes tag.

BR, Jarkko
