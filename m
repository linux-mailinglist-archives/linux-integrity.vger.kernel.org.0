Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E41E1D12FD
	for <lists+linux-integrity@lfdr.de>; Wed, 13 May 2020 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbgEMMnr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 08:43:47 -0400
Received: from ozlabs.org ([203.11.71.1]:52125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732403AbgEMMnr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 08:43:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49MZ9D4QCHz9sSk; Wed, 13 May 2020 22:43:44 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
References: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/ima: fix secure boot rules in ima arch policy
Message-Id: <158937375594.3526905.9967004768395504429.b4-ty@ellerman.id.au>
Date:   Wed, 13 May 2020 22:43:44 +1000 (AEST)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 1 May 2020 10:16:52 -0400, Nayna Jain wrote:
> To prevent verifying the kernel module appended signature twice
> (finit_module), once by the module_sig_check() and again by IMA, powerpc
> secure boot rules define an IMA architecture specific policy rule
> only if CONFIG_MODULE_SIG_FORCE is not enabled. This, unfortunately, does
> not take into account the ability of enabling "sig_enforce" on the boot
> command line (module.sig_enforce=1).
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ima: Fix secure boot rules in ima arch policy
      https://git.kernel.org/powerpc/c/fa4f3f56ccd28ac031ab275e673ed4098855fed4

cheers
