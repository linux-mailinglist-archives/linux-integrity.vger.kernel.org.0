Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF036BB83
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Apr 2021 00:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhDZWPU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 18:15:20 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:55254 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhDZWPT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 18:15:19 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C882C72C8B0;
        Tue, 27 Apr 2021 01:14:33 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8FBCF4A47A2;
        Tue, 27 Apr 2021 01:14:33 +0300 (MSK)
Date:   Tue, 27 Apr 2021 01:14:33 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: calc_keyid_v2 producing different keyid for non-sha1 SKIDs
Message-ID: <20210426221433.mqrtmkpw6fletgmh@altlinux.org>
References: <20210426193723.rfar32ft3iptorii@altlinux.org>
 <738bff9b-5cde-4f06-3e54-4d6eebcf9383@linux.ibm.com>
 <20210426220148.nqncx5734dfj5qyx@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210426220148.nqncx5734dfj5qyx@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 27, 2021 at 01:01:48AM +0300, Vitaly Chikunov wrote:
> Stefan,
> 
> https://tools.ietf.org/html/rfc7093
> 
> On Mon, Apr 26, 2021 at 04:21:26PM -0400, Stefan Berger wrote:
> > 
> > On 4/26/21 3:37 PM, Vitaly Chikunov wrote:
> > > Hi,
> > > 
> > > I am reported that IMA signatures where SKID is not just sha1 of the
> > > public key (but something different, for example different hash algo,
> > > such as Streebog) have "wrong" keyid in the signature. This is because
> > > a) kernel extracting keyid from the cert's subjectKeyIdentifier (SKID)
> > > x509 extension, (or if this fails it takes just serial, perhaps, we can
> > > disregard this corner case), it never does sha1 over the public key).
> > 
> > 
> > Is it wrong for ecrdsa keys? What is the spec?
> 
> It seems, some CA provide by default certs with Streebog-256 hash as
> drop-in replacement for SHA1, so their users forced to (re-)request the
> certs with a compatible SHA1 SKID.
> 
> > Here's the spec that describes using sha1 for the skid which seems to work
> > like this for RSA and ECDSA keys from what I can tell:
> > 
> > https://tools.ietf.org/html/rfc3280#section-4.2.1.2
> 
> Perhaps, you meant https://tools.ietf.org/html/rfc5280#section-4.2.1.2
> 
>   "Other methods of generating unique numbers are also acceptable."
> 
> Also, see https://tools.ietf.org/html/rfc7093

And, I think all v2 signatures potentially affected.

> > > But, b) evmctl, when signing, uses just private key (not even knowing
> > > certificate where SKID should be) and calculating sha1 of public key.
> > > Thus, keyids could mismatch each other, and it's even not easy to fix
> > > evmctl, because there is no cert at the time of signing.
> > > 
> > > Perhaps, we should fix this somehow. For example, when signing,
> > > introduce new option --cert, where SKID should be extracted. Does it
> > > looks reasonable?

Additionally, we could add `--keyid' option, so users could manually set
keyid without extracting it from the cert file.

> > > 
> > > Vitaly,
> > > 
> > > 
> > > 
