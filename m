Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7738331E
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2019 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfHFNn3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 09:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732846AbfHFNn0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 09:43:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 751E12173C;
        Tue,  6 Aug 2019 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565099005;
        bh=ZQXs04u0CjVQyGUn/plxBUN0R2FVhChaLwJZcSleMm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TxGzVk3SA+DcRfZ/4yKiOGawEbNJua94mhRO8/gJ/IXsSRSpKVzu5PEvgQ+7HfQG5
         71ech1YIlhuiZo8haFAYJrO+96e0AzRrg46jNb8wWCzfu7f5BYhUOWaszf0Wqfqgiy
         UyRxnT43UtcvsUwglbZSwOJk37ujClJGpzvtjNk8=
Date:   Tue, 6 Aug 2019 15:43:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, dhowells@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        peterhuewe@gmx.de, jgg@ziepe.ca, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, arnd@arndb.de,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, ard.biesheuvel@linaro.org,
        daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org
Subject: Re: [RFC/RFT v3 2/3] KEYS: trusted: move tpm2 trusted keys code
Message-ID: <20190806134322.GA10783@kroah.com>
References: <1565098640-12536-1-git-send-email-sumit.garg@linaro.org>
 <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565098640-12536-3-git-send-email-sumit.garg@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 06, 2019 at 07:07:19PM +0530, Sumit Garg wrote:
> Move TPM2 trusted keys code to trusted keys subsystem.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/char/tpm/tpm-interface.c          |  56 -----
>  drivers/char/tpm/tpm.h                    | 224 ------------------
>  drivers/char/tpm/tpm2-cmd.c               | 307 ------------------------
>  include/keys/trusted_tpm.h                |  23 +-
>  include/linux/tpm.h                       | 264 +++++++++++++++++++--
>  security/keys/trusted-keys/Makefile       |   3 +-
>  security/keys/trusted-keys/trusted-tpm.c  |  16 +-
>  security/keys/trusted-keys/trusted-tpm2.c | 378 ++++++++++++++++++++++++++++++
>  8 files changed, 652 insertions(+), 619 deletions(-)
>  create mode 100644 security/keys/trusted-keys/trusted-tpm2.c

'git format-patch -M' will create a patch that shows the rename, and
then any tiny differences that happened after that.  A patch like this
is hard to see what changed in the move.

thanks,

greg k-h
