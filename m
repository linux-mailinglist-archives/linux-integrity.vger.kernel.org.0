Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4272AAA6
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Jun 2023 11:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFJJZe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 10 Jun 2023 05:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFJJZd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Jun 2023 05:25:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF816210D;
        Sat, 10 Jun 2023 02:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847BE601D9;
        Sat, 10 Jun 2023 09:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78196C433D2;
        Sat, 10 Jun 2023 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686389131;
        bh=5ObCuzkHbQXY0iZOA2ZfL1NpOhXO7BEV89T0/ACabBA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=bfG0JuaY7zTdbEpyw8U1wbFyeaeHptIrAWxa/VzFvUUkqO7LySZr9nSSFgXsVaE31
         8vBKlFFXCuUQNcKzRqCQwYSw7sjzNL/WEdX0NXGy5yrHTkVTN2cIfMzQFRHfdbqpqX
         oDoP3YtVXVaIHTQE50BUEN9tx8nVUgEsH5w4o4gKTM36LE0/6MTyXJnARRjKXLHIzU
         4XOM7EFlBwi4flM8B2iSjgH0mKTxv6tetRXanPPgqsaBjzowpLtqkNeo7J118dZg+B
         DwLD5jtNY/c0YL5uCnkcSQRrr9N4WaOEMDqucNSVIWerTeCL9RXmefNcbekTjcm4ef
         GI5X8v5rPOHew==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 10 Jun 2023 12:25:25 +0300
Message-Id: <CT8V1XE69DQ3.2JLQ9S20PK9OW@suppilovahvero>
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>
Cc:     <kexec@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <nayna@linux.ibm.com>,
        <nasastry@in.ibm.com>, <mpe@ellerman.id.au>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Nageswara R Sastry" <rnsastry@linux.ibm.com>,
        "Coiby Xu" <coxu@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
 <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
 <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
 <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
In-Reply-To: <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jun 9, 2023 at 9:49 PM EEST, Stefan Berger wrote:
>
>
> On 6/9/23 14:18, Jarkko Sakkinen wrote:
> > On Thu May 25, 2023 at 1:56 AM EEST, Jerry Snitselaar wrote:
> >> On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
> >>> Simplify tpm_read_log_of() by moving reusable parts of the code into
> >>> an inline function that makes it commonly available so it can be
> >>> used also for kexec support. Call the new of_tpm_get_sml_parameters()
> >>> function from the TPM Open Firmware driver.
> >>>
> >>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> >>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Frank Rowand <frowand.list@gmail.com>
> >>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >>> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> >>> Tested-by: Coiby Xu <coxu@redhat.com>
> >>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>>
> >>
> >> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> >=20
> > If I just pick tpm only patches they won't apply so maybe TPM changes
> > should be better separated if that is by any means possible.
>
> Per the comment here I am putting this series here on hold.
> https://lore.kernel.org/linux-integrity/20230418134409.177485-1-stefanb@l=
inux.ibm.com/T/#m03745c2af2c46f19f329522fcb6ccb2bf2eaedc7

OK, cool.

I've mentioned this in few other emails but say this here too:
I was relocating for last couple of weeks, and thus some latency.
If you choose to repost the series, I'm happy to review it, thanks
:-)

BR, Jarkko
