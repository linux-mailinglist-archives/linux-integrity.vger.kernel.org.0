Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69328AEF8D
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2019 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436687AbfIJQ3m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 12:29:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48120 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436679AbfIJQ3m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 12:29:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F5828EE144;
        Tue, 10 Sep 2019 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568132982;
        bh=dBMOnsWqcPcPSvJAVrkZME4oB730UFVDbyJsD+pmtpk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UZAnX4Gm/8XAkJe8IRVZSr2RrIQ42IwotQPvfBPZmph2leJ2EH8h5YL6IMQC14xQa
         0QUqSasQE6qv6Yzb6mFodjc8xYETDx1lUZZ5rI89J1NwD5cfKHYW7nbx36GR05UATj
         zwR5GOcPFfQt01Iz76sWndusn7VxPFJiWgkFJbXI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M8YWZarO0dfM; Tue, 10 Sep 2019 09:29:42 -0700 (PDT)
Received: from [192.168.6.117] (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AAA528EE116;
        Tue, 10 Sep 2019 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568132981;
        bh=dBMOnsWqcPcPSvJAVrkZME4oB730UFVDbyJsD+pmtpk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=suVfyS3RGYNXQQWv7wPTZ18lB0JSGvaVXFOqscJLnprwhvA9MbNxWcs9YTO1PXQCM
         RVevJNoJt6ms2ISKHF9p3xqW9OTpZDOUruFYzysbioJjUZsTe4Uaj7Y5uPN2UOdLAs
         EWhsXnXjewjdzObI9Bbw+Kfw8ENTgPhaHgg02Ptc=
Message-ID: <1568132978.22959.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 00/12] add integrity and security to TPM2 transactions
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 10 Sep 2019 17:29:38 +0100
In-Reply-To: <20190910162132.GA11338@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
         <20190910162132.GA11338@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-10 at 17:21 +0100, Jarkko Sakkinen wrote:
> On Mon, Sep 09, 2019 at 01:16:48PM +0100, James Bottomley wrote:
> > Link to previous cover letter:
> > 
> > https://lore.kernel.org/linux-integrity/1540193596.3202.7.camel@Han
> > senPartnership.com/
> > 
> > This is marked v6 instead of v5 because I did a v5 after feedback
> > on v4
> > but didn't get around to posting it and then had to rework the
> > whole of
> > the kernel space handling while I was on holiday.  I also added the
> > documentation of how the whole thing works and the rationale for
> > doing
> > it in tpm-security.rst (patch 11).  The main reason for doing this
> > now
> > is so we have something to discuss at Plumbers.
> > 
> > The new patch set implements the various splits requested, but the
> > main
> > changes are that the kernel space is gone and is replaced by a
> > context
> > save and restore of the generated null seed.  This is easier to
> > handle
> > than a full kernel space given the new threading for TPM spaces,
> > but
> > conceptually it is still very like a space.  I've also made whether
> > integrity and encryption is turned on a Kconfig option.
> > 
> > James
> 
> So... is there a changelog for the revisions?

Well, yes, standard way: they're in the individual patches under the '-
--' prefixed with v6:

James

