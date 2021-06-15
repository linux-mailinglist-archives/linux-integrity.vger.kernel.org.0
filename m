Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585893A7EA8
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhFONIh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 09:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229943AbhFONIg (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 09:08:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9148C61001;
        Tue, 15 Jun 2021 13:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623762392;
        bh=8Ie42VGSzlRGizs8Gli2qgnyA71uXtJOdxHq6eTlgzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0eBgYiSj+ZiAAE5NdBYEecYDbnGdr6lop+2HZ7LAoitIM4gSq9hBpww3WcLOus7H
         ZyV2UU4WSKvBzMFUNWCrxbOKuzctvx9mEUTqRXkJABWHUkKbyiR2I30So+80cuMige
         0Z+phiYlO/TjNJetY0+fLJZNGxaDEkM7GMhBsLWX4rxrEokFN/afXMvM0laR51KIUi
         Q5JA6vVRuqahiJVlAuq4esqD1IY+QUi3w9/KKdadicMDUavgYJkz+GfdSsu8oVMzVf
         oeerS5R0/pRJZ+GM2AXmcJXDRNNx4rfUV2s7TrIyhUWrmoCuXrDzk9LUkZBxLrU4Cz
         7kttonOhNo5lA==
Date:   Tue, 15 Jun 2021 16:06:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] certs: Adjustment due to 'Check whether openssl
 tool is available'
Message-ID: <20210615130629.doay3piolfjcg6ss@kernel.org>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
 <20210610125623.1553792-5-stefanb@linux.ibm.com>
 <20210614192329.dhhahvi5gtnlgbln@kernel.org>
 <b355a2f2-78e7-61b4-2040-9ea3f8de0f73@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b355a2f2-78e7-61b4-2040-9ea3f8de0f73@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 14, 2021 at 03:28:56PM -0400, Stefan Berger wrote:
> 
> On 6/14/21 3:23 PM, Jarkko Sakkinen wrote:
> > On Thu, Jun 10, 2021 at 08:56:23AM -0400, Stefan Berger wrote:
> > > Adjust the previous patch due to fixes applied to the first patch
> > > in the series.
> > > 
> > > Fixes: 46449892e6e5 ("certs: Add support for using elliptic curve keys for signing modules")
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >   certs/Makefile | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/certs/Makefile b/certs/Makefile
> > > index dc9f354dd5f8..4eb69bdadc79 100644
> > > --- a/certs/Makefile
> > > +++ b/certs/Makefile
> > > @@ -66,16 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
> > >   ifeq ($(openssl_available),yes)
> > >   X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> > > +endif
> > >   # Support user changing key type
> > >   ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> > >   keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
> > > +ifeq ($(openssl_available),yes)
> > >   $(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> > >   endif
> > > +endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> > >   ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
> > > +ifeq ($(openssl_available),yes)
> > >   $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> > >   endif
> > > +endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
> > >   $(obj)/signing_key.pem: $(obj)/x509.genkey
> > >   	@$(kecho) "###"
> > > -- 
> > > 2.29.2
> > > 
> > > 
> > Please check that they are applied correctly, thanks.
> 
> No, they are not applied correctly. 2/2 shows this here:
> 
> 
>  ifeq ($(openssl_available),yes)
>  X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> +endif
> +
> 
> 
> This endif is in 2/4 in v6 and should appear on your git in 1/2. How did it
> get into 2/2?
> 
> https://lkml.org/lkml/2021/6/10/493

I assumed that the two other commits are exact same as in v4 because
appropriate tags were mssing.

/Jarkko
