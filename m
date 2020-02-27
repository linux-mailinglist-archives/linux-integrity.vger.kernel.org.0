Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB0F172326
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 17:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgB0QVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 11:21:48 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46820 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729856AbgB0QVs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 11:21:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D1EBE8EE181;
        Thu, 27 Feb 2020 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582820507;
        bh=DEC6D3c+XzaY2vmgky+CH/RlcOWdux9P6+Rv8E5By4M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LQWzBd8J4oaclLIga36Asb1W9wF8lSjALahe+iuBayNUTO4Y8DDIJCvQE2jBSXbze
         Bsks4p9pH0YZMFpB/r5hlQFItu3WtOGgV+wX4VVncOAkogpMeWR+v8Wfgzhca8NUTc
         ixkyQx7/EDqiuNdz0Lf/3FLhCDv2aQSPE7IKyaKQ=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X35b6physd5r; Thu, 27 Feb 2020 08:21:47 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4D61E8EE079;
        Thu, 27 Feb 2020 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582820507;
        bh=DEC6D3c+XzaY2vmgky+CH/RlcOWdux9P6+Rv8E5By4M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LQWzBd8J4oaclLIga36Asb1W9wF8lSjALahe+iuBayNUTO4Y8DDIJCvQE2jBSXbze
         Bsks4p9pH0YZMFpB/r5hlQFItu3WtOGgV+wX4VVncOAkogpMeWR+v8Wfgzhca8NUTc
         ixkyQx7/EDqiuNdz0Lf/3FLhCDv2aQSPE7IKyaKQ=
Message-ID: <1582820506.18445.3.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 3/6] security: keys: trusted fix tpm2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Thu, 27 Feb 2020 08:21:46 -0800
In-Reply-To: <20200227161949.GD5140@linux.intel.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
         <20200225164850.GB15662@linux.intel.com>
         <1582765091.4245.33.camel@HansenPartnership.com>
         <20200227161949.GD5140@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-02-27 at 18:19 +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 26, 2020 at 04:58:11PM -0800, James Bottomley wrote:
> > On Tue, 2020-02-25 at 18:48 +0200, Jarkko Sakkinen wrote:
> > > On Thu, Jan 30, 2020 at 11:18:09AM +0100, James Bottomley wrote:
> > > > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > > > actually recommended you to hash variable length passwords and
> > > > use
> > > > the sha1 hash as the authorization.  Because the spec doesn't
> > > > require this hashing, the current authorization for trusted
> > > > keys is
> > > > a 40 digit hex number.  For TPM 2.0 the spec allows the passing
> > > > in
> > > > of variable length passwords and passphrases directly, so we
> > > > should
> > > > allow that in trusted keys for ease of use.  Update the
> > > > 'blobauth'
> > > > parameter to take this into account, so we can now use plain
> > > > text
> > > > passwords for the keys.
> > > > 
> > > > so before
> > > > 
> > > > keyctl add trusted kmk "new 32
> > > > blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> > > > 
> > > > after we will accept both the old hex sha1 form as well as a
> > > > new
> > > > directly supplied password:
> > > > 
> > > > keyctl add trusted kmk "new 32 blobauth=hello
> > > > keyhandle=81000001"
> > > > 
> > > > Since a sha1 hex code must be exactly 40 bytes long and a
> > > > direct
> > > > password must be 20 or less, we use the length as the
> > > > discriminator
> > > > for which form is input.
> > > > 
> > > > Note this is both and enhancement and a potential bug fix.  The
> > > > TPM
> > > > 2.0 spec requires us to strip leading zeros, meaning empyty
> > > > authorization is a zero length HMAC whereas we're currently
> > > > passing
> > > > in
> > > > 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but
> > > > the
> > > > Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this
> > > > patch
> > > > makes the Microsoft TPM emulator work with trusted keys.
> > > > 
> > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnersh
> > > > ip.c
> > > > om>
> > > 
> > > Should have a fixes tag.
> > 
> > I made all the other changes, but I'm not sure what to identify in
> > the
> > fixes tag.  The problem is the code I updated was simply carried
> > over
> > unaltered from TPM 1.2
> > 
> > You could certainly argue that commit
> > 
> > commit 0fe5480303a1657b328a0a389f8d99249d9961f5
> > Author: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Date:   Fri Jun 26 22:28:26 2015 +0300
> > 
> >     keys, trusted: seal/unseal with TPM 2.0 chips
> > 
> > Should have updated the blobauth handling ... is that the one you'd
> > like fixes: to identify?
> 
> What I'm thinking is to have fixes tag w/o cc to stable. I'm not
> sure at this point whether we want to backport this but it still
> makes sense to tag it.

Ok, I'll add that commit as the fixes; it certainly makes no sense to
backport this change before the above commit.

James

