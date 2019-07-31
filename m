Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587EB7CCFC
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Jul 2019 21:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfGaTju (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 Jul 2019 15:39:50 -0400
Received: from ms.lwn.net ([45.79.88.28]:55906 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfGaTju (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 Jul 2019 15:39:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6CBFD7DA;
        Wed, 31 Jul 2019 19:39:49 +0000 (UTC)
Date:   Wed, 31 Jul 2019 13:39:48 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tweek@google.com,
        matthewgarrett@google.com, jorhand@linux.microsoft.com,
        rdunlap@infradead.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v4] tpm: Document UEFI event log quirks
Message-ID: <20190731133948.1a527db8@lwn.net>
In-Reply-To: <20190712154439.10642-1-jarkko.sakkinen@linux.intel.com>
References: <20190712154439.10642-1-jarkko.sakkinen@linux.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 12 Jul 2019 18:44:32 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> There are some weird quirks when it comes to UEFI event log. Provide a
> brief introduction to TPM event log mechanism and describe the quirks
> and how they can be sorted out.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> v4: - Unfortanely -> Unfortunately
> v3: - Add a section for refs and use a bullet list to enumerate them.
>     - Remove an invalid author info.
> v2: - Fix one typo.
>     - Refine the last paragraph to better explain how the two halves
>       of the event log are concatenated.
>  Documentation/security/tpm/index.rst         |  1 +
>  Documentation/security/tpm/tpm_event_log.rst | 55 ++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/security/tpm/tpm_event_log.rst

I've applied this, thanks.  Before I could do so, though, I had to edit
the headers, which read:

> Content-Type: text/plain; charset=y

"git am" *really* doesn't like "charset=y".  I think this is something
that git send-email likes to do occasionally, don't know why...

Thanks,

jon
