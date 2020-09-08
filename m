Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67486261969
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 20:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgIHSOT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 14:14:19 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37156 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731475AbgIHSOP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 14:14:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AE64E8EE111;
        Tue,  8 Sep 2020 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599588852;
        bh=j/Z0xwPcvtu9ZFC2XX7h+d9waydMl0v6qHFUaoPjNXk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Nf/ewMMU+jXtifGqH5AQdiiGzyn6RylgiTNyniz1kh+k7AIdHGjPhx25JLpxjd0lQ
         SNITD048HJWn0oR7pnqd1X2Gr9Yw22czw4bKKmRqy5e30O8qbUJMviLoNnwU6HDYwp
         hEfDxBiTxKcPG6KQzW2caTjpTT9OpAOszhbT3DRw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pdo-vp8VfLxG; Tue,  8 Sep 2020 11:14:12 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0D4448EE0C6;
        Tue,  8 Sep 2020 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599588852;
        bh=j/Z0xwPcvtu9ZFC2XX7h+d9waydMl0v6qHFUaoPjNXk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Nf/ewMMU+jXtifGqH5AQdiiGzyn6RylgiTNyniz1kh+k7AIdHGjPhx25JLpxjd0lQ
         SNITD048HJWn0oR7pnqd1X2Gr9Yw22czw4bKKmRqy5e30O8qbUJMviLoNnwU6HDYwp
         hEfDxBiTxKcPG6KQzW2caTjpTT9OpAOszhbT3DRw=
Message-ID: <1599588851.10803.29.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Date:   Tue, 08 Sep 2020 11:14:11 -0700
In-Reply-To: <20200908180513.GB5390@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
         <20200907053824.GA279469@kroah.com>
         <20200907132322.GB106839@linux.intel.com>
         <1599515528.4232.55.camel@HansenPartnership.com>
         <20200908054552.GB303404@kroah.com> <20200908180513.GB5390@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-09-08 at 21:05 +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 08, 2020 at 07:45:52AM +0200, Greg KH wrote:
> > On Mon, Sep 07, 2020 at 02:52:08PM -0700, James Bottomley wrote:
[...]
> > > I've got to say I think binary attributes are actively evil.  I
> > > can see
> > > they're a necessity when there's no good way to represent the
> > > data they
> > > contain, like the bios measurement log or firmware code or a raw
> > > interface like we do for the SMP frame code in libsas.  But when
> > > there's a well understood and easy to produce user friendly non-
> > > binary
> > > representation, I think dumping binary is inimical to being a
> > > good API.
> > 
> > Agreed.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Looking at the patch, something like <device>/pcrs/<hash>/<index>
> would be a bit cleaner representation than the current <device>/pcrs-
> <hash>/<index>.

That's actually a technical limitation of using the current attribute
groups API: It's designed to support single level directories in sysfs
(or no directory at all).  That's not to say we can't do multi-level
ones, but if we do we have to roll our own machinery for managing the
files rather than relying on the groups API.

Given that the current groups API does all the nasty lifetime
management that I'd otherwise have to do in the patch, I have a strong
incentive for keeping it, which is why the single <device>/pcrs-
<hash>/<index> format.

James

