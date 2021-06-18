Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92A63AC6C3
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhFRJHJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 05:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhFRJHI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 05:07:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F657613CB;
        Fri, 18 Jun 2021 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624007099;
        bh=S19gP37b9k5Gx2jZvH58dQC5e8J8vTmMvHp23BikeJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t90kq/gyNDvSohIPAHmN3sR9MJHlQDLO0skB9TKldPEVlECTq1qwMdqkQFLjo7PtY
         v5CfQMrMtgQzjEl92HGxYt0bM6HgN/3bNwTHjIqsFqrrZKT3KLgFnudas1tzW/HAp8
         jIioXV5yiqSaXe8hKRZTVzwEZ/pIweSn2ugtSwhH0PCNuLgxF8CMW9+SCfR9Gt9A2V
         sOvtk6bJz9kBc2irrblLHKT3M9Ao36hUYSKn0n9wxp1slobANo8xW7jkugSrn/FJR5
         H3TpFfOLijt7Q/cLKH7aVUdBCH5xcWzAteyD4cilxAGyCt6AQ++cVEblfgpZXSz6jZ
         XG5Uwp48WukiQ==
Date:   Fri, 18 Jun 2021 12:04:56 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] certs: Adjustment due to 'Check whether openssl
 tool is available'
Message-ID: <20210618090456.hjm7qh3xnofytyti@kernel.org>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
 <20210610125623.1553792-5-stefanb@linux.ibm.com>
 <20210614192329.dhhahvi5gtnlgbln@kernel.org>
 <b355a2f2-78e7-61b4-2040-9ea3f8de0f73@linux.ibm.com>
 <20210615130629.doay3piolfjcg6ss@kernel.org>
 <6b1cf012-a68e-82df-4cc8-c1f9685d1603@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b1cf012-a68e-82df-4cc8-c1f9685d1603@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 15, 2021 at 09:29:08AM -0400, Stefan Berger wrote:
> 
> On 6/15/21 9:06 AM, Jarkko Sakkinen wrote:
> > On Mon, Jun 14, 2021 at 03:28:56PM -0400, Stefan Berger wrote:
> > > On 6/14/21 3:23 PM, Jarkko Sakkinen wrote:
> > > > On Thu, Jun 10, 2021 at 08:56:23AM -0400, Stefan Berger wrote:
> > > > > Adjust the previous patch due to fixes applied to the first patch
> > > > > in the series.
> > > > > 
> > > > > Fixes: 46449892e6e5 ("certs: Add support for using elliptic curve keys for signing modules")
> > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > ---
> > > > >    certs/Makefile | 5 +++++
> > > > >    1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/certs/Makefile b/certs/Makefile
> > > > > index dc9f354dd5f8..4eb69bdadc79 100644
> > > > > --- a/certs/Makefile
> > > > > +++ b/certs/Makefile
> > > > > @@ -66,16 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
> > > > >    ifeq ($(openssl_available),yes)
> > > > >    X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> > > > > +endif
> > > > >    # Support user changing key type
> > > > >    ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> > > > >    keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
> > > > > +ifeq ($(openssl_available),yes)
> > > > >    $(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> > > > >    endif
> > > > > +endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> > > > >    ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
> > > > > +ifeq ($(openssl_available),yes)
> > > > >    $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> > > > >    endif
> > > > > +endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
> > > > >    $(obj)/signing_key.pem: $(obj)/x509.genkey
> > > > >    	@$(kecho) "###"
> > > > > -- 
> > > > > 2.29.2
> > > > > 
> > > > > 
> > > > Please check that they are applied correctly, thanks.
> > > No, they are not applied correctly. 2/2 shows this here:
> > > 
> > > 
> > >   ifeq ($(openssl_available),yes)
> > >   X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> > > +endif
> > > +
> > > 
> > > 
> > > This endif is in 2/4 in v6 and should appear on your git in 1/2. How did it
> > > get into 2/2?
> > > 
> > > https://lkml.org/lkml/2021/6/10/493
> > I assumed that the two other commits are exact same as in v4 because
> > appropriate tags were mssing.
> 
> What's in your git repo now looks good.
 
OK, great.

/Jarkko
