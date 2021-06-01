Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD29039799F
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Jun 2021 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhFASAY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Jun 2021 14:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231331AbhFASAY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Jun 2021 14:00:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EBFB61375;
        Tue,  1 Jun 2021 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622570322;
        bh=m6UKi9NkcvUQfNe74vrYXbvMtDoD1pgdMVNQhtu02sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rddcm3FO/E+i6q6srd+/vTeN5/b7srk8oLfkEEDmOSvE2ST8kvk2LG5J24tO3G2cC
         PByMTKWSzyHRG+W6Y79ORIvC8Vee3s9v5nezs6nlygPOhqqsdolXemTjRKhUz/TTkx
         eqOT3FDtVRaze/pBdOQWOYxtQMlcK3Rpp0umNg4W1qOEvA5JT3ymGCl3Y83mCRi1Uz
         IbTbSxixx7GgGI+eVFY8AjCOv0hz/KgL9XM4zWxQ/rWKPWtD9a6Tc+UXpqolTqbBZP
         SV/Oi6MZuz2FWZP8MkJcmCnn+/F6rNC2F4ebvPTlgkloCYlf8ePvf9nhIjcAS8hxDU
         5wdL7tl33nIJw==
Date:   Tue, 1 Jun 2021 20:58:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] certs: Trigger creation of RSA module signing key
 if it's not an RSA key
Message-ID: <20210601175840.nzgkon3ocdifntav@kernel.org>
References: <20210601105245.213767-1-stefanb@linux.ibm.com>
 <20210601105245.213767-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601105245.213767-2-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 01, 2021 at 06:52:44AM -0400, Stefan Berger wrote:
> Address a kbuild issue where a developer created an ECDSA key for signing
> kernel modules and then builds an older version of the kernel, when bi-
> secting the kernel for example, that does not support ECDSA keys.
> 
> Trigger the creation of an RSA module signing key if it is not an RSA key.
> 
> Fixes: cfc411e7fff3 ("Move certificate handling to its own directory")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Mimi Zohar <zohar@linux.ibm.com>

I've applied these to

git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

Can revert too but do not mind taking care of these patches as they are
not intrusive in any possible way.

/Jarkko
