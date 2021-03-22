Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F7344C58
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 17:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhCVQxM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 12:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCVQwp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 12:52:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B640361972;
        Mon, 22 Mar 2021 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431965;
        bh=hv13RER2/qk3O2HqxVq4E/GeB8/0gpsY1ckngPzOo5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rSvk6kD43Cv4W6nYmtyZRTY2K80Q7SbqIa4Cfna/cyTBPtfOZY8HoR62foC+1/Z8j
         Xy3JeTENbHosJ5Bugr2C5LUNivA2EkwFlbTlvGuS8QKIAOvikQavTP5Wf1o7dMCeRk
         /22W0j+10QHwTxkdz3YA6MAPjiC8I00zKGTSLv2dAmagI77Nq8G4gTggHkj0I7go7p
         O3gc88shlYwWZAo8raWIYApolyREfaXOcxFur84t7UbGMsWiFD19HQKX+BbGCc5IJA
         tcQaiM4UDEd/SDwCB+NQmk7n1mJ70UWR3livycg02PwGvtgfVWi0GsI0FDoOM41//v
         vYiJy4b9UnmrQ==
Date:   Mon, 22 Mar 2021 09:52:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
Message-ID: <YFjLWywyF8TYZHxP@gmail.com>
References: <20210322154207.6802-1-zohar@linux.ibm.com>
 <20210322154207.6802-2-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322154207.6802-2-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 22, 2021 at 11:42:07AM -0400, Mimi Zohar wrote:
> 
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: 79f7865d844c ("LSM: Introduce "lsm=" for boottime LSM selection")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Missing Cc stable?

- Eric
