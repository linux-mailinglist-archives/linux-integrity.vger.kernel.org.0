Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A245F51C1
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Oct 2022 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJEJcK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Oct 2022 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJEJcI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Oct 2022 05:32:08 -0400
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4501FCC8;
        Wed,  5 Oct 2022 02:32:05 -0700 (PDT)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id 7901FC028C;
        Wed,  5 Oct 2022 11:31:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1664962292;
        bh=vX7y6tt/nR7ILFaDhy4O+3QY4gLJC6/KfUIc2fyat80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=psdPxcswAtbpqhhvz02MMbbqJYpbjn4JOpJ/c9FIcVshDDoOD/gV8PU1KbOQVgPid
         kfGbQZgxgeBB7EUOS3lr5YRaNR7JAPw4qIfOuKdBwJcD4NeW50Y2PuEYa2lGcjFWEM
         aRxRNnM1+V99rsH4RuS2ZEAAiCy8yDT1Z3tGq7/Q1H6+1Rafxh91wwzZ9gxn/PCBTd
         jKEv7EjbpLhar9D9mkx7TuTvYkeJbybqtohXNUW3K8v6veClk6x2z9KtxOZ/bn3aVA
         0ruXxqgkIPIttK9zARpT76aghe3hgViuL99+21T5WWEcZ74cEyLRG8B10prkzOaJPy
         XyCg7vVZAjjcj493RMyOdTLn95Hv3qd8sAxSWZ5H+UWb0jhRGX9hH4rQHsGgHoHse2
         BzjEdCxieToDaDlgqp26eqI2qfM82ptCMhXoZN44XNLdmE7/HypdFFfTLCLsmraCVM
         qs8oyCopfIivWEQS7877w7K13dfL++aJO8wzeQXvJmHi3w/+8+8UyJVGSfnpWYt/Vw
         a7q3JddBiFC8DT7UVwtfIpCOYIHV3nZX955PqU3W/qqxZcS22CFkKhOduVDhXWhddk
         9KAoVde29KujeLhO4Uu9XJxHFqtZRFQ0ZPlB7y+cxgwmeGrZQ1KckkvRCFa93t7rQz
         6+WvQbpPzUgdnt9gEHx5WOO0=
Received: from localhost (unknown [194.69.103.253])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 39AB7C01AE;
        Wed,  5 Oct 2022 11:31:32 +0200 (CEST)
Date:   Wed, 5 Oct 2022 11:31:28 +0200
From:   Morten Linderud <morten@linderud.pw>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 config
Message-ID: <20221005093128.nsudft5yl32xj2gg@framework>
References: <20210920203447.4124005-1-morten@linderud.pw>
 <Yzy2STXGSBmSLhmA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yzy2STXGSBmSLhmA@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 05, 2022 at 01:40:09AM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 20, 2021 at 10:34:47PM +0200, Morten Linderud wrote:
> > Some vendors report faulty values in the acpi TPM2 table. This causes
> 
> s/acpi/ACPI/
> 
> > the function to abort with EIO and essentially short circuits the
> 
> s/the function/tpm_read_log()/
> 
> > tpm_read_log function as we never even attempt to read the EFI
> > configuration table for a log.
> 
> > 
> > This changes the condition to only look for a positive return value,
> > else hands over the eventlog discovery to the EFI configuration table
> > which should hopefully work better.
> 
> Please, write in imperative ("Change...").
> 
> Also exlicitly state how are you changing the check for
> tpm_read_log_acpi() in tpm_read_log().
> 
> You could *even* have a snippet how the checks change
> here for clarity.
> 
> > It's unclear to me if there is a better solution to this then just
> > failing. However, I do not see any clear reason why we can't properly
> > fallback to the EFI configuration table.
> 
> This paragraph should not be part of the commit message.
> 
> Rest of the commit message made sense can you add also fixes tag
> as this is clearly a bug fix?
> 
> Also, please remove the two spurious diff's from the commit that
> are not relevant for a stable bug fix (pr_warn() and comment
> removal).

Yo,

This is the v1 of the patch which you reviewed a year ago.
https://marc.info/?l=linux-integrity&m=163225066613340&w=2

V2 mostly fixed the commit message, but there where some more pointers. I'm
happy to submit a V3 if we can agree on all the details.

V2 review is here:
https://marc.info/?l=linux-integrity&m=165475008823837&w=2

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
