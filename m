Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FD9B6787
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfIRPxi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 11:53:38 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:54672 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728516AbfIRPxi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 11:53:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3D47B8EE112;
        Wed, 18 Sep 2019 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568821993;
        bh=cb9hrLxfhvv4lSkk3l2G4AqKkWX4ggn+YW1ecx5TFnA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OBmKkyqO+2xGTnuP+G+qpbCaeNxBg4AHEZiGVPP7SA8S2e25SNGp1rGvVsPB0boh5
         3VvNee1/NiIXJv8h9kOO4iVtO/x+oYp+MSRj0keljtyJn+18FWxLiVatuA/98Nc1Q9
         086YVxvjXu81bsE8SxBSZYJlG8uA8+F4euNA4beg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3eL3jIvV9DYC; Wed, 18 Sep 2019 08:52:49 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0BFF58EE10C;
        Wed, 18 Sep 2019 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1568821968;
        bh=cb9hrLxfhvv4lSkk3l2G4AqKkWX4ggn+YW1ecx5TFnA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MoyDL1Ko8LSEjygVAdrcFtRZUMi0bKy3Rmy7nVTK+icKf7e7GoDAUEJcH8iOGQ6o+
         Ik10aXTGS5qPp0zqU9icDaWzkrhWwLo2Iyb/wZt7MwrsWmA7TG+5Qbb3XczkYkhsRF
         UhQqRKimBqYMWLo4kqlLECQf3O81wFzTctvtt4Kg=
Message-ID: <1568821962.5817.17.camel@HansenPartnership.com>
Subject: Re: IMA on remote file systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed, 18 Sep 2019 08:52:42 -0700
In-Reply-To: <CAE=NcrZySAMJZe8Y9AfF2T3zoZqDe_HC4e7kD6eOkZMGBmSMOQ@mail.gmail.com>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
         <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
         <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
         <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
         <20190917124533.GD6762@mit.edu>
         <1568732169.11799.18.camel@HansenPartnership.com>
         <CAE=NcrZySAMJZe8Y9AfF2T3zoZqDe_HC4e7kD6eOkZMGBmSMOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-09-18 at 08:27 +0300, Janne Karhunen wrote:
> On Tue, Sep 17, 2019 at 5:57 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> 
> > with.  The biggest problem with fs-verity has been where to store
> > the merkel tree.  However, what I've heard from IMA people is as
> > long as the merkle tree storage problem gets solved satisfactorily,
> > they're perfectly happy to have per page hash verification be an
> > IMA mechanism because it's a simple extension of policy and an
> > addition of a gate.
> 
> The way I see this is that the greatest asset to protect on any
> device is the user data. The data security comes first, then the
> device security as a mechanism to protect that same data. You could
> even say that the device security is worthless when the device is
> empty. The user data is almost always mutable by nature. So, would be
> really great if the fs-verity metadata storage would take it into a
> consideration that one day someone will want to use it for the
> mutable data as well, even if Google does not want at this point in
> time. Things like photos, videos are ideal use cases for the verity
> like Ted pointed out.

Mutability for integrity checked executables/data is problematic.  With
IMA you have to update the file and the xattr and make sure nothing
touches it before you've completed all the updates otherwise you get an
integrity check failure.  This can work if your mutation is simply a
distro update, but it's really hard to do if the file is constantly
undergoing mutation because the window where the integrity check fails
is huge ... thus it depends on your use case for mutability.

James

> Heck, doubt we would even have the conspiracy over the moon landings
> anymore if the photos were taken with a device that could reliably
> identify the device, the device user, location and the time when the
> photos were taken ;)
> 
> 
> --
> Janne
> 

