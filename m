Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9477A370091
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Apr 2021 20:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhD3SeG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Apr 2021 14:34:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43632 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhD3SeA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Apr 2021 14:34:00 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 69D7172C8B0;
        Fri, 30 Apr 2021 21:33:09 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id F24114A46E8;
        Fri, 30 Apr 2021 21:33:08 +0300 (MSK)
Date:   Fri, 30 Apr 2021 21:33:08 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: calc_keyid_v2 producing different keyid for non-sha1 SKIDs
Message-ID: <20210430183308.mfdffqq2osbrqm5e@altlinux.org>
References: <20210426193723.rfar32ft3iptorii@altlinux.org>
 <738bff9b-5cde-4f06-3e54-4d6eebcf9383@linux.ibm.com>
 <20210426220148.nqncx5734dfj5qyx@altlinux.org>
 <20210426221433.mqrtmkpw6fletgmh@altlinux.org>
 <d563ee36-8aad-0497-dc12-f4b06f7f0f6f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <d563ee36-8aad-0497-dc12-f4b06f7f0f6f@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Fri, Apr 30, 2021 at 01:19:02PM -0400, Stefan Berger wrote:
> 
> On 4/26/21 6:14 PM, Vitaly Chikunov wrote:
> > On Tue, Apr 27, 2021 at 01:01:48AM +0300, Vitaly Chikunov wrote:
> > > Stefan,
> > > 
> > > https://tools.ietf.org/html/rfc7093
> > > 
> > > On Mon, Apr 26, 2021 at 04:21:26PM -0400, Stefan Berger wrote:
> > > > On 4/26/21 3:37 PM, Vitaly Chikunov wrote:
> > > > > Hi,
> > > > > 
> > > > > I am reported that IMA signatures where SKID is not just sha1 of the
> > > > > public key (but something different, for example different hash algo,
> > > > > such as Streebog) have "wrong" keyid in the signature. This is because
> > > > > a) kernel extracting keyid from the cert's subjectKeyIdentifier (SKID)
> > > > > x509 extension, (or if this fails it takes just serial, perhaps, we can
> > > > > disregard this corner case), it never does sha1 over the public key).
> > > > 
> > > > Is it wrong for ecrdsa keys? What is the spec?
> > > It seems, some CA provide by default certs with Streebog-256 hash as
> > > drop-in replacement for SHA1, so their users forced to (re-)request the
> > > certs with a compatible SHA1 SKID.
> > > 
> > > > Here's the spec that describes using sha1 for the skid which seems to work
> > > > like this for RSA and ECDSA keys from what I can tell:
> > > > 
> > > > https://tools.ietf.org/html/rfc3280#section-4.2.1.2
> > > Perhaps, you meant https://tools.ietf.org/html/rfc5280#section-4.2.1.2
> > > 
> > >    "Other methods of generating unique numbers are also acceptable."
> > > 
> > > Also, see https://tools.ietf.org/html/rfc7093
> > And, I think all v2 signatures potentially affected.
> 
> I have been using evmctl successfully with RSA and ECDSA keys now and
> certificates created by **OpenSSL**. Problems may occur if the
> certificate-generating tool uses something else than a sha1 to calculate the
> subject key identifier (skid) and therefore the key id calculated by evmctl
> (with a sha1) does not match. For the non-working case one could pass in a
> keyidv2 that the user would have to determine from the certificate's subject
> key identifier's last 4 bytes.
> 
> It would be interesting to know which tools do not use a sha1 to calculate
> the subject key identifier or what types of keys those are so that one could
> give recommendations for tools to use. GnuTLS's certtool for example does
> not seem to use the same algorithm to calculate the skid, so I would not
> recommend using it for generating the certs to be used in conjunction with
> evmctl and IMA signatures.

You can also reproduce non-sha1 skid with openssl using subjectKeyIdentifier=
config option, see x509v3_config(5).

Thanks,

