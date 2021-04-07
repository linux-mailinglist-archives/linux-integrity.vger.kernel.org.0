Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2653575B7
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356035AbhDGUPw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 16:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356007AbhDGUPv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 16:15:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3190D611C9;
        Wed,  7 Apr 2021 20:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617826541;
        bh=1+gRdzaXa3CPpAICXcQ2ksebFZYF8WM8K6fcrZV+oJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdCESpHTky9J9E1NOMUt4gMFtvVXqDdAk2IKL2MKS+jjK2s7f28169dWaZiavTlPE
         50pHToXGIgxL+j4mjCIzfCw0zfxYW/eucxOx0J+TjBE86DYMzCLihStlTo/NWXChkl
         PgVriYx+/TQSxlvCEVg6eSkKl/BZGTu3KShmz8Y7Uf0AksTJf03/59wl9GDtVaM2N8
         T8lqTrrXYFDa/OOusL+WtW8l2fn8o7wZjfNGO/ITsrHiPRvDbBBEQwnuLK92U/O8pU
         c6336t0ZeXuNSaNujkoUdB1bj/IW2ANiYwPj/dJqVA4zR3HAF1UEcKmtlgGxUfnDM7
         kIaX0wLGnnfMA==
Date:   Wed, 7 Apr 2021 23:15:38 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        dhowells@redhat.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for ECDSA-signed kernel modules
Message-ID: <YG4S6qQ+vzXK6na9@kernel.org>
References: <20210406185340.1079403-1-stefanb@linux.ibm.com>
 <YG3Ve9CR0zZE+tUu@kernel.org>
 <5a217256a53f9c33aba4528ab0393b84c42b1813.camel@linux.ibm.com>
 <70f7b2a4-ec3c-3da0-bcb6-7c96f391c1c1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f7b2a4-ec3c-3da0-bcb6-7c96f391c1c1@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 07, 2021 at 01:53:24PM -0400, Stefan Berger wrote:
> 
> On 4/7/21 12:10 PM, Mimi Zohar wrote:
> > On Wed, 2021-04-07 at 18:53 +0300, Jarkko Sakkinen wrote:
> > > On Tue, Apr 06, 2021 at 02:53:38PM -0400, Stefan Berger wrote:
> > > > This series adds support for ECDSA-signed kernel modules.
> > > > 
> > > > The first patch in this series attempts to address the issue where a
> > > > developer created an ECDSA key for signing modules and then falls back
> > > > to compiling an older version of the kernel that does not support
> > > > ECDSA keys. In this case this patch would delete that ECDSA key if it is
> > > > in certs/signing_key.pem and trigger the creation of an RSA key. However,
> > > > for this to work this patch would have to be applied to previous versions
> > > > of the kernel but would also only work for the developer if he/she used a
> > > > stable version of the kernel to which this patch was applied. So whether
> > > > this patch actually achieves the wanted effect is not always guaranteed.
> > > Just wondering why the key needs to be removed in the fallback.
> Because if you signed an older kernel's modules with the ECDSA key it won't
> be able to load the modules...
> > The main concern is with bisecting the kernel.  Either elliptic curve
> > support or the first patch needs to be backported.  This patch will
> > cause the kernel module signing key to be regenerated.
> 
> 
> This assumes of course that one will bisect via the stable kernels where
> this 1st patch has been applied. Not sure whether that's what people will
> do.

In any case, sounds non-trivial issue enough ought to be documented in the
commit message.

/Jarkko
