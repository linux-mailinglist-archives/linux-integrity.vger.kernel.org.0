Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E14B638B
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfIRMvF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 08:51:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35787 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727435AbfIRMvF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 08:51:05 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8ICorbe014044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 08:50:54 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C258B420811; Wed, 18 Sep 2019 08:50:52 -0400 (EDT)
Date:   Wed, 18 Sep 2019 08:50:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: IMA on remote file systems
Message-ID: <20190918125052.GK6762@mit.edu>
References: <C867A0BA-1ACF-4600-8179-3E15A098846C@oracle.com>
 <CAE=Ncrb=rh0LeDjnGYGuGJVPXG3Y1UpjD5Tw41s0zyOAaL1NKg@mail.gmail.com>
 <1BF68F78-FA8E-4633-9AB4-AB6E0B10DCB8@oracle.com>
 <CAE=NcrYjzdBCB7aK6bL+C+W8N-QJyuPF0RvFqCmsK_S90oyvxg@mail.gmail.com>
 <20190917124533.GD6762@mit.edu>
 <1568732169.11799.18.camel@HansenPartnership.com>
 <CAE=NcrZySAMJZe8Y9AfF2T3zoZqDe_HC4e7kD6eOkZMGBmSMOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=NcrZySAMJZe8Y9AfF2T3zoZqDe_HC4e7kD6eOkZMGBmSMOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Sep 18, 2019 at 08:27:57AM +0300, Janne Karhunen wrote:
> 
> The way I see this is that the greatest asset to protect on any device
> is the user data. The data security comes first, then the device
> security as a mechanism to protect that same data. You could even say
> that the device security is worthless when the device is empty. The
> user data is almost always mutable by nature. So, would be really
> great if the fs-verity metadata storage would take it into a
> consideration that one day someone will want to use it for the mutable
> data as well, even if Google does not want at this point in time.
> Things like photos, videos are ideal use cases for the verity like Ted
> pointed out.

Writable data is tricky, and has several problems.  The first is
performance; the block which gets modified and the cryptographic
checksum has to be updated atomically; and if you use a Merkle tree,
you have to update multiple blocks in the Merkle tree atomically.  The
journalling necessary to address this is really tricky.

The other problem is if you want to update authenticated checksums
while blocks are being updated, this raises the question about how do
you secure the key used to sign the checksums?  For read-only data,
the private signing key can be stored off the device.  For example, it
can be stored on an off-line build server for a Red Hat package.  Or
Google can store the signing key for APK's on a secure server inside
their data centers before the package is made available on Google Play
Download servers.

For mutable data, the signing key needs to be stored on the mobile
device --- so the value is significantly decreased.  After all, if a
malicious attacker can take over the phone in order to modify a photo,
the malicious attacker can also steal the signing key off the mobile
device and then modify the photo.

There are solutions for these problems.  For example, one could use a
storage device with 4128 byte sectors, with an inline encryption
engine (ICE) which uses AES-GCM (an Authenticated Encryption with
Associated Data mode), with the key stored in a secure enclave and
where the host OS authenticates to the secure enclave, and then the
secure enclave delivers the key to the ICE without the key ever
touching the general purpose CPU.  But in general, they all require a
lot of custom hardware.  And I'm not making any comments about any
future product features in Android, but it's safe to say that security
architects have been talking about such designs for quite some time.
The challenge has always been balancing the cost / benefit tradeoffs,
and whether customers are willing to pay what it costs, either in $$$
or performance, to get that level of security.

Cheers,

						- Ted
