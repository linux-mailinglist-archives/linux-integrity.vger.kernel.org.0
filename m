Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4FB5F4BC8
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Oct 2022 00:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJDWYM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 18:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiJDWXk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 18:23:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F00A6CF40;
        Tue,  4 Oct 2022 15:23:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33A95614B2;
        Tue,  4 Oct 2022 22:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390A4C433D6;
        Tue,  4 Oct 2022 22:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664922218;
        bh=nVxrOy5eft7h4npScOruNJV9YHDPIVI9Ds4fCNa0VXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZE6e9MXtsmtfikuHhx8bgagzREYYSO4bOUsOx/SQuD6qaY5QApymyQd6HSxt4ePJ
         YTKwW7N5tLR4/eb3ZF1/9PzcDnbB/Ul7EY0NwcQBADRbd8Abh8um5UiMq7vqoBOTVm
         wSPCNjzte8UTV8IWNLEqcaWP9Vfs8PkcDuyAIUmRX2CIe1K812OQqq4CILs83MQfyx
         UwTSuexCBdhNeynyZiOM7NCvlh8TCtDBvHaUquCXGdn5x8wy0wH7FOGDV0UTLCg52A
         BXNw11cvYT58/HwHrxlS1hGzMDe5+SNGMoMedzCzPq/rU3e8GpH0xjVdVoSlmojsIs
         vhkGwu7K8bwWA==
Date:   Wed, 5 Oct 2022 01:23:35 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Erkki Eilonen <erkki@bearmetal.eu>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, morten@linderud.pw, peterhuewe@gmx.de
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 address
Message-ID: <YzyyZ6AFAgTRG5G5@kernel.org>
References: <Yqooof3If/y9lBPC@iki.fi>
 <20221001215223.783896-1-erkki@bearmetal.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001215223.783896-1-erkki@bearmetal.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Oct 02, 2022 at 12:52:24AM +0300, Erkki Eilonen wrote:
> > If this is not something you can buy off-the-shelf, it
> > unfortunately does not cut.
> 
> For a N=2, we're having the same issue with a set of OTC machines.
> 
> Device: QuantaGrid D53X-1U
> BIOS:
>   Vendor: INSYDE Corp.
>   Version: 3A16.Q402
>   Release_Date: 11/10/2021
> 
> ACPI TPM2 table:
>   [000h 0000   4]                    Signature : "TPM2"    [Trusted Platform Module hardware interface table]
>   [004h 0004   4]                 Table Length : 0000004C
>   [008h 0008   1]                     Revision : 04
>   [009h 0009   1]                     Checksum : 8C
>   [00Ah 0010   6]                       Oem ID : "INSYDE"
>   [010h 0016   8]                 Oem Table ID : "WHITLEY "
>   [018h 0024   4]                 Oem Revision : 00000002
>   [01Ch 0028   4]              Asl Compiler ID : "INTL"
>   [020h 0032   4]        Asl Compiler Revision : 00040000
>   
>   [024h 0036   2]               Platform Class : 0001
>   [026h 0038   2]                     Reserved : 0000
>   [028h 0040   8]              Control Address : 0000000000000000
>   [030h 0048   4]                 Start Method : 06 [Memory Mapped I/O]
>   
>   [034h 0052  12]            Method Parameters : 00 00 00 00 00 00 00 00 00 00 00 00
>   [040h 0064   4]           Minimum Log Length : 00010000
>   [044h 0068   8]                  Log Address : 0000000043274000
> 
> Fallback to the UEFI eventlog is what we did for a short term fix too. Will try to contact the vendor for a fixed ACPI table long term.
> 
> Morten: Did you get in contact with the vendor about this? Looks like a class error across different devices.
> 
> Cheers,
> Erkki

Does the bug fix work for you? If you can give tested-by for it, then that
ofc changes everything.

BR, Jarkko
