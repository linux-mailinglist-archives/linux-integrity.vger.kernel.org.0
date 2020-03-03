Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE8178431
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Mar 2020 21:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbgCCUkn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Mar 2020 15:40:43 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47038 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729681AbgCCUkn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Mar 2020 15:40:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5CCF48EE11D;
        Tue,  3 Mar 2020 12:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583268043;
        bh=5sUKzUIdATJJ/+Bhm1MKpbzoSx1wTnFL+HZHr1UZ5ik=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n+Djv3PnDx9me7XCDVv5Kw25pEFCRJJCWGQZaRlIFSGt1F/Wu281107paVqWMAk+x
         imZGzjetPNZfv6jKx6Uvvpg2Wmy7mcqWToWcPWm4QR+9tQzP1ir5woFw8puTEWDHOO
         p4iCSfL4BrxGRq9dzG1oUK7Y15dmcrvQ/uyG9u9E=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GxcBukLLUoO6; Tue,  3 Mar 2020 12:40:43 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9E8298EE10C;
        Tue,  3 Mar 2020 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583268043;
        bh=5sUKzUIdATJJ/+Bhm1MKpbzoSx1wTnFL+HZHr1UZ5ik=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=n+Djv3PnDx9me7XCDVv5Kw25pEFCRJJCWGQZaRlIFSGt1F/Wu281107paVqWMAk+x
         imZGzjetPNZfv6jKx6Uvvpg2Wmy7mcqWToWcPWm4QR+9tQzP1ir5woFw8puTEWDHOO
         p4iCSfL4BrxGRq9dzG1oUK7Y15dmcrvQ/uyG9u9E=
Message-ID: <1583268041.3638.9.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 6/6] security: keys: trusted: implement counter/timer
 policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Tue, 03 Mar 2020 15:40:41 -0500
In-Reply-To: <20200303200820.GE5775@linux.intel.com>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
         <20200302122759.5204-7-James.Bottomley@HansenPartnership.com>
         <20200303200820.GE5775@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-03-03 at 22:08 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 02, 2020 at 07:27:59AM -0500, James Bottomley wrote:
> > This is actually a generic policy allowing a range of comparisons
> > against any value set in the TPM Clock, which includes things like
> > the reset count, a monotonic millisecond count and the restart
> > count.  The most useful comparison is against the millisecond count
> > for expiring keys.  However, you have to remember that currently
> > Linux doesn't try to sync the epoch timer with the TPM, so the
> > expiration is actually measured in how long the TPM itself has been
> > powered on ... the TPM timer doesn't count while the system is
> > powered down.  The millisecond counter is a u64 quantity found at
> > offset 8 in the timer structure, and the <= comparision operand is
> > 9, so a policy set to expire after the TPM has been up for 100
> > seconds would look like
> > 
> > 0000016d00000000000f424000080009
> > 
> > Where 0x16d is the counter timer policy code and 0xf4240 is 100 000
> > in hex.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> It is techincally possible to merge 1-5 without this and have
> something functional?

Yes: it just adds to the policy types we understand, but we can still
do password and PCR policies without this.

James

