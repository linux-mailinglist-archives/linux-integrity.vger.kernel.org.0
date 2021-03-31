Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931DC34F701
	for <lists+linux-integrity@lfdr.de>; Wed, 31 Mar 2021 04:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCaCyj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Mar 2021 22:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233067AbhCaCyL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Mar 2021 22:54:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E31CC619CD;
        Wed, 31 Mar 2021 02:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617159249;
        bh=44BOhixTrsTOXN2vKxGGhWkzp//5d88yNw459tV6lEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFoqu+lPSk8p+rInWNrYAXDlaoY79qnvR7MJZnsZ2Y5aB03QrpFvwYvOLsahLBSxw
         MzAz5UrG1R7r6fVIptCHBNbU/h4AlM2nglOogOZrYxU9YGTTYfmB8U1tUIUgQyr32d
         mRa4PYgzPkGZJFCAZVokepRoleAsy3mn9B/u6O0kBmGwqOJrcuwJEPTBY9pTZj5Jdz
         9c/h4yEVqR0gotEJVUgBqVFJPIsxzZtfivdCljRzfRyqCxJ/jZdIAoFLgcJX3lfnNg
         ic4MsWd6Za2gbsHbMs/P+GYzJanNeE1dZdr0d6R5hnSkJiQZXwhAInbuk7i+ZrLpuD
         wIVFbIhAFOqnw==
Date:   Wed, 31 Mar 2021 05:54:06 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] IMA: Fix error in comment
Message-ID: <YGPkTuoDhupnzuJB@kernel.org>
References: <20210330060845.18422-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330060845.18422-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 30, 2021 at 08:08:45AM +0200, Ricardo Ribalda wrote:
> ima_file_mprotect does not return EACCES but EPERM.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> ---
>  security/integrity/ima/ima_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9ef748ea829f..716ea29cf897 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -409,7 +409,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>   * this point.  Eliminate this integrity gap by denying the mprotect
>   * PROT_EXECUTE change, if an mmap appraise policy rule exists.
>   *
> - * On mprotect change success, return 0.  On failure, return -EACESS.
> + * On mprotect change success, return 0.  On failure, return -EPERM.
>   */
>  int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>  {
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
> 
