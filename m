Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729C43FD286
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Sep 2021 06:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbhIAEr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Sep 2021 00:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241684AbhIAErz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Sep 2021 00:47:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3427661008;
        Wed,  1 Sep 2021 04:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630471619;
        bh=6mPcbqd3sra2Eh4c8H6A89Ite2nAKh2TgjuRTl49Vag=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NT7M1T+hYKngyLYyi2TW+0++hwLLmqhfDEvn+yIbz2aCCdq0StaqWYvrr5SXGFBTU
         DGqxGNvEibsvCSmdzTAcMcbTN362OQyHIyskhn0PAcTsOXxaf0tqyETk1EGECIwfgU
         AFvklTNxr3diXlr0wwTvLE2r711mtWFwq2RKghfa2i9IvKcBqtEZmKHPAgvbVBPSSQ
         hcSe6HTLgYhVSBNlCy+reE5zD8S2jliInHVWot6SDM291iiCZD0zZYd+e/Avv9dyNV
         T1SothX5F9wxNowWTRw9fpN1ZIr+tHL62OEUQ9M6JL8AgTFyrg1XOEwjrzOxIf6vJM
         dsDRo8VU2XEVQ==
Message-ID: <809185b33150a7d25da6b11323af3d8dbe549836.camel@kernel.org>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna <nayna@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        linux-security-module@vger.kernel.org, pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Date:   Wed, 01 Sep 2021 07:46:57 +0300
In-Reply-To: <e2c7eaceed715a92887b3d5aeafad01e047b6fab.camel@kernel.org>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
         <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
         <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
         <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
         <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
         <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
         <9526a4e0be9579a9e52064dd590a78c6496ee025.camel@linux.ibm.com>
         <9067ff7142d097698b827f3c1630a751898a76bf.camel@kernel.org>
         <bc37d1da3ef5aae16e69eeda25d6ce6fe6a51a77.camel@HansenPartnership.com>
         <10bc1017-2b45-43f3-ad91-d09310b24c2c@linux.vnet.ibm.com>
         <18c0a9ca6b3ab8103e3b9270a6f59539787f6e12.camel@kernel.org>
         <e2c7eaceed715a92887b3d5aeafad01e047b6fab.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-01 at 07:36 +0300, Jarkko Sakkinen wrote:
> On Wed, 2021-09-01 at 07:34 +0300, Jarkko Sakkinen wrote:
> > On Fri, 2021-08-27 at 16:44 -0400, Nayna wrote:
> > > On 8/25/21 6:27 PM, James Bottomley wrote:
> > > > On Thu, 2021-08-26 at 01:21 +0300, Jarkko Sakkinen wrote:
> > > > > On Tue, 2021-08-24 at 10:34 -0400, Mimi Zohar wrote:
> > > > > > > > > Jarkko, I think the emphasis should not be on "machine" f=
rom
> > > > > > > > > Machine Owner Key (MOK), but on "owner".  Whereas Nayna i=
s
> > > > > > > > > focusing more on the "_ca" aspect of the name.   Perhaps
> > > > > > > > > consider naming it "system_owner_ca" or something along t=
hose
> > > > > > > > > lines.
> > > > > > > > What do you gain such overly long identifier? Makes no sens=
e.
> > > > > > > > What is "ca aspect of the name" anyway?
> > > > > > > As I mentioned previously, the main usage of this new keyring=
 is
> > > > > > > that it should contain only CA keys which can be later used t=
o
> > > > > > > vouch for user keys loaded onto secondary or IMA keyring at
> > > > > > > runtime. Having ca in the  name like .xxxx_ca, would make the
> > > > > > > keyring name self-describing. Since you preferred .system, we=
 can
> > > > > > > call it .system_ca.
> > > > > > Sounds good to me.  Jarkko?
> > > > > >=20
> > > > > > thanks,
> > > > > >=20
> > > > > > Mimi
> > > > > I just wonder what you exactly gain with "_ca"?
> > > > Remember, a CA cert is a self signed cert with the CA:TRUE basic
> > > > constraint.  Pretty much no secure boot key satisfies this (secure =
boot
> > > > chose deliberately NOT to use CA certificates, so they're all some =
type
> > > > of intermediate or leaf), so the design seems to be only to pick ou=
t
> > > > the CA certificates you put in the MOK keyring.  Adding the _ca suf=
fix
> > > > may deflect some of the "why aren't all my MOK certificates in the
> > > > keyring" emails ...
> > >=20
> > > My understanding is the .system_ca keyring should not be restricted o=
nly=20
> > > to self-signed CAs (Root CA). Any cert that can qualify as Root or=
=20
> > > Intermediate CA with Basic Constraints CA:TRUE should be allowed. In=
=20
> > > fact, the intermediate CA certificates closest to the leaf nodes woul=
d=20
> > > be best.
> > >=20
> > > Thanks for bringing up that adding the _ca suffix may deflect some of=
=20
> > > the "why aren't all my MOK certificates in the keyring" emails.
> >=20
> > What the heck is the pragamatic gain of adding such a suffix? Makes
> > zero sense
>=20
> If this series needs both "system" and "system_ca" keyrings, then
> there would be some sanity in this.
>=20
> Also, I still *fully* lack understanding of the use of word system.
>=20
> Why MOK is not SOK then??

Please just call it "machine". You have machines that hold the keyring.

"system" does not mean anything concrete. I don't know what a "system"
is.

/Jarkko
