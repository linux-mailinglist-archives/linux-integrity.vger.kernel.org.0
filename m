Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50809480E25
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Dec 2021 01:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhL2ASf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 19:18:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40766 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhL2ASe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 19:18:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D8F3B817D6;
        Wed, 29 Dec 2021 00:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8A8C36AEB;
        Wed, 29 Dec 2021 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640737111;
        bh=DESLPMWIKpTscMcVtWTkUzLP3rdDDuNCoCrkwOpcv+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXZjcyV9YJkJbU1eY1LHkNnd2BVlbxfBs+Ar93bZSnTmPeuiFISl08zl+zHzOBBot
         B83XBwciAiM5Ep1aIzFqjxl57EscutLmeNEnrujaNZxMFYOux2ZsfUHErkk4gFTBaS
         3y5DnziPHrBCnCdKkjy4vE/ZSdAhxMpxUIrHn6yIzEHSKKoCsdc+dEwkljyEOBNHdO
         tmBoND+obdA3sCnE7M21622SzdhM+HOUtadIwugnIlvFR6uIEOx173frmoi5V+uPpb
         2sumBFxpBQ+1DeR+Me8lE94Gw4AZiI5ESUWWxj+Emlj9OT74d2Ol0uw8udvl3yCTEF
         xdLLb7TYW2Eyg==
Date:   Wed, 29 Dec 2021 02:18:29 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, corbet@lwn.net, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3] Instantiate key with user-provided decrypted data.
Message-ID: <YcupVS1fxe2nHgy+@iki.fi>
References: <20211222171757.851754-1-yaelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222171757.851754-1-yaelt@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 22, 2021 at 12:17:57PM -0500, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. To support encryption of
> user-provided decrypted data, this patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data>.

So, the code change looks quite legit but why is this needed?

This part is missing from the commit message.

/Jarkko
