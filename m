Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A59D371733
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhECO4d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 10:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhECO4c (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 10:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCF53611CD;
        Mon,  3 May 2021 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620053739;
        bh=yYdFn9UpSYDW+ZIqHHl4T7RRAR7QT/dCboazRa48y5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEW4oazT3r6l/DHbrMliqYyYmsjLfOPaQ+nK/51/0aMr3hOeKK1/DoZk04yNpYcX1
         eJphO5rjzLBgvHU4sGd907Ts1iLlh589GvYatCf08sGmcY0TV8G55Jf1F9pPmUDeuA
         oQc2vV1OC+yf8j50w6KzEd/iLZ/2EO3CpeGKhIkJ5pfzCOUXiF4k4co3bBjLzCznpw
         qM4KdBl3w6+5RekJ0zcxhfCxwdvWUQAvU35wjZJZRbftLkDLXKsCXuBxU+t5VbJYJP
         Zx2RoStBFoBL1Z421krxc5YRnJkeo2vup/2WY6hrnSBxAEJhRYho7/gBYU7ccIc6+c
         KMHfC5GKDRFpQ==
Date:   Mon, 3 May 2021 17:55:37 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] KEYS: trusted: Fix memory leak on object td
Message-ID: <YJAO6SfreYLxOOpn@kernel.org>
References: <20210430113724.110746-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430113724.110746-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Apr 30, 2021 at 12:37:24PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Two error return paths are neglecting to free allocated object td,
> causing a memory leak. Fix this by returning via the error return
> path that securely kfree's td.
> 
> Fixes clang scan-build warning:
> security/keys/trusted-keys/trusted_tpm1.c:496:10: warning: Potential
> memory leak [unix.Malloc]
> 
> Fixes: 5df16caada3f ("KEYS: trusted: Fix incorrect handling of tpm_get_random()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
