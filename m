Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB4B5AE4
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 07:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfIRF2M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 01:28:12 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37038 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfIRF2L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 01:28:11 -0400
Received: by mail-lj1-f173.google.com with SMTP id l21so4128883lje.4
        for <linux-integrity@vger.kernel.org>; Tue, 17 Sep 2019 22:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWE7VliChZOMeO1mHPKY1puDJixzJWd3884311ZvjYM=;
        b=HWak+G8YBt0D7+2i69fPVjg8vy5yylQLO5ePmoPr2mQeMOXnt2l28ib4ayWhOAhEnV
         ei6n4fJWO1k8M2OrYknX7i7o3xdCE7LZcb8d/IYg9ccDMgj3auwnb0Gx9ArzxFOZq1Xv
         ZWiLHmiIJuSmov5P6BBE2P3gd3c2X+VEL2lbPTaInh3j9ynGSuzn7n/2vdmCeanZV9/S
         FX+nt5RGTnkrIjZkDKkzgXeh+GRvgRZi2vQfsS1EVOZXvyLpYaoeL0v5NIYI3hKSAqFs
         IfSID3T74OIn+yC+fiWmLR0G4ikYECs/1LN/59jfHh86AAtbty4zWue7+JaAerK6DZeL
         PHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWE7VliChZOMeO1mHPKY1puDJixzJWd3884311ZvjYM=;
        b=RRVv14JHgnunEjc+W3KzrpK+Hfos0KRV/zCTaJmBpzlXdUgti4tXdM9TiRTGwBtb41
         eZXzqzIZPsrCblZxL/9WF3RjTwfSsNiPkzAY3NopwN5AX4NbXpBBzulV41IbkclMY9Jv
         VCKWuDKTL0gU8vzftilvo+xNQfAPbrPIiOg13kdUYwozjqx8XOIrUm//mJmTuxsAU1b2
         Ltwfm5wYQmux9h7ddHnT9xAPN8V0De5zSpbaaHlj83aGIdtRI/8WmONAmB6SiW9fIX6R
         PuqlYm7i8WBZCwM7zA6KgV3sN9jBnj0V1Rz34IV95ZPzNLhnepetqAjIVzRJ994MQSdZ
         NvPw==
X-Gm-Message-State: APjAAAXrDu74WZPZ+mxocuodeaJpvoh2BL1hk9jD4kgKcgzf/Bh5ChVU
        vrYAdQfGdZvqT6o51FbMDBU4P/Nchh9/eqHfsSk=
X-Google-Smtp-Source: APXvYqwd/kyLNIu9MtyipT0mv7fKGDzaOkriTNvgWjmN/MnoASbveFxc25vWTSAugRX4NIBy0IoOYa4rUPK2dSEgVRQ=
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr1028196lja.84.1568784488272;
 Tue, 17 Sep 2019 22:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
 <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com> <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
 <20190917124533.GD6762@mit.edu> <1568732169.11799.18.camel@HansenPartnership.com>
In-Reply-To: <1568732169.11799.18.camel@HansenPartnership.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Wed, 18 Sep 2019 08:27:57 +0300
Message-ID: <CAE=NcrZySAMJZe8Y9AfF2T3zoZqDe_HC4e7kD6eOkZMGBmSMOQ@mail.gmail.com>
Subject: Re: IMA on remote file systems
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 17, 2019 at 5:57 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> with.  The biggest problem with fs-verity has been where to store the
> merkel tree.  However, what I've heard from IMA people is as long as
> the merkle tree storage problem gets solved satisfactorily, they're
> perfectly happy to have per page hash verification be an IMA mechanism
> because it's a simple extension of policy and an addition of a gate.

The way I see this is that the greatest asset to protect on any device
is the user data. The data security comes first, then the device
security as a mechanism to protect that same data. You could even say
that the device security is worthless when the device is empty. The
user data is almost always mutable by nature. So, would be really
great if the fs-verity metadata storage would take it into a
consideration that one day someone will want to use it for the mutable
data as well, even if Google does not want at this point in time.
Things like photos, videos are ideal use cases for the verity like Ted
pointed out.

Heck, doubt we would even have the conspiracy over the moon landings
anymore if the photos were taken with a device that could reliably
identify the device, the device user, location and the time when the
photos were taken ;)


--
Janne
