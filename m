Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E225D413AB7
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Sep 2021 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhIUT3z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Sep 2021 15:29:55 -0400
Received: from linderud.dev ([163.172.10.146]:36962 "EHLO linderud.pw"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhIUT3z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Sep 2021 15:29:55 -0400
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id 5A9B7C032A;
        Tue, 21 Sep 2021 21:27:53 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on velox
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.5-pre1
Received: from localhost (host-37-191-241-102.lynet.no [37.191.241.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 1206BC001C;
        Tue, 21 Sep 2021 21:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1632252473;
        bh=0GqyYMQkXphc8kPn1Om1uqRbo2dbuCAEQIAmDaGZnPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DvbI4uZ2GGwJM7jz99iiU/H9cQ7deSnqx7286T7FmIUK+8MtyVjM23cFUFPQfJIhC
         VLuUX74csW/y7nnK/9thz70X5jJYYQDjVx+ewsTi50i7bUCcQaWWl/d+NUMqreGcA9
         Ex5jhtJoPzVBCap1zEXVcjFyCYKPuYii5mBUe12Ftsrax1V1gsrjMYxLoS1LGwI4fb
         DwQ9vqYHFS+0hvooYH27qXWVdpygiKlDFd9OW4cH/bUQ5IsYOLcmOj4a3Gatl4TMDf
         BUz8FL7WdrmWC+dQy4AGnClrgt+vs4Zb9IdhDB0quKRNHgUMWgKM8oE3JxgHToKt2z
         +BNXsJ9CS5lZzfuOqTBJFtd/n6zsUNtM3KaSHJn2kdObH3d1UT60w5jF+l75GrU/Lz
         MXEnJUDY3obRCu6KvFN98tyb2Kz4ESK7gOGOYDSud/B40ODadNyewsRSO9QUc0oEAr
         NSrZavWfHRSmFqBJTNoyoWV9LQtYAcYC5ZKD+8vCCje4Z+i8lUsp0LC4eeLeEZZNrJ
         ydTnV07iGnzNarryzXc6ewkrzMyfWNzmIONSfE3revI1nBG97WGg/hrG4cOcBMIP4v
         ZZB4TigNxKYYsNJ4n9f4F8EOjJDgU+yMb2/1ekmtg45yYOr/c4RblPfebeoIC+FOXa
         dZDsAzLNX2y3zbNKrUZzV1KM=
Date:   Tue, 21 Sep 2021 21:27:51 +0200
From:   Morten Linderud <morten@linderud.pw>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 config
Message-ID: <20210921192751.3ukruxkzukzfw5xl@anathema>
References: <20210920203447.4124005-1-morten@linderud.pw>
 <896a0773cac953ae2f35ba08af65a598aa71942d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <896a0773cac953ae2f35ba08af65a598aa71942d.camel@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 21, 2021 at 09:58:11PM +0300, Jarkko Sakkinen wrote:
> On Mon, 2021-09-20 at 22:34 +0200, Morten Linderud wrote:
> > Some vendors report faulty values in the acpi TPM2 table. This causes
> 
> Nit: ACPI (not acpi)
> 
> > the function to abort with EIO and essentially short circuits the
> > tpm_read_log function as we never even attempt to read the EFI
> > configuration table for a log.
> 
> Nit: tpm_read_log()
> 
> > This changes the condition to only look for a positive return value,
> > else hands over the eventlog discovery to the EFI configuration table
> 
> "hands over" -> "fallback"
> 
> > which should hopefully work better.
> 
> Please write in imperative form, e.g. "Change...", or perhaps in this
> case "Look...". 
> 
> Hopes are somewhat irrelevant, in the context of a commit message.
> 
> > It's unclear to me if there is a better solution to this then just
> > failing. However, I do not see any clear reason why we can't properly
> > fallback to the EFI configuration table.
> 
> Neither hopes nor doubts help us :-)
> 
> Because the commit message did not discuss any of the code changes
> that were done it is very hard to say much anything of this yet.

Thanks for the review! First kernel patch so all feedback is welcome :)

The code change is essentially just relaxing the return value for the ACPI log
lookup. I'm not quite sure what is missing from the commit message in that
regard? Is the second paragraph insufficient?

> There's also one corner case that was not discussed in the commit
> message.
> 
> The historical reason for not using TPM2 file is that old TPM2's
> did not have that feature. You have to ensure that legacy hardware
> does not break.

This should only relax the cases where an error which is not ENODEV is returned.
Legacy hardware that return ENODEV because the table doesn't exist, or is
missing the log start and length, should be unaffected by this change.

> /Jarkko

Cheers!

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
