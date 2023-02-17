Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11869B582
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 23:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBQWaZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Feb 2023 17:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBQWaZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 17:30:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E417C5F82F;
        Fri, 17 Feb 2023 14:30:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793B662083;
        Fri, 17 Feb 2023 22:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17696C433D2;
        Fri, 17 Feb 2023 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676673022;
        bh=TaKs9Xm/+6yQkwbOE02WdZVlPG+foCn+FlNN/riPepk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFVU2Mr6QU1/Swa5NfIl9w1dFQji3d0ptw5UoYAfIOJAEEKKZoofeLklJM9QSH9x9
         NB2RYv6B2Pt6PHI5190P9G/EDZ0t5sNj1QJlwZCBgvgfdW99+8r0jpHTM3ijAAmB22
         I7G4OXy7X1Hnk1TrRpM9U8OzkRPtBPRzimrRYX5137lw45bR7rBWISkiYM3VlEJ8z0
         lrJGuvn/gLGVzjbOiH1JKfzeTwoYqV5w6gLJ1+vi1M+U1IXtyI13PbmXJh0zbWxAWG
         QSgWehQ4DdXOXcRgHMuo6APKoNyqwMwFQZT219YDY4SoAXwNVsyWx/ui27YtoB/Ee5
         GA0uVoX9/hmmw==
Date:   Sat, 18 Feb 2023 00:30:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Morten Linderud <morten@linderud.pw>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jgg@ziepe.ca, peterhuewe@gmx.de, Erkki Eilonen <erkki@bearmetal.eu>
Subject: Re: [PATCH v3] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 address
Message-ID: <Y+//+pFcdluslFJj@kernel.org>
References: <20230215092552.3004363-1-morten@linderud.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215092552.3004363-1-morten@linderud.pw>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 15, 2023 at 10:25:52AM +0100, Morten Linderud wrote:
> tpm_read_log_acpi() should return -ENODEV when no eventlog from the ACPI
> table is found. If the firmware vendor includes an invalid log address
> we are unable to map from the ACPI memory and tpm_read_log() returns -EIO
> which would abort discovery of the eventlog.
> 
> Change the return value from -EIO to -ENODEV when acpi_os_map_iomem()
> fails to map the event log.
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
> Fixes: 0cf577a03f21 ("tpm: Fix handling of missing event log")
> Tested-By: Erkki Eilonen <erkki@bearmetal.eu>
> Signed-off-by: Morten Linderud <morten@linderud.pw>
> 
> ---
> 
> v2: Tweak commit message and opt to return -ENODEV instead of loosening up the
>     if condition in tpm_read_log()
> 
> v3: Mention function name instead of "this" in the commit log. Added Tested-By
>     and Fixes tags
> 
> ---
>  drivers/char/tpm/eventlog/acpi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> index 0913d3eb8d51..cd266021d010 100644
> --- a/drivers/char/tpm/eventlog/acpi.c
> +++ b/drivers/char/tpm/eventlog/acpi.c
> @@ -143,8 +143,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
>  
>  	ret = -EIO;
>  	virt = acpi_os_map_iomem(start, len);
> -	if (!virt)
> +	if (!virt) {
> +		dev_warn(&chip->dev, "%s: Failed to map ACPI memory\n", __func__);
> +		/* try EFI log next */
> +		ret = -ENODEV;
>  		goto err;
> +	}
>  
>  	memcpy_fromio(log->bios_event_log, virt, len);
>  
> -- 
> 2.39.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I'll apply this soon, thanks.

BR, Jarkko
