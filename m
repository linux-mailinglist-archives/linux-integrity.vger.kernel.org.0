Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732C43F7E93
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 00:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhHYW2H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 18:28:07 -0400
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:33404 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231860AbhHYW2H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 18:28:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B4ADB128068E;
        Wed, 25 Aug 2021 15:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629930440;
        bh=oQYEQOogMz5Gfo91atBBq4LHIkEOCquaBh2axi4crBw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=K1i57TmkoGJRAi6MVpAWAAJXtz1y4xeEBhZkD3QJPv+Z0SOW9YUJ3RxDvKjmSTLhH
         M1DCAO8uV86YCgUtblcoBNW4O1oVzfiI4CsabxTSyRqmuC+pSNHnOyVojMVla8s/0/
         WQZAOf8q7Uk0RsESHO8ZWblwLLN4Zh+Ygj/si3VM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pF26J98Wob8H; Wed, 25 Aug 2021 15:27:20 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 58704128068C;
        Wed, 25 Aug 2021 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1629930440;
        bh=oQYEQOogMz5Gfo91atBBq4LHIkEOCquaBh2axi4crBw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=K1i57TmkoGJRAi6MVpAWAAJXtz1y4xeEBhZkD3QJPv+Z0SOW9YUJ3RxDvKjmSTLhH
         M1DCAO8uV86YCgUtblcoBNW4O1oVzfiI4CsabxTSyRqmuC+pSNHnOyVojMVla8s/0/
         WQZAOf8q7Uk0RsESHO8ZWblwLLN4Zh+Ygj/si3VM=
Message-ID: <bc37d1da3ef5aae16e69eeda25d6ce6fe6a51a77.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 00/12] Enroll kernel keys thru MOK
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
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
Date:   Wed, 25 Aug 2021 15:27:18 -0700
In-Reply-To: <9067ff7142d097698b827f3c1630a751898a76bf.camel@kernel.org>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
         <fcb30226f378ef12cd8bd15938f0af0e1a3977a2.camel@kernel.org>
         <f76fcf41728fbdd65f2b3464df0821f248b2cba0.camel@linux.ibm.com>
         <91B1FE51-C6FC-4ADF-B05A-B1E59E20132E@oracle.com>
         <e7e251000432cf7c475e19c56b0f438b92fec16e.camel@linux.ibm.com>
         <cedc77fefdf22b2cec086f3e0dd9cc698db9bca2.camel@kernel.org>
         <bffb33a3-d5b5-f376-9d7d-706d38357d1a@linux.vnet.ibm.com>
         <9526a4e0be9579a9e52064dd590a78c6496ee025.camel@linux.ibm.com>
         <9067ff7142d097698b827f3c1630a751898a76bf.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-26 at 01:21 +0300, Jarkko Sakkinen wrote:
> On Tue, 2021-08-24 at 10:34 -0400, Mimi Zohar wrote:
> > > > > Jarkko, I think the emphasis should not be on "machine" from
> > > > > Machine Owner Key (MOK), but on "owner".  Whereas Nayna is
> > > > > focusing more on the "_ca" aspect of the name.   Perhaps
> > > > > consider naming it "system_owner_ca" or something along those
> > > > > lines.
> > > > What do you gain such overly long identifier? Makes no sense.
> > > > What is "ca aspect of the name" anyway?
> > > 
> > > As I mentioned previously, the main usage of this new keyring is
> > > that it should contain only CA keys which can be later used to
> > > vouch for user keys loaded onto secondary or IMA keyring at
> > > runtime. Having ca in the  name like .xxxx_ca, would make the
> > > keyring name self-describing. Since you preferred .system, we can
> > > call it .system_ca.
> > 
> > Sounds good to me.  Jarkko?
> > 
> > thanks,
> > 
> > Mimi
> 
> I just wonder what you exactly gain with "_ca"?

Remember, a CA cert is a self signed cert with the CA:TRUE basic
constraint.  Pretty much no secure boot key satisfies this (secure boot
chose deliberately NOT to use CA certificates, so they're all some type
of intermediate or leaf), so the design seems to be only to pick out
the CA certificates you put in the MOK keyring.  Adding the _ca suffix
may deflect some of the "why aren't all my MOK certificates in the
keyring" emails ...

James


