Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D532F72F9
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 07:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbhAOGkt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 01:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhAOGks (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 01:40:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A135233EE;
        Fri, 15 Jan 2021 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610692808;
        bh=lGW1hgbFoXatm6VnLK/BrNas/UGlTRrJUAd+LsX7JoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SF1G+FKg57aNSGCvMNRTRyFJbRQBOJWUBPgv1SzVQDo1R44HygbYoc0T+gKYz4WqW
         uQLxJf0p0EcGUsOp3v305i4FLq7mUev9xpdqoDmxOtDYX9x7RxzLFs8WqnukvzwbX0
         FpogKqDzBty5g7lBeRl/Ql7dPy9jz54gw1MUphwajDTtOutJQKordgA7Ukd9znXQ4g
         5rZ6EnH9xbeuDzknMWTYkBMcMHJ1O1c7aPrfM1nU6XWetMKyL7FiwXMwgVK7Zlksm6
         WkAoOA6A/kX2kucxdv5wIz5ocGnUU3cWPOEwPutpj5pWgv7dlYs5Nyn8sljKz/Nicp
         rcuV7I4/ZdyRw==
Date:   Fri, 15 Jan 2021 08:40:03 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ABI: add sysfs description for tpm exports of PCR
 registers
Message-ID: <YAE4w70O8qvBlLwe@kernel.org>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
 <20210113232634.23242-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113232634.23242-3-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 13, 2021 at 03:26:34PM -0800, James Bottomley wrote:
> Adds the ABI entries for the new
> 
> /sys/class/tpm/tpm<n>/pcr-<hash>/<m>
> 
> files which are added to export the PCR hash values on a one value per
> file basis.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
