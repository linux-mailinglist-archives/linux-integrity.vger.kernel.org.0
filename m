Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E29371720
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 16:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhECOyp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 10:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhECOyo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 10:54:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FB09611BF;
        Mon,  3 May 2021 14:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620053630;
        bh=CUC2CtuvzErK37KWqnrScmPHfkq9NDl2U4c1S7d10a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzQluamzW7KQZn/2rVrUnKpyUmg6yzsg/Fg3lNf6Ged9O7m2Asda4EYp+fmvhsULj
         gdVMCXB4+OErVsstULtS9qpuDGTo5Jspnm+67EeCtV1KTyeYVp0/6+XXpcRVJOtji2
         SgYbh0wAqBmntGxdZ905gpBWMQBFfdxAwRbzBZ8wNBJzliSQKkSLfteGOuWGdrXUTI
         8PsKa5lJzdUT5d54qoEJz3Ajs1MTzyMRwXYbj58Xj04ceNDZiuPfoBPVknGjrvPAeb
         6swKGiZmJFB9/M0d2AbB+KUhdcgMSXOhyVzeCQu7D2/zz3cxmqVYkCdSU/3zqVzsQk
         QjvkA+uVACGkQ==
Date:   Mon, 3 May 2021 17:53:48 +0300
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
Message-ID: <YJAOfJyMy6Uu/Cia@kernel.org>
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
 
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
