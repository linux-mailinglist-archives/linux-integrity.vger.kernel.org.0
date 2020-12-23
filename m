Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E642E2113
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 20:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgLWT7B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Dec 2020 14:59:01 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:45284 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728156AbgLWT67 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Dec 2020 14:58:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EC8D01280557;
        Wed, 23 Dec 2020 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1608753498;
        bh=wqtAxY0FfYTORD4SPEnmy1FaaSHPAOyRwfe2oiJr3pM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=RUSOup40JNt3n7UTMYVW7TNayXu2YimWLbHvMvjYjBBJ6Q+y1xy+aaS4dXVjg5xFv
         CThfDCGVmrK2CAgs+7YZZaqRpt8llg6HSRUFTpG83RnjY9zFJ8gTJG9LFrzA+kj0lW
         0YAMI/JDFVuqQHuzRY4J0zPXsXCnpOAPC5NVKDIE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 49pKqgaFtOs4; Wed, 23 Dec 2020 11:58:18 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 631E2128047C;
        Wed, 23 Dec 2020 11:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1608753498;
        bh=wqtAxY0FfYTORD4SPEnmy1FaaSHPAOyRwfe2oiJr3pM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=RUSOup40JNt3n7UTMYVW7TNayXu2YimWLbHvMvjYjBBJ6Q+y1xy+aaS4dXVjg5xFv
         CThfDCGVmrK2CAgs+7YZZaqRpt8llg6HSRUFTpG83RnjY9zFJ8gTJG9LFrzA+kj0lW
         0YAMI/JDFVuqQHuzRY4J0zPXsXCnpOAPC5NVKDIE=
Message-ID: <aa82e85e1a5055367517b1f0c0f00206f51353cb.camel@HansenPartnership.com>
Subject: Re: [PATCH v14 3/5] security: keys: trusted: fix TPM2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Wed, 23 Dec 2020 11:58:17 -0800
In-Reply-To: <dfd33d3d-8e1c-8acf-a3aa-3b62659d5d68@linux.ibm.com>
References: <20201129222004.4428-1-James.Bottomley@HansenPartnership.com>
         <20201129222004.4428-4-James.Bottomley@HansenPartnership.com>
         <dfd33d3d-8e1c-8acf-a3aa-3b62659d5d68@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-12-22 at 18:01 -0500, Ken Goldman wrote:
> On 11/29/2020 5:20 PM, James Bottomley wrote:
> > Note this is both and enhancement and a potential bug fix.  The TPM
> > 2.0 spec requires us to strip leading zeros, meaning empyty
> > authorization is a zero length HMAC whereas we're currently passing
> > in 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but
> > the Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > patch makes the Microsoft TPM emulator work with trusted keys.
> 
> 1 - To be precise, it strips trailing zeros, but 20 bytes of zero
> results in an empty buffer either way.
> 
> "
> Part 1 19.6.4.3	Authorization Size Convention
> 
> Trailing octets of zero are to be removed from any string before it
> is used as an authValue.
> "
> 
> 
> 2 - If you have a test case for the MS simulator, post it and I'll
> give it a try.
> 
> I did a quick test, power cycle to set platform auth to empty, than
> create primary with a parent password 20 bytes of zero, and the
> SW TPM accepted it.
> 
> This was a password session, not an HMAC session.

I reported it to Microsoft as soon as I found the problem, so, since
this patch set has been languishing for years, I'd hope it would be
fixed by now.  It is still, however, possible there still exist TPM
implementations based on the unfixed Microsoft reference platform.

James


