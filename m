Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A410759A
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Nov 2019 17:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfKVQRe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Nov 2019 11:17:34 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43082 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbfKVQRe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Nov 2019 11:17:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BE8FB8EE10C;
        Fri, 22 Nov 2019 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574439453;
        bh=otZW77J4RwO9Ohl4xdm1AS4szGKRNMz46tmb2QQekqw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XVTSalygzBrAiz8YpOrVsqKn+7EZg9/PF9kh3HFwRcU1txpmZAos2XUHXhxxkYLxo
         82krYu7MHCkeDZW4vIF1TD+02Z93OO4LKYI8mDN69rChl+Irniuqv0Z1K8r+gl3PcO
         mDPb52efZS1v/6nLj8k56Wg8bBRZR4JV/hOQIj/0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GIA3o6RxIjXY; Fri, 22 Nov 2019 08:17:33 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3F7058EE0EF;
        Fri, 22 Nov 2019 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1574439453;
        bh=otZW77J4RwO9Ohl4xdm1AS4szGKRNMz46tmb2QQekqw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XVTSalygzBrAiz8YpOrVsqKn+7EZg9/PF9kh3HFwRcU1txpmZAos2XUHXhxxkYLxo
         82krYu7MHCkeDZW4vIF1TD+02Z93OO4LKYI8mDN69rChl+Irniuqv0Z1K8r+gl3PcO
         mDPb52efZS1v/6nLj8k56Wg8bBRZR4JV/hOQIj/0=
Message-ID: <1574439451.3331.14.camel@HansenPartnership.com>
Subject: Re: IMA: Data included in the key measurement
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, dhowells@redhat.com
Cc:     James Morris <jamorris@linuxonhyperv.com>
Date:   Fri, 22 Nov 2019 08:17:31 -0800
In-Reply-To: <b4257d08-f6cf-19a0-f6f0-99c962ededac@linux.microsoft.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
         <1574354333.3277.27.camel@HansenPartnership.com>
         <b4257d08-f6cf-19a0-f6f0-99c962ededac@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-11-21 at 17:15 -0800, Lakshmi Ramasubramanian wrote:
> On 11/21/19 8:38 AM, James Bottomley wrote:
> 
> Hi James,
> 
> > You're making the assumption that the public key and the
> > certificate are isomorphic.  That's only true if you trust the
> > issuer (which you obviously do, since it's you [microsoft]) but
> > nothing in X.509 prevents the issuer from issuing multiple
> > certificates with the same public key and different
> > properties.  Even in your use case, I would think
> > attesting to whether the certificate had expired or not would be
> > useful.
> 
> I agree attesting the x509 certificate and not just the public key
> is the right approach. But in the kernel the certificate is not
> stored - only the key extracted from the certificate is stored
> (please correct me  if I am wrong).

It depends what you mean by "store".  The built in certificates are
available in the system_certificate_list array; IMA tends to expect
public keys as X.509 certificates.  In the actual keyring key, we get
the subject + serial/skid, the subtype the keyids and the signature. 
It does seem we don't set the key expiry to the expiry date of the
cert, though.  And before loading we do verify the key chain (depending
on how we were loaded).

> When IMA, for instance, verifies the file signature only the public
> key (the data in "struct public_key") of the corresponding IMA key is
> used - the certificate is not used.

Once you've performed the certificate verification, we only need
certain parameters for signature verification, so we store them. 
However, what we verify depends on the signature algorithm. For pkcs1,
obviously we can only check the signature and nothing else, so the cert
and the public key become isomorphic here.  For pkcs7, which is what
IMA mostly uses, we do check some of the parameters.

> In my key measurement implementation, IMA hook is called when 
> key_create_or_update() function has successfully added\updated a key
> in a keyring. At that point, I do not have the corresponding x509
> certificate.

It sounds like you might be hooking into the wrong place ... we
definitely pass in the whole certificate for public key load.

> Please let me know if the kernel indeed stores the x509 certificate
> also and it can be queried when the corresponding key is added to a
> keyring. I'll make the changes to measure the x509 cert instead of
> just the public key.

If you measure at time of insertion you should be able to measure the
entire key because it's inserted as a complete certificate.  If there's
additional data you need to retrieve after the load, we might be able
to store it in addition to the data we already save from the
certificate.

James

