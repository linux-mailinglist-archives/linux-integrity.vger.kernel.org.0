Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A84105734
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 17:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUQi4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Nov 2019 11:38:56 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50238 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUQi4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Nov 2019 11:38:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 213398EE10C;
        Thu, 21 Nov 2019 08:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574354336;
        bh=m2ReIpgtkgiiQEYdwEvLpxKdZkbjGMoHgOFzh25mBGk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K19bbRF628UpsgHt1d4lu9UmSogsIROFvWbFDbDlgB/gAmMj+ZwIZFfA5+Aue6uRs
         mNPcDqM6gqzEHasfV0FeJjr/XPxu2dcgm3lPRsVPT8p3GP/JLVAyviJvq6I/b4Hl03
         6rqidOKu7BVBog2geGU/gtzQ/Vqvn15vvzuEMbqg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1LAc36HU3HnR; Thu, 21 Nov 2019 08:38:55 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A2AE78EE0D2;
        Thu, 21 Nov 2019 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574354335;
        bh=m2ReIpgtkgiiQEYdwEvLpxKdZkbjGMoHgOFzh25mBGk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=vyAqeDl2367dxJCFw7QNVMT5SrK5xqwP6xRAlf4B43WinJqI8kbzJvejvAwaePEHA
         0+V9j1ZWjPgP54JjqZ7V99HhpSwscEBFNt7ffu0rIxepbQNawz8tZyHP9OSxxaofcw
         4uk7M6m5zGwidv1OOjAMRk53ypPL638LB8kCt4vo=
Message-ID: <1574354333.3277.27.camel@HansenPartnership.com>
Subject: Re: IMA: Data included in the key measurement
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     James Morris <jamorris@linuxonhyperv.com>
Date:   Thu, 21 Nov 2019 08:38:53 -0800
In-Reply-To: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-11-21 at 08:17 -0800, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
>  >>> everything needed for verifying a signature is included in
>  >>> the key measurement.
> 
> Regarding the requirement you had stated above, I would like some 
> clarification.
> 
> When I started this change to measure keys through IMA, the use case
> we had in mind was enabling an attestation service, for instance, to
> verify if the client has only known good (trusted) keys - for
> example, in keyrings such as ".builtin_trusted_keys", ".ima", etc.
> 
> On the client IMA verifies the signature of system binaries using
> keys in the IMA keyring. And, if the config namely 
> CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is
> enabled, only keys signed by a built-in trusted key can be added to
> the IMA keyring.
> 
> An attestation service can keep a list of public keys of "known good 
> (trusted)" keys for various keyrings, and verify against the
> measurement data provided by the client.
> 
> To achieve the above we decided to include only the public key in
> the key measurement buffer.
> 
> I would like to know what benefit we'd get by including "everything 
> needed for verifying a signature in the key measurement"?  X.509
> itself doesn't buy this isomorphism property, which is why the
> subject key id 
> 
>  From testing point of view, if we have the certificate (like the
> .DER file), we can validate the key measurement data in the IMA log.
> 
> Do you see a need to include more data or the entire cert for the 
> product code?

You're making the assumption that the public key and the certificate
are isomorphic.  That's only true if you trust the issuer (which you
obviously do, since it's you [microsoft]) but nothing in X.509 prevents
the issuer from issuing multiple certificates with the same public key
and different properties.  Even in your use case, I would think
attesting to whether the certificate had expired or not would be
useful.

James

