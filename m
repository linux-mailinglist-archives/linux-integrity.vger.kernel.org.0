Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B248247BBE8
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 09:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhLUIdG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 03:33:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52438 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhLUIdG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 03:33:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A507B80E07;
        Tue, 21 Dec 2021 08:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAABC36AE2;
        Tue, 21 Dec 2021 08:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640075583;
        bh=kwsneyhmyLhbyS5yR1DIRC8tJK+kc2ih3L52VQGqI60=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoplRsbp4U+lKpzxxSZWZvNO+XJAYvj935JOcldaVjxtj/Qb/yjMgf2adiofNNJYi
         D1p34vecFCvVMwj/501sDtWs/Gvmc5f0f/86yApE71eDoXL8G1kbq4R7kSsqwP/T4x
         s2zbLN8gd9P/XGYJQmQwhE2M+1y4XKZKbhLQDTBiIC1EY2V2PI4qfXediQ7Wfawhwf
         7Px/EK6dgh4+V3bD8fLDgYcffyduZ9FhsYr36NEiORZ6e+10mC+5pBuHcunLM2dYTg
         SWlFINXbMOCRi8E2cNgT4Ie17ax0NN0TVpvlxTV4A1jHzq5/39qtxqdpPr7FjTgstb
         bNkqbZK/peUlw==
Date:   Tue, 21 Dec 2021 10:33:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security:trusted_tpm2: Fix memory leak in
 tpm2_key_encode()
Message-ID: <YcGRPdqkX94hCGG5@iki.fi>
References: <20211212135403.59724-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212135403.59724-1-niejianglei2021@163.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 12, 2021 at 09:54:03PM +0800, Jianglei Nie wrote:
> Line 36 (#1) allocates a memory chunk for scratch by kmalloc(), but
> it is never freed through the function, which will lead to a memory
> leak.
> 

through the function => in the implementation

Also, "line 36" is a relative to something, right? What is it?

/Jarkko
