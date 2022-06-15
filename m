Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34E54D11A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiFOSrD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFOSrC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:47:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0139822;
        Wed, 15 Jun 2022 11:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4A63B82144;
        Wed, 15 Jun 2022 18:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3629C34115;
        Wed, 15 Jun 2022 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655318818;
        bh=2MSuk30EUqMlhIoKw9YYQQ/0jZZXMiZKNpH1LHxTynA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oURepQHHAa54ruh7DNeCY2D0myZ6kX6oN+sV4yJzJjqFwHIslSOY2vw2WrUyHG+nZ
         ezHfGzJm1hmDFDl/6htLU5FtONmRGXIql7Z5cGVbMuy/l4OqQQNwjvzS+rQtvVqftF
         FdrXeYilxIqWk3PHG9oQPrSvdmLTJmVm00yglF8RBbEJCztNs/Z7aKPW/jjsq1VSv1
         AUEuuLsSjpv2lKiQm9ZYuinh/5JAfPQXsK6Gxf2Ck/nyXtrOPexh58qxgYcsfLKFrn
         zhx4xQrY0+q/aghcW0jrxK67X31Hk/OG2wZ8Cg/CMGOGdhrjPLFRl0DO/1ni5gdw7u
         qoq6W+PMKZQ7g==
Date:   Wed, 15 Jun 2022 21:44:49 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Morten Linderud <morten@linderud.pw>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 address
Message-ID: <Yqooof3If/y9lBPC@iki.fi>
References: <20220608123109.678343-1-morten@linderud.pw>
 <YqF7NktlAJg26Bvd@iki.fi>
 <20220609081159.rjj7a3x63y7ag4ty@terminus>
 <YqHdwD/hJfVdSE94@iki.fi>
 <20220610132912.toovhhqtqr3vdepq@terminus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610132912.toovhhqtqr3vdepq@terminus>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 03:29:12PM +0200, Morten Linderud wrote:
> On Thu, Jun 09, 2022 at 02:47:12PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Jun 09, 2022 at 10:11:59AM +0200, Morten Linderud wrote:
> > > On Thu, Jun 09, 2022 at 07:46:46AM +0300, Jarkko Sakkinen wrote:
> > >
> > > > What you are using this for? Without any actual bug report, this 
> > > > is an obvious NAK.
> > > 
> > > I have hardware with faulty ACPI values which prevents me from getting a
> > > eventlog. I can surely make a bugreport if it helps the case, but that seems
> > > like an arbiterary hurdle when I have already spent the time tracking down the
> > > issue and proposed a fix.
> > 
> > What is the hardware?
> 
> I included it in the commit message with the listed ACPI table values.
> 
> 
> The following hardware was used to test this issue:
>     Framework Laptop (Pre-production)
>     BIOS: INSYDE Corp, Revision: 3.2
>     TPM Device: NTC, Firmware Revision: 7.2
> 
> Dump of the faulty ACPI TPM2 table:
>     [000h 0000   4]                    Signature : "TPM2"    [Trusted Platform Module hardware interface Table]
>     [004h 0004   4]                 Table Length : 0000004C
>     [008h 0008   1]                     Revision : 04
>     [009h 0009   1]                     Checksum : 2B
>     [00Ah 0010   6]                       Oem ID : "INSYDE"
>     [010h 0016   8]                 Oem Table ID : "TGL-ULT"
>     [018h 0024   4]                 Oem Revision : 00000002
>     [01Ch 0028   4]              Asl Compiler ID : "ACPI"
>     [020h 0032   4]        Asl Compiler Revision : 00040000
> 
>     [024h 0036   2]               Platform Class : 0000
>     [026h 0038   2]                     Reserved : 0000
>     [028h 0040   8]              Control Address : 0000000000000000
>     [030h 0048   4]                 Start Method : 06 [Memory Mapped I/O]
> 
>     [034h 0052  12]            Method Parameters : 00 00 00 00 00 00 00 00 00 00 00 00
>     [040h 0064   4]           Minimum Log Length : 00010000
>     [044h 0068   8]                  Log Address : 000000004053D000
> 
> -- 
> Morten Linderud
> PGP: 9C02FF419FECBE16

If this is not something you can buy off-the-shelf, it
unfortunately does not cut.

BR, Jarkko
