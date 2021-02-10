Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBD316AD1
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBJQND (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 11:13:03 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:33748 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230005AbhBJQNC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 11:13:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C070712800AA;
        Wed, 10 Feb 2021 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612973540;
        bh=89lf76edSQmfx/4TxVlRidrOpJvFS3onlWzfpqBsiPM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Zyt+QRJjdgdfUEKt2ywEb3kDyDNZ1DlOv7i5kySMnghwZa4V4AFXRerhtVhHxGgUL
         DMlfmEJ2Jy9W120dn9AaWEql/nWmhmajiu2C35nAB8/GalhmVZHKiLMWLsTu9sFBhs
         lvWHia1rICJd7noNiuA0cpMh0iGh7HXGRG5WYg+M=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2YwBzT0X9qTq; Wed, 10 Feb 2021 08:12:20 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5020812800A0;
        Wed, 10 Feb 2021 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1612973540;
        bh=89lf76edSQmfx/4TxVlRidrOpJvFS3onlWzfpqBsiPM=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Zyt+QRJjdgdfUEKt2ywEb3kDyDNZ1DlOv7i5kySMnghwZa4V4AFXRerhtVhHxGgUL
         DMlfmEJ2Jy9W120dn9AaWEql/nWmhmajiu2C35nAB8/GalhmVZHKiLMWLsTu9sFBhs
         lvWHia1rICJd7noNiuA0cpMh0iGh7HXGRG5WYg+M=
Message-ID: <781858e64422e78d0285c6762470a3ef3b6a114d.camel@HansenPartnership.com>
Subject: Re: [PATCH v15 3/5] security: keys: trusted: fix TPM2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Wed, 10 Feb 2021 08:12:19 -0800
In-Reply-To: <1327393.1612972717@warthog.procyon.org.uk>
References: <20210127190617.17564-4-James.Bottomley@HansenPartnership.com>
         <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
         <1327393.1612972717@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-02-10 at 15:58 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > keyctl add trusted kmk "new 32
> > blobauth=f572d396fae9206628714fb2ce00f72e94f2258fkeyhandle=81000001
> > " @u
> 
> I presume there should be a space in there?

Um, yes.  My screen wraps at 80 characters which has keyhandle=
conveniently on the next line.

James


