Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477C6344C51
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Mar 2021 17:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCVQwJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Mar 2021 12:52:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230031AbhCVQv5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Mar 2021 12:51:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A45C861972;
        Mon, 22 Mar 2021 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616431914;
        bh=5AyRLAO5DixWjKkZ3XWjFxp2WdDIpIG2VQGTX+JpRvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4bMoJp7NZlKNZyBonXB7Aa7rA1x7p6+1a7mRL2Y2CBOdm3ETacWQvCEXiFSTxsuo
         b0MV3YYEC+QZ5f5jxIXDclVmBsLl1wz87GG2P8PJWaoDRhQ2OxWpXdYrPBzU1pXfpP
         k74/0v28kwonjbzvnGnpATWvSAD2gIbKF7WyvyOJow0p9qTCXg6yoENjAHEwx2czue
         6K9p7xtxRiqYAN+3la1oVAr/TnA3eZgcJz9ddn9m1Ugnjn+3xdi7bzyxImbNr/IcPn
         r/p93fJDDmRAmHyhiUDzpY7HpJb+eXdii79sIquXzQATL4p1YzMP3FiWZTxBldFzDW
         F1kmpSUjXvcRw==
Date:   Mon, 22 Mar 2021 09:51:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] ima: don't access a file's integrity status before
 an IMA policy is loaded
Message-ID: <YFjLG7+mhDgsQOYu@gmail.com>
References: <20210322154207.6802-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322154207.6802-1-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 22, 2021 at 11:42:06AM -0400, Mimi Zohar wrote:
> Only after an IMA policy is loaded, check, save, or update the cached
> file's integrity status.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

This commit message doesn't describe what the actual effect of this change is.
Is it fixing something?

- Eric
