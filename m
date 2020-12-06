Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74442D080D
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgLFXjL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 18:39:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLFXjK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 18:39:10 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607297908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjqz+hjJciJbCQnVpiDKgr3Q9Y+jnybckoiwihl3Fcw=;
        b=adp/GKZCMZB6IC8fVFDIjpVFc+NIWzBbrXAvVBM3Odi9ixgNP/7nY9iRsLQN2oeHHSUug+
        IXEcqwuA6ApaFy5+0nutlp/1yqfzn5jUtEX1J9wQVB8zYOkNi0PWcpNlTBI+A0hL1ES75L
        tw6LVg482B4oO714qA45CXzifLXXBO1nDnmamsu4kdlVSFw2RNXDkyw37rm+fVFbr/uxZw
        wnXMK/GRmctfIITDAbYx8ZHrbflHFp+uS5Vh2GMjaMlXZGyy1Jjdo2Ogqrg3vI8W8NqTaa
        cJiQnxiIlejjh99QBZaIZWw8PqmQqm3urNznsyNFTPdYcOJ957mP5nPtGWj5yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607297908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjqz+hjJciJbCQnVpiDKgr3Q9Y+jnybckoiwihl3Fcw=;
        b=hlJXpVRtWU+ZUH6w367giSLOzLiSRWaIHANcf2mEt885O1uQNeFIxATYOZxF/rkH0IxGTq
        2ts4xQm5vnLQYkAQ==
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/4] drm/i915/pmu: Use kstat_irqs to get interrupt count
In-Reply-To: <87im9ehaim.fsf@redhat.com>
References: <20201205014340.148235-1-jsnitsel@redhat.com> <20201205014340.148235-3-jsnitsel@redhat.com> <875z5e99ez.fsf@nanos.tec.linutronix.de> <87im9ehaim.fsf@redhat.com>
Date:   Mon, 07 Dec 2020 00:38:28 +0100
Message-ID: <87im9e7bez.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 06 2020 at 14:47, Jerry Snitselaar wrote:
> Thomas Gleixner @ 2020-12-06 09:38 MST:
>
> I don't know the history behind this bit. I stumbled across it in cscope
> when looking for places using kstat_irqs.

I'm not ranting at you. The i915 people are on Cc.
