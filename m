Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B814883D7
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Jan 2022 14:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiAHNyk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Jan 2022 08:54:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38892 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAHNyj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Jan 2022 08:54:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12A4560FE3;
        Sat,  8 Jan 2022 13:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6763C36AE3;
        Sat,  8 Jan 2022 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641650078;
        bh=n5CeQCaLX9Mzw9S1NmoY2amBI7g7s0AkC2jF7xAlLyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+ogBxxYTpdgBjcT/wO+UcZrBbhsRc09XQsPgGkIYjMUSlgcwixQW1+jEmJKLEFP7
         KW514n95Nua1MGpXaoDBlTC0etUPA6Bq5uGuSVfeauyqlf/FXX9pfp7HAfgfeRISOr
         7NgcO+ZJ72WMuS0ZN89gnzi2ZnLxoiUGkpN0qeSNaettUepL/v6ko+Ph1fSDbrg3yE
         S71sladMHh4gz0Dmu/4VSmBTO7BIYZmEpRbRP8bMF/mj+hctdFcTATqekx1vBFQInZ
         xS3D0PhOz3c1I++ya2Pl7zZtPYT3MU/5KYpMESsJ27H/IWr4iUi/KKfTPSaM+rsR6O
         ujBoKniWx5hKA==
Date:   Sat, 8 Jan 2022 15:54:29 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/3] certs: export load_certificate_list() to be used
 outside certs/
Message-ID: <YdmXlUcsa+xRcwSN@iki.fi>
References: <20220105175410.554444-1-nayna@linux.ibm.com>
 <20220105175410.554444-2-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105175410.554444-2-nayna@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 05, 2022 at 12:54:08PM -0500, Nayna Jain wrote:
> load_certificate_list() parses certificates embedded in the kernel
> image to load them onto the keyring.
> 
> Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> function)" made load_certificate_list() a common function in the certs/
> directory. Now, export load_certificate_list() outside certs/ to be used
> by load_platform_certificate_list() which is added later in the patchset.
> 
> Reported-by: kernel test robot <lkp@intel.com> (auto build test ERROR)
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

This lacking fixes tag, if it is a bug, or "reported-by" needs to be
completely removed.

/Jarkko
