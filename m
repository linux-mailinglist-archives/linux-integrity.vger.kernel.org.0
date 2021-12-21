Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0B47BC2C
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhLUIut (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 03:50:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51912 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhLUIut (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 03:50:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920E96147F;
        Tue, 21 Dec 2021 08:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2ADC36AE2;
        Tue, 21 Dec 2021 08:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640076648;
        bh=RJSqsLYeU9GawOiffanQgQyeJI8F3d1k4te3xm7hTm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rm8mH27OGKStX5WQToTflsPASgoB7rhMasB65wkeW0jpXMA1pzYbekEtufMBqkILX
         eTig0GI0DUS52rxlRN6Rcy5Fr45+qJkBCRwztSk+X0Yt8DqFpvbPUta34FmTER3ao6
         lESJg9N7WgFHAkl0wueojJ6T0+pq++qTC6PgBdbDp/8B9ek1zNWSkJDzuIChUUu7AZ
         AtxhrxZch/VlUXmuJsrbetg3WkJn46+jywAkc91g41mLR7rVIyvb/RK3ysIOWX1xeB
         ct8h/2N4YvYTO68TFiUkO+i658K1huHib2HOjUFbkfX90fVwd51DV4P5fIDeK4CPtq
         6hlXOawJbH8sg==
Date:   Tue, 21 Dec 2021 10:50:46 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andreas Rammhold <andreas@rammhold.de>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v8 0/5] Enable root to update the blacklist keyring
Message-ID: <YcGVZitNa23PCSFV@iki.fi>
References: <20210712170313.884724-1-mic@digikod.net>
 <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8d27da-b5d4-e42c-af01-5c03a7f36a6b@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 13, 2021 at 04:30:29PM +0100, Mickaël Salaün wrote:
> Hi Jarkko,
> 
> Since everyone seems OK with this and had plenty of time to complain, could
> you please take this patch series in your tree? It still applies on
> v5.16-rc5 and it is really important to us. Please let me know if you need
> something more.
> 
> Regards,
>  Mickaël

I'm off-work up until end of the year, i.e. I will address only important
bug fixes and v5.16 up until that.

If any of the patches is yet missing my ack, feel free to

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
