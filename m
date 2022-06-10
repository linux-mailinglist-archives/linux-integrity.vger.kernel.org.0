Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8454675F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jun 2022 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbiFJN3V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242455AbiFJN3U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 09:29:20 -0400
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EEB401BCE;
        Fri, 10 Jun 2022 06:29:17 -0700 (PDT)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id 54384C0267;
        Fri, 10 Jun 2022 15:29:14 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1654867754;
        bh=zSEFhvzDPXveY/kOQLgahETmEeSCHLhTHtpWFZ2Af7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aYb99NTSxKFT4ok0wHTsIkpL0o7Jtm0peSXi1Oghrab1AgYwoHHOF3mkrJzRqyGT3
         HwA8LPhrZqOpn3EV4TgXtIq6C41lF+B1hAQyHRHqLrT1L9DUO6D8lh+ePcenFpk9oh
         Rwg1yw2coPTxZuvjpcoboD1kcvmXZpwQdEYaSl11+zdE/5PEFfPLvSLELw7NpjhXx1
         kbnViyB7mcF+er7dDlqe2hjrPhp7TZ5aHN+VDcsoE9iORxMwGzGe+NScNJuZEoJ5/F
         2crll7rH/pQtqny+QCjrtNG4TroTwh1B7FaZJhuZCrj36cakFNlWYhD74Lmu+aYd0w
         yzeHptMX50BgtPqNORl95frhNPvMcGqG2xnuj6mXH1ogodcp+jdagyhOSNt8tZgxbx
         VXkm58Ljl1P/iFZw52idGA4z4GPW86fjP2HGD99AkX6hKttkrgH433gXaBnSGIelJT
         xXwb0MBKOajDjqAUv72/wbs4MYWZjUgTPzVQwynyYUN9ha1uVC3DeiXTrMPuE6viwh
         U90MAGRW2hEf+UgoejNO23PgRoLVbsZVlUK9Tg37DeiALw2iW589lzorcSEzOmsd8T
         qey3gmUh+ofoyIWuh1ZM83vwWA7H+Q2WNTjAdHDkBrmoO8GmTsTiS0S9Sn64NRxyDl
         +bjbWysrG2pMgd8gRzmhe6wY=
Received: from localhost (host-37-191-241-102.lynet.no [37.191.241.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 15BC1C024D;
        Fri, 10 Jun 2022 15:29:14 +0200 (CEST)
Date:   Fri, 10 Jun 2022 15:29:12 +0200
From:   Morten Linderud <morten@linderud.pw>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 address
Message-ID: <20220610132912.toovhhqtqr3vdepq@terminus>
References: <20220608123109.678343-1-morten@linderud.pw>
 <YqF7NktlAJg26Bvd@iki.fi>
 <20220609081159.rjj7a3x63y7ag4ty@terminus>
 <YqHdwD/hJfVdSE94@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqHdwD/hJfVdSE94@iki.fi>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 09, 2022 at 02:47:12PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jun 09, 2022 at 10:11:59AM +0200, Morten Linderud wrote:
> > On Thu, Jun 09, 2022 at 07:46:46AM +0300, Jarkko Sakkinen wrote:
> >
> > > What you are using this for? Without any actual bug report, this 
> > > is an obvious NAK.
> > 
> > I have hardware with faulty ACPI values which prevents me from getting a
> > eventlog. I can surely make a bugreport if it helps the case, but that seems
> > like an arbiterary hurdle when I have already spent the time tracking down the
> > issue and proposed a fix.
> 
> What is the hardware?

I included it in the commit message with the listed ACPI table values.


The following hardware was used to test this issue:
    Framework Laptop (Pre-production)
    BIOS: INSYDE Corp, Revision: 3.2
    TPM Device: NTC, Firmware Revision: 7.2

Dump of the faulty ACPI TPM2 table:
    [000h 0000   4]                    Signature : "TPM2"    [Trusted Platform Module hardware interface Table]
    [004h 0004   4]                 Table Length : 0000004C
    [008h 0008   1]                     Revision : 04
    [009h 0009   1]                     Checksum : 2B
    [00Ah 0010   6]                       Oem ID : "INSYDE"
    [010h 0016   8]                 Oem Table ID : "TGL-ULT"
    [018h 0024   4]                 Oem Revision : 00000002
    [01Ch 0028   4]              Asl Compiler ID : "ACPI"
    [020h 0032   4]        Asl Compiler Revision : 00040000

    [024h 0036   2]               Platform Class : 0000
    [026h 0038   2]                     Reserved : 0000
    [028h 0040   8]              Control Address : 0000000000000000
    [030h 0048   4]                 Start Method : 06 [Memory Mapped I/O]

    [034h 0052  12]            Method Parameters : 00 00 00 00 00 00 00 00 00 00 00 00
    [040h 0064   4]           Minimum Log Length : 00010000
    [044h 0068   8]                  Log Address : 000000004053D000

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
