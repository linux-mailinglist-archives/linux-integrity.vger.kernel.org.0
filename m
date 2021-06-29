Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED853B7924
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 22:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhF2UP2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 16:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232689AbhF2UP1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 16:15:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97ACF61DB4;
        Tue, 29 Jun 2021 20:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624997580;
        bh=Ih+AwCZioicKTFRZiHaD6RYCFwrh1gGizZc0D4mvJi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sEDXmQxzUVJwd3LNJfvn4q+jAeRTQAEJAdjIf41rSzZ8ecxQ1CoYENLhkDUHSBko5
         NJNlLlT2Gm89DF3mNEZPwkgRLMRhfUASdLxebbCiR5XTwYB/zfFxcVFrYUUKN2uPxt
         MW4e/0SEF5IVu8Kt99tCYE0stE9MYddIk2luX8ZCE+tDcuUQys3dRj0Zx4uGHqslUh
         7RAKPgdchf3UyExfTWjEdz6x2241NeXV0/XDa9C8RH2GiIh2Ru2FlJVuI9Ih7br3/P
         zugOS100YkXIEtVccx9RsEA+cP8DnOfA/5suqZTtA8ZqHWDgaTqcS3yOqNFmqEtXu/
         am6agRm1LWWEQ==
Date:   Tue, 29 Jun 2021 23:12:57 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, jeyu@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] certs: Redirect openssl error message to null device
Message-ID: <20210629201257.dr77kemy66mxpox5@kernel.org>
References: <20210625122902.4058783-1-stefanb@linux.vnet.ibm.com>
 <9e925935-529e-49c9-e499-3eac43bddb66@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e925935-529e-49c9-e499-3eac43bddb66@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 25, 2021 at 08:32:37AM -0400, Stefan Berger wrote:
> On 6/25/21 8:29 AM, Stefan Berger wrote:
> 
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Address the following issue detected by the kernel test robot when
> > there's no certificate file at the time when checking for the type
> > of key in the cert:
> > 
> > Can't open certs/signing_key.pem for reading, No such file or directory
> > 
> > The simplest solution is to redirect openssl's stderr output to /dev/null.
> > 
> > Fixes: 28d62d945ded ("certs: Trigger creation of RSA module signing key if it's not an RSA key")
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> Jarkko,
> 
> can you please squash this patch into the one it fixes. Unfortunately when
> rebasing you will have to fix the subsequent patch from this merge error
> 
> ifeq ($(openssl_available),yes)
> <<<<<<< HEAD
> X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text
> 2>/dev/null)
> =======
> X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> endif
> >>>>>>> 87e968848116 (certs: Add support for using elliptic curve keys for
> signing modules)
> 
> to this:
> 
> 
> ifeq ($(openssl_available),yes)
> X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text
> 2>/dev/null)
> endif
> 
> Thanks.
> 
>    Stefan

The problem is that I have already a pending pull request, and merge window
is soon closing.

I think it's a better idea that I just drop these patches and send a new
pull request, and you should construct a new version of the series. This
cannot be a blocker for the rest of the patches (or even potential
blocker). We can consider the current patches not ready for mainline.

/Jarkko
