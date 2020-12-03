Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744C62CE04D
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Dec 2020 22:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgLCVFo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Dec 2020 16:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCVFo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Dec 2020 16:05:44 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430DC061A52;
        Thu,  3 Dec 2020 13:05:04 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D2B7F1280B66;
        Thu,  3 Dec 2020 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607029503;
        bh=UJ0dzKgWGj+kvvVqBtel3X5aOa+jAsa2wG7ghTAbBEo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VYxKisDfLldXRZXHEJyGu9KD47lVB4LMxIgAQM2atEPg3xI2Z5BNBt8KnPzru/Ucw
         mzzXzHFaABbbFB/jKeoZmyJ7tf6wOTD1yNNUpsSHZuV3PklBCVhfri2S9kDGSuD5Rz
         BlkPrF7MKFWOAWGjedkcA7Ufg/oAol1JPZ0LP6DA=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mTgAhRg7TuSj; Thu,  3 Dec 2020 13:05:03 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 43BC41280B60;
        Thu,  3 Dec 2020 13:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1607029503;
        bh=UJ0dzKgWGj+kvvVqBtel3X5aOa+jAsa2wG7ghTAbBEo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=VYxKisDfLldXRZXHEJyGu9KD47lVB4LMxIgAQM2atEPg3xI2Z5BNBt8KnPzru/Ucw
         mzzXzHFaABbbFB/jKeoZmyJ7tf6wOTD1yNNUpsSHZuV3PklBCVhfri2S9kDGSuD5Rz
         BlkPrF7MKFWOAWGjedkcA7Ufg/oAol1JPZ0LP6DA=
Message-ID: <8a7d2fda891e45b098b603064d45dd7d53898fd4.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm
 detected
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Thu, 03 Dec 2020 13:05:02 -0800
In-Reply-To: <87ft4mpryt.fsf@redhat.com>
References: <20201130232338.106892-1-jsnitsel@redhat.com>
         <20201201025807.162241-1-jsnitsel@redhat.com> <87czzujjg1.fsf@redhat.com>
         <878sahmh5w.fsf@redhat.com> <20201202164931.GA91318@kernel.org>
         <87sg8noixh.fsf@redhat.com> <87lfefe7vm.fsf@redhat.com>
         <87ft4mpryt.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-12-03 at 13:14 -0700, Jerry Snitselaar wrote:
> Jerry Snitselaar @ 2020-12-02 23:11 MST:
[...]
> > The interrupt storm detection code works on the T490s. I'm not sure
> > what is going on with the L490. I will see if I can get access to
> > one.
> > 
> > Jerry
> 
> Lenovo verified that the L490 hangs.

Just to confirm, that's this system:

https://www.lenovo.com/us/en/laptops/thinkpad/thinkpad-l/ThinkPad-L490/p/22TP2TBL490

We could ask if lenovo will give us one, but if not we could pull a
Jens.  [the backstory is that when Jens was doing queueing in the block
layer, there were lots of SATA devices that didn't work quite right but
you couldn't tell unless you actually tried them out.  Getting
manufacturers to send samples is rather arduous, so he took to ordering
them online, testing them out, and then returning them for a full
refund within the allowed window]

It looks like Lenovo has a nice christmas returns policy:

https://www.lenovo.com/us/en/shopping-faq/#returns

James


