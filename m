Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13B433FAB2
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 22:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQV6W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 17:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhCQV6F (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 17:58:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD8F964E64;
        Wed, 17 Mar 2021 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616018285;
        bh=1JkZ0vyLQz4PnX/wS0fY7/yww7iJrPMI9VFzJtNzYvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d3+K4AL3RC19gKUG3ADG3J/gblosuycyOP7LZktGsbJUPqC0TvFFIG8yDxhKJLI0t
         k10dPxkr9wlN8u+kNfqnq/jcO146D+KMMxx4wYIZ7FlEg23QnsVOyyb73WUUJmWpIe
         3P8idSid6qPJvo1HpJ5j2sWGOSrwz182fiDrcAnbg41IsPXTAIIDDOiC06o7DUlTw+
         OSF9Mxe9zwJbhPA4thq/KqdXdwaze9nmrY6pPzd70uBT/q5Of/neWNmMvMrRCYAFob
         +EMAMUGU+8fHMFFmt7A3tTyCUITwbeQECgp3+hnSF4c3INaHgMtN1VuZlolOod1EbF
         7yq/EnblNk1Ig==
Date:   Wed, 17 Mar 2021 23:57:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: tee: fix build error due to missing
 include
Message-ID: <YFJ7UOagBgm5Fn0/@kernel.org>
References: <20210317142904.27855-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317142904.27855-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 17, 2021 at 03:29:05PM +0100, Ahmad Fatoum wrote:
> MODULE_DEVICE_TABLE is defined in <linux/module.h>, which is not
> included. Add the include to fix the build error its lack caused.
> 
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Hi, I appreciate your work, thanks for taking action, but unfortunately
I already incorporated this fix to the original patch.

/Jarkko
