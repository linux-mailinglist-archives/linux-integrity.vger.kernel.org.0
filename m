Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9A32FCAA6
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 06:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhATFUC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jan 2021 00:20:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbhATFQR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jan 2021 00:16:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C69A2311C;
        Wed, 20 Jan 2021 05:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611119736;
        bh=0v5dSZdhQ0dpp0/V5fqVpZyRRfvlSjz+9GhAku29pu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YT/KcKBPZdtcxBxmCbPP+rcGEqthJpNc7NBg5K6OlkGkfF5rUonooybJv5j2vrzB7
         72UKHnp1uAQK4N6eR99+Say0AjEKKiDLPM+7Vmq8/3plY6zA9yOIyi/mja9W739DAE
         mMiM+pZ1FYTJ8jakaTTQyP1Xa/YbHGC0GNWZk00m/g4hlyg+eEXlII84Z2YEm7Dwr4
         Zzp2Pqbr45dnOKach/X9hAvPRqx2I60U8sdq1iGGNWpVYzga8R5nVPcJ8qFAbmX6bS
         grbZCOvdJD+HOFkZ78ZMwkvsvY49pG5+7aGAxwYgSwIgPZKyCq3BGrbI7lSvqp+amS
         DGBJG+DQpLxXA==
Date:   Wed, 20 Jan 2021 07:15:30 +0200
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
Subject: Re: [PATCH v3 05/10] certs: Replace K{U,G}IDT_INIT() with
 GLOBAL_ROOT_{U,G}ID
Message-ID: <YAe8cr7bS2Dn0RRn@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-6-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-6-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:19:04PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> Align with the new macros and add appropriate include files.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

The commit message makes no sense. What you new macros?

/Jarkko
