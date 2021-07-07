Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2F33BEC40
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhGGQcD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGQcD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 12:32:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916ADC06175F;
        Wed,  7 Jul 2021 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ezJ8D561LeiNFNTXI+SFBNGGI82ZzKwSzhWjxdukNCw=; b=fOrdgjp1zVUK2yj1F8mQnCBpy0
        DPxShUomaX5wPaGIwtx/tpW7tHEAlz8XKPETvLnfxJVS+o0wq/bY8UkGCeHcPJrKmrrfw9GJdMEf2
        X/6xcmtLbWsKdhMfQZBUho7vyUqxLiY8QHzP8VV3SWtFh4sLY0iyHmPiNseEwJ8Lg7Xjp3K+SnEf+
        X5gBL1Z3xNZaFvRE/GLKRuiI2KqOIdAXx2YWDL4/ZggqSAQ59YnfGFFZKb/piOl3WqYcFfCkOa7OV
        C/xIO5o0OfftCxKJzq5OFOc3CmaFkSIIhK8sUcJCTJDXhtaPFGQoUFXstkhqfagLn+rSg1H50NYxE
        tJpu9dcA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1APh-00CaF9-Tk; Wed, 07 Jul 2021 16:28:45 +0000
Date:   Wed, 7 Jul 2021 17:28:41 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
Message-ID: <YOXWOaPma2dMf6fk@infradead.org>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <YOVNrhxCJpfTbpVq@infradead.org>
 <E4A6A4E2-F9CB-4996-965A-772B3CA15555@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E4A6A4E2-F9CB-4996-965A-772B3CA15555@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 07, 2021 at 10:23:04AM -0600, Eric Snowberg wrote:
> 
> > On Jul 7, 2021, at 12:46 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Tue, Jul 06, 2021 at 10:43:51PM -0400, Eric Snowberg wrote:
> >> This is a follow up to the "Add additional MOK vars" [1] series I 
> >> previously sent.  This series incorporates the feedback given 
> >> both publicly on the mailing list and privately from Mimi. This 
> >> series just focuses on getting end-user keys into the kernel trust 
> >> boundary.
> > 
> > WTF is MOK?
> 
> MOK stands for Machine Owner Key.   The MOK facility can be used to 
> import keys that you use to sign your own development kernel build, 
> so that it is able to boot with UEFI Secure Boot enabled. Many Linux 
> distributions have implemented UEFI Secure Boot using these keys 
> as well as the ones Secure Boot provides.  It allows the end-user 
> a choice, instead of locking them into only being able to use keys 
> their hardware manufacture provided, or forcing them to enroll keys 
> through their BIOS.

Please spell this out in your cover letters and commit logs.
