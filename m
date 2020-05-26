Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546B41E2FAD
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2020 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389689AbgEZUAS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 May 2020 16:00:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:40278 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389192AbgEZUAR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 May 2020 16:00:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D37D98EE181;
        Tue, 26 May 2020 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590523216;
        bh=EZt3MAAU3Hg10i9FE752yd5IDT4uWKbN7LKCv9x0GPQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NLV22qvXsh6issMEiflCG1YvaON1vKnS1OOLXctGyovv8WJlNWckH6sgvDdN1U/iM
         iNIKgzqlL1ICZ7B/kN43Ry0hTmQSVQ5J1cKMU42liF2Ys1h/I1m5mEmCZLpdWm4BDv
         QvJ03f0NvwQrsEpff8/BxBMdHqN7ZgW5fkW0anp4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JoFa7QQodzZs; Tue, 26 May 2020 13:00:15 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3E1088EE0D4;
        Tue, 26 May 2020 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1590523215;
        bh=EZt3MAAU3Hg10i9FE752yd5IDT4uWKbN7LKCv9x0GPQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=afcg++KYC4Z2n+x94LoS83eoHa6xVTQH/ThpIcfUJw490XnywifB+paixbtoxXZkr
         /SRGkFY0ddZ2KSAJcYOoDIbdesWLODByAkpqRiBWyXEF3jber4Lhj0TSC7913uCJLs
         AW8ndfCSbzt+latxR8khWR3zjUo/HoUS62nm6Sf4=
Message-ID: <1590523214.15108.4.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Revert "tpm: fix invalid locking in NONBLOCKING
 mode"
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tstruk@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Alex Guzman <alex@guzman.io>
Date:   Tue, 26 May 2020 13:00:14 -0700
In-Reply-To: <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
References: <20200526183213.20720-1-mario.limonciello@dell.com>
         <1590520454.11810.40.camel@HansenPartnership.com>
         <f63afdc1-6c40-dc0d-bb9a-154bc51d3b95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-05-26 at 12:39 -0700, Tadeusz Struk wrote:
> On 5/26/20 12:14 PM, James Bottomley wrote:
> > +	/* atomic tpm command send and result receive. We only
> > hold the ops
> > +	 * lock during this period so that the tpm can be
> > unregistered even if
> > +	 * the char dev is held open.
> > +	 */
> > +	if (tpm_try_get_ops(priv->chip)) {
> > +		ret = -EPIPE;
> > +		goto out;
> > +	}
> > +
> 
> Hi James,
> This won't help if the message is read by an async tcti.

Why not?  It moves the ops get underneath the async path, so it's now
all done in the direct read or the async read.  That seems to be more
efficient.

>  If the problem lies in the chip get locality code, perhaps this
> could help to debug the root-cause instead of masking it out in the
> upper layer code:

I don't think there is a root cause other than a TIS TPM is getting
annoyed by us cycling localities too rapidly because we don't do an
actual TPM operation between request and relinquish.  Since the first
request/relinquish seems unnecessary for the async case, moving the ops
get eliminates the problem.

James

