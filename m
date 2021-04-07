Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87115357115
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Apr 2021 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhDGPxp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Apr 2021 11:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233084AbhDGPxo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Apr 2021 11:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1FD061262;
        Wed,  7 Apr 2021 15:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617810814;
        bh=EdpspZ5HaG18faTAbTZG7vqUf+d47qS65sjQijjX6xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9qesmy5j8XFZ/TlL4nF+gIrRMNHa+A5srLV6pcJKkwGVsqo7N8oiIvy6I+ObvY4U
         cMNZk+imCf4dW45gkvADfuv6UVOmy8pn1ULUri1PJ9yfBTrFSjwQTKdxQ9myjuzaJz
         2ddIfIuIEeWZVPXiA6cp9u6aBIm5RJ8/QkW6Qm/vN9CYGUr5dmMfW6HPsEdIqfelLR
         8EmZrUFjzeFL06TowSFx77EjW4CV9BhDQMO+hYjdEBC1at05jqiJ9nVHmzt98cVznw
         MslLFHatcJT2vOWG1MJWX113iUQLGotAMYr8WOKxETB5ft0WZj3/SMi9ZN5fUOY2Nu
         heoZ+PGnwCZkQ==
Date:   Wed, 7 Apr 2021 18:53:31 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        nayna@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for ECDSA-signed kernel modules
Message-ID: <YG3Ve9CR0zZE+tUu@kernel.org>
References: <20210406185340.1079403-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406185340.1079403-1-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 06, 2021 at 02:53:38PM -0400, Stefan Berger wrote:
> This series adds support for ECDSA-signed kernel modules.
> 
> The first patch in this series attempts to address the issue where a
> developer created an ECDSA key for signing modules and then falls back
> to compiling an older version of the kernel that does not support
> ECDSA keys. In this case this patch would delete that ECDSA key if it is
> in certs/signing_key.pem and trigger the creation of an RSA key. However,
> for this to work this patch would have to be applied to previous versions
> of the kernel but would also only work for the developer if he/she used a
> stable version of the kernel to which this patch was applied. So whether
> this patch actually achieves the wanted effect is not always guaranteed.

Just wondering why the key needs to be removed in the fallback.

/Jarkko
