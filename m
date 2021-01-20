Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200512FCABF
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 06:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbhATFcL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 00:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730883AbhATFX4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 00:23:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99CF923138;
        Wed, 20 Jan 2021 05:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611120195;
        bh=3KSS8uEsk1AlA+jCg1dus/LI0smdN5vsCgO465xFWA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFe/WaqM7/+B1qrIsS31+95ahPnnbSr0OzK7NKDO0s9K/10ZOqnVLVjNSCiOVe3PS
         nW1sfqETAC7A7V/Yg6xZEryUpN9NsVWIpdfVtmSs0Lz77VOFlKlUpQxlccbEIpoWjK
         fjh8iRpy/0ywZHMb/1zQjOYl2a/7dpGpuIfdYOXCf61A9IZDSvqrV+nTM7AqtJGGR/
         3tWxpYbXYXO9H9jq+3KKo6VRI08NVuI7VVhy7f+52Ok3lWlZd5+nfirVBUrDsXKdCT
         ntKxyl1xZK3GX1TlCWxZTd/+1u/BZlHfqaRbjdaBah7CrLSKbrxtHMxxtkOw3wsMNR
         OG86mse8i8eVQ==
Date:   Wed, 20 Jan 2021 07:23:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 09/10] certs: Allow root user to append signed hashes
 to the blacklist keyring
Message-ID: <YAe+PZHadpJcR0oc@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-10-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-10-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:19:08PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Add a kernel option SYSTEM_BLACKLIST_AUTH_UPDATE to enable the root user
> to dynamically add new keys to the blacklist keyring.  This enables to
> invalidate new certificates, either from being loaded in a keyring, or
> from being trusted in a PKCS#7 certificate chain.  This also enables to
> add new file hashes to be denied by the integrity infrastructure.
> 
> Being able to untrust a certificate which could have normaly been
> trusted is a sensitive operation.  This is why adding new hashes to the
> blacklist keyring is only allowed when these hashes are signed and
> vouched by the builtin trusted keyring.  A blacklist hash is stored as a
> key description.  The PKCS#7 signature of this description must be
> provided as the key payload.
> 
> Marking a certificate as untrusted should be enforced while the system
> is running.  It is then forbiden to remove such blacklist keys.
> 
> Update blacklist keyring and blacklist key access rights:
> * allows the root user to search for a specific blacklisted hash, which
>   make sense because the descriptions are already viewable;
> * forbids key update;
> * restricts kernel rights on the blacklist keyring to align with the
>   root user rights.
> 
> See the help in tools/certs/print-cert-tbs-hash.sh provided by a
> following commit.

Please re-order patches in a way that print-cert-tbs-hash.sh is
available before this. That way we get rid of this useless remark.

> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

/Jarkko
