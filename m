Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29F464BCB
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Dec 2021 11:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348736AbhLAKn3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Dec 2021 05:43:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54400 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348733AbhLAKn2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Dec 2021 05:43:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 547F0CE1D91;
        Wed,  1 Dec 2021 10:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99B5C53FAD;
        Wed,  1 Dec 2021 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638355204;
        bh=a4Cq/m0f4IxDH0TKW9jWlHW2kYkBEcRg+PoObqg/Rqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVNncubsPfYf4tPmWbtlDX2UeIM3QABUX74xntHSpnQK0tCOs3DqD5fTDIDSyIFqS
         vR140YxIMlG79ieberlHDSj4OaAHCDBTXg1uDNdpdYFqlvaq+OCiQvLLrSlHLQDwKI
         yjl3Yrl76KYv7T3qpFznxo2aqHm6zYBCuo9lN5U72J3A+Yg1UWbjCpDEm8acSwuC9O
         Av7KSjMSjQZkZnk0H/D7R+gyPat951qFi0pa8BIFtH7L6+8LLllm3furXmvGbWiGsy
         sOoJWNtGugI5+OlPq5wioRas976ZR7kmgr6M6qqVz8qQpCZ+c7uPdkasUvMqthIVXH
         qmyEbY2aCc61A==
Date:   Wed, 1 Dec 2021 12:40:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     andreas@rammhold.de, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4] KEYS: trusted: Fix trusted key backends when building
 as module
Message-ID: <YadRAWbl2aiapf8l@iki.fi>
References: <20211201095900.3009225-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211201095900.3009225-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 01, 2021 at 10:59:00AM +0100, Ahmad Fatoum wrote:
> From: Andreas Rammhold <andreas@rammhold.de>
> 
> Before this commit the kernel could end up with no trusted key sources
> even though both of the currently supported backends (TPM and TEE) were
> compiled as modules. This manifested in the trusted key type not being
> registered at all.
> 
> When checking if a CONFIG_… preprocessor variable is defined we only
> test for the builtin (=y) case and not the module (=m) case. By using
> the IS_REACHABLE() macro we do test for both cases.
> 
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Thank you, I picked this.

/Jarkko
