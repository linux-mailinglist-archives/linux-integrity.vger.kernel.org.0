Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70B1544562
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jun 2022 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiFIIMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 04:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiFIIMH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 04:12:07 -0400
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1D25C76F;
        Thu,  9 Jun 2022 01:12:04 -0700 (PDT)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id 8D25AC026B;
        Thu,  9 Jun 2022 10:12:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1654762321;
        bh=t012ZvzTLZ1Em+XqaUMzEGm2gvGEMf/wCSWMQOp9dVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DyN2zUlXqiU0GGMFAncbttzxVvZhQySE8vMRBFTrcvVXV6LpTdwgkXtoqCcIl1o9y
         DbgUbuESWRqpR5vV20DRn+jv+P/gaXp6+sV0yOnn0JO/XeSLAHkn1qlHAgDvfjjwI7
         s0ZFYb6yR8hxWf9inYMsg5MtT8nzjNRVyCrtEUfJKXvZ6A1SepqrHlliRhW7fBSuLg
         0OBYsrFKzjjsxCwHJDJKlO+eHW+tGapobSVZC0O9CZ9arsMYJH0Q+ECVPc1o+zWTHe
         W1x70sCXIvWPO+Kofm3kiNub251qtRYKJ4I7cKMTTMjOyZzZTKcChyjg955j3h1PHK
         UCLW0zgZxdeYQ6hjFBJEWGs09k7CJQ9uigtlNf5aoMtdHOdmixZ0XK/aNvdpdplFVa
         HBRurqtXGob3sbSb/kKtsIgceg1QLsFvVG44pdrXPCqb0wui6gXjl8rf+XR4vphaAT
         hmj5y2mBE4rq1qfWJETxStb/y5ReNXxyHs9/xx9nywzp+nIqlLRa1NvO2GehXuCrLI
         DenueuYm44EK8H7SHmq4Q6N9OU0xgmYS4+nVNBKsNh/GEyLZQUGvott/FrhlQnYONd
         6jXi6xJwI3KN8BzMZFhvjZFc/43OK4JVJ1D7b87GDcU2c1dsklxEwY0YpU0xfOgCk5
         p1uqDCfaM4vbAbEsgV4hl9G4=
Received: from localhost (unknown [188.95.241.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 4CF35C01C9;
        Thu,  9 Jun 2022 10:12:01 +0200 (CEST)
Date:   Thu, 9 Jun 2022 10:11:59 +0200
From:   Morten Linderud <morten@linderud.pw>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 address
Message-ID: <20220609081159.rjj7a3x63y7ag4ty@terminus>
References: <20220608123109.678343-1-morten@linderud.pw>
 <YqF7NktlAJg26Bvd@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqF7NktlAJg26Bvd@iki.fi>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 09, 2022 at 07:46:46AM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 08, 2022 at 02:31:08PM +0200, Morten Linderud wrote:
> > tpm_read_log_acpi() should return -ENODEV when no eventlog from the ACPI
> > table is found. If the firmware vendor includes an invalid log address
> > we are unable to map from the ACPI memory and the function returns -EIO
> > which would abort discovery of the eventlog.
> > 
> > This change ensure we always return -ENODEV in tpm_read_log_acpi() and
> > fallback to the EFI configuration table.
> 
> Please do not use "we" in commit messages. Or start a sentence
> with "this patch", "this commit" or "this change". It is always
> best just to go down to the roots and use imperative form.
> 
> E.g. you could rephrase the last paragraph as
> 
> "Change the return value from -EIO to -ENODEV when acpi_os_map_iomem()
> fails to map the event log."

ack

> > The following hardware was used to test this issue:
> >     Framework Laptop (Pre-production)
> >     BIOS: INSYDE Corp, Revision: 3.2
> >     TPM Device: NTC, Firmware Revision: 7.2
> > 
> > Dump of the faulty ACPI TPM2 table:
> >     [000h 0000   4]                    Signature : "TPM2"    [Trusted Platform Module hardware interface Table]
> >     [004h 0004   4]                 Table Length : 0000004C
> >     [008h 0008   1]                     Revision : 04
> >     [009h 0009   1]                     Checksum : 2B
> >     [00Ah 0010   6]                       Oem ID : "INSYDE"
> >     [010h 0016   8]                 Oem Table ID : "TGL-ULT"
> >     [018h 0024   4]                 Oem Revision : 00000002
> >     [01Ch 0028   4]              Asl Compiler ID : "ACPI"
> >     [020h 0032   4]        Asl Compiler Revision : 00040000
> > 
> >     [024h 0036   2]               Platform Class : 0000
> >     [026h 0038   2]                     Reserved : 0000
> >     [028h 0040   8]              Control Address : 0000000000000000
> >     [030h 0048   4]                 Start Method : 06 [Memory Mapped I/O]
> > 
> >     [034h 0052  12]            Method Parameters : 00 00 00 00 00 00 00 00 00 00 00 00
> >     [040h 0064   4]           Minimum Log Length : 00010000
> >     [044h 0068   8]                  Log Address : 000000004053D000
> > 
> > Signed-off-by: Morten Linderud <morten@linderud.pw>
> > 
> > ---
> > 
> > v2: Tweak commit message and opt to return -ENODEV instead of loosening up the
> >     if condition in tpm_read_log()
> > 
> > ---
> >  drivers/char/tpm/eventlog/acpi.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> > index 1b18ce5ebab1..2b15d6eebd69 100644
> > --- a/drivers/char/tpm/eventlog/acpi.c
> > +++ b/drivers/char/tpm/eventlog/acpi.c
> > @@ -136,8 +136,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> >  
> >  	ret = -EIO;
> >  	virt = acpi_os_map_iomem(start, len);
> > -	if (!virt)
> > +	if (!virt) {
> > +		dev_warn(&chip->dev, "%s: Failed to map ACPI memory\n", __func__);
> > +		/* try EFI log next */
> > +		ret = -ENODEV;
> >  		goto err;
> > +	}
> 
> It is wrong to try out EFI, if this fails. TPM2 ACPI table was already
> detected.

The next branch tries out EFI if the eventlog it found is empty, as it created
an empty file. This branch would produce no eventlog if we fail to map the
memory. I don't understand why there would be a difference between these two
branches?

This seems like an oversight after 3dcd15665aca80197333500a4be3900948afccc1

> >  
> >  	memcpy_fromio(log->bios_event_log, virt, len);
> >  
> > -- 
> > 2.36.1
> 
> What you are using this for? Without any actual bug report, this 
> is an obvious NAK.

I have hardware with faulty ACPI values which prevents me from getting a
eventlog. I can surely make a bugreport if it helps the case, but that seems
like an arbiterary hurdle when I have already spent the time tracking down the
issue and proposed a fix.

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
