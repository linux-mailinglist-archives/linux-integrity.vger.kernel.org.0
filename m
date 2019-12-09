Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9B117169
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfLIQVQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 11:21:16 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57616 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbfLIQVP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 11:21:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AD5D18EE112;
        Mon,  9 Dec 2019 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575908474;
        bh=pEd23BDhE4vCVbvG+LCWrEmayf8E0QTxqI+P1J0CQJ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IpxyeZa+0hvSDdJtWNQKZhwieTDYDzWHAiqCp+E0VZmuEqPz/fRNAX/qJDG9LuefZ
         Mqhc7mWP5/vYdcbXMw9QrOFEx3ArMe9NP4GDJwGJAim2/+pGveIPgqnvQIuY/xPnkL
         k/4TvZ/03Qz0qqZPBHQS3Okt+Rk0TBIgnpWqIxxg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zxUIIa5E1oyW; Mon,  9 Dec 2019 08:21:14 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 395A88EE0FC;
        Mon,  9 Dec 2019 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575908474;
        bh=pEd23BDhE4vCVbvG+LCWrEmayf8E0QTxqI+P1J0CQJ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IpxyeZa+0hvSDdJtWNQKZhwieTDYDzWHAiqCp+E0VZmuEqPz/fRNAX/qJDG9LuefZ
         Mqhc7mWP5/vYdcbXMw9QrOFEx3ArMe9NP4GDJwGJAim2/+pGveIPgqnvQIuY/xPnkL
         k/4TvZ/03Qz0qqZPBHQS3Okt+Rk0TBIgnpWqIxxg=
Message-ID: <1575908473.3340.17.camel@HansenPartnership.com>
Subject: Re: [PATCH 3/8] oid_registry: Add TCG defined OIDS for TPM keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org, monty.wiseman@ge.com
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 08:21:13 -0800
In-Reply-To: <194d8ba601b9ecb43e812445729c6270e9f32162.camel@infradead.org>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781746.14069.11.camel@HansenPartnership.com>
         <194d8ba601b9ecb43e812445729c6270e9f32162.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 08:55 +0000, David Woodhouse wrote:
> On Sat, 2019-12-07 at 21:09 -0800, James Bottomley wrote:
> > The TCG has defined an OID prefix "2.23.133.10.1" for the various
> > TPM
> > key uses.  We've defined three of the available numbers:
> > 
> > 2.23.133.10.1.3 TPM Loadable key.  This is an asymmetric key
> > (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Load() operation.
> > 
> > 2.23.133.10.1.4 TPM Importable Key.  This is an asymmetric key
> > (Usually
> > 		RSA2048 or Elliptic Curve) which can be imported by a
> > 		TPM2_Import() operation.
> > 
> > Both loadable and importable keys are specific to a given TPM, the
> > difference is that a loadable key is wrapped with the symmetric
> > secret, so must have been created by the TPM itself.  An importable
> > key is wrapped with a DH shared secret, and may be created without
> > access to the TPM provided you know the public part of the parent
> > key.
> > 
> > 2.23.133.10.1.5 TPM Sealed Data.  This is a set of data (up to 128
> > 		bytes) which is sealed by the TPM.  It usually
> > 		represents a symmetric key and must be unsealed before
> > 		use.
> 
> Do we still not have an official reference for these that you can
> provide in the commit or the file itself?
> 
> It would be very nice to have something more than a verbal assurance
> that they're in Monty's spreadsheet.

Well, I've asked Monty several times ... he seems to think it's enough
that it's in his spreadsheet.  I assume at some point the TCG will get
around to publishing it when they identify a document to do it with but
until then we have to take Monty's word.

James

