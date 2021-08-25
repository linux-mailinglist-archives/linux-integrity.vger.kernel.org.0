Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554943F7E5D
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 00:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhHYWWa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 18:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233175AbhHYWWZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 18:22:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9724D6109E;
        Wed, 25 Aug 2021 22:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629930099;
        bh=+94ZPV6l/lR/Jo9QrFwrpNqPiVP3tOXGykvHMlJACWQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CCwJRq6ecg7oNO3eI3FVt1altR2AenjzXZskobYFbRFo0reqMnGJSPBWMLDzr9nL2
         jkQuJnCn+4QdoAAOhqteykXy5cVM30tCRaBLv2dObdmy2fSdTa2xRVC1IkqqkUGuiZ
         W5a562m+JkP3XkZ2BzSZ3IDPKozD3jbfBoTb+xE/P76xAY0YyolYT/1kPTOkqKYZCW
         ZWaTnAYs6zo9/Yz2nBU44d7ptkqsV1iNUPTR2pWe/elybM+QrTGP6mJ8RYSsR1r0F+
         Y3h8VyGpDS3XmMzip7oajdGZL7CvOwZdT7IY0Wzqy6UPAFqUxhFhzSyodEB+jtytz6
         B/NxC60ok/z3A==
Message-ID: <9067ff7142d097698b827f3c1630a751898a76bf.camel@kernel.org>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, Nayna <nayna@linux.vnet.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Thu, 26 Aug 2021 01:21:36 +0300
In-Reply-To: <9526a4e0be9579a9e52064dd590a78c6496ee025.camel@linux.ibm.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
         <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
         <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
         <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
         <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
         <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
         <9526a4e0be9579a9e52064dd590a78c6496ee025.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-08-24 at 10:34 -0400, Mimi Zohar wrote:
> > > > Jarkko, I think the emphasis should not be on "machine" from Machin=
e
> > > > Owner Key (MOK), but on "owner".  Whereas Nayna is focusing more on=
 the
> > > > "_ca" aspect of the name.   Perhaps consider naming it
> > > > "system_owner_ca" or something along those lines.
> > > What do you gain such overly long identifier? Makes no sense. What
> > > is "ca aspect of the name" anyway?
> >=20
> > As I mentioned previously, the main usage of this new keyring is that i=
t=20
> > should contain only CA keys which can be later used to vouch for user=
=20
> > keys loaded onto secondary or IMA keyring at runtime. Having ca in the=
=20
> > name like .xxxx_ca, would make the keyring name self-describing. Since=
=20
> > you preferred .system, we can call it .system_ca.
>=20
> Sounds good to me.  Jarkko?
>=20
> thanks,
>=20
> Mimi

I just wonder what you exactly gain with "_ca"?

/Jarkko
