Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64672606AB
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 23:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIGVwL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 17:52:11 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:52014 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726938AbgIGVwK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 17:52:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E531B8EE0F8;
        Mon,  7 Sep 2020 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599515529;
        bh=+sdT1AR2cAsRMeyPjgRDy7DSE5TFMS0Xfu6Rkcxje5o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e2UcPzfQiUBn1E1iT+t24CGIJuTQTPj34MawCaeZOvjRXMZJbTHZlj9yGl3B5B7+y
         hybj3vSSYOiuM0SRP8a806Fz/Y6VavDEJMJHQrc4rK+lbGQ9VwkLKP5nhUstCYCNyt
         0zHMVxTBbm/nq+mM6G/ZqrU4/3PwepoB3zcb6ses=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kcJ0vuVVY-Kv; Mon,  7 Sep 2020 14:52:09 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5CC428EE0E9;
        Mon,  7 Sep 2020 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599515529;
        bh=+sdT1AR2cAsRMeyPjgRDy7DSE5TFMS0Xfu6Rkcxje5o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e2UcPzfQiUBn1E1iT+t24CGIJuTQTPj34MawCaeZOvjRXMZJbTHZlj9yGl3B5B7+y
         hybj3vSSYOiuM0SRP8a806Fz/Y6VavDEJMJHQrc4rK+lbGQ9VwkLKP5nhUstCYCNyt
         0zHMVxTBbm/nq+mM6G/ZqrU4/3PwepoB3zcb6ses=
Message-ID: <1599515528.4232.55.camel@HansenPartnership.com>
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Greg KH <greg@kroah.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Date:   Mon, 07 Sep 2020 14:52:08 -0700
In-Reply-To: <20200907132322.GB106839@linux.intel.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
         <20200907053824.GA279469@kroah.com>
         <20200907132322.GB106839@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-07 at 16:23 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 07, 2020 at 07:38:24AM +0200, Greg KH wrote:
> > Please just use a binary blob format.  Binary sysfs files are
> > exactly what this is for, you are just passing the data through the
> > kernel from the hardware to userspace.
> > 
> > You can have 24 binary files if that makes it easier, but the
> > existing format really is an abuse of sysfs.

There is no existing format for TPM 2.0 ... that's part of the problem
since we certainly didn't want to carry over the TPM 1.2 format.

I've got to say I think binary attributes are actively evil.  I can see
they're a necessity when there's no good way to represent the data they
contain, like the bios measurement log or firmware code or a raw
interface like we do for the SMP frame code in libsas.  But when
there's a well understood and easy to produce user friendly non-binary
representation, I think dumping binary is inimical to being a good API.


> > Or use securityfs, that's fine too, but as you say, you have to
> > write more code for that.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I suggested this in previous round: to have a single 'pcrs' binary
> file with <TPM Alg ID, blob> pairs contained.

There's no current use case today that wants all values.  Every current
use case wants either a single PCR or a selection mostly from a single
bank, so forcing every current user to dig out the values they want 
from a binary blob rather than being able to gather them simply also
seems to be an API that makes users' lives harder than they need to be.

James

