Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC1488689
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Jan 2022 22:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiAHV6v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 8 Jan 2022 16:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiAHV6t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 8 Jan 2022 16:58:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C7C06173F;
        Sat,  8 Jan 2022 13:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C9F60E98;
        Sat,  8 Jan 2022 21:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8D2C36AEF;
        Sat,  8 Jan 2022 21:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641679128;
        bh=Y6sbFiQfrHaYjHQjG6xMkOjQHqP/ZBROBbCrxSwDyB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEVnZNnwbgVJ0OZLR/eQlDE2eseTrPcYtQYZeDKSznp3xORSEnjlt7XsRcDLI8n/T
         z1wYyeNigJ+iaLnMk/tHorwBZ3rVjo1bugIES38Xv8ic0AKfaLMezKaOxUKHByzH35
         clz++oYr71LQ8halWcy4BqE9NhPvJxG+09qEpR185IPLiVe2tZaD5kge9Jdruq9rd0
         8VRtLqsr+yaKFBV/2zUEi5YTPoGEbTAnOzRrKY5AjCbUf5Ov2v4fG96BrO/uqMAHVu
         Kel5ynYRRCZGjI7NaDimO+/YXoQu++TK379CbnK7Ja94ybFT+G/CoTHArJ/8+eD0+A
         mEwIuDoTz054w==
Date:   Sat, 8 Jan 2022 23:58:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, corbet@lwn.net, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
Message-ID: <YdoJD3Kaas07v6K4@iki.fi>
References: <20211229215330.4134835-1-yaelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229215330.4134835-1-yaelt@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 29, 2021 at 04:53:30PM -0500, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. This patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data> that allows to instantiate encrypted keys using
> user-provided decrypted data, and therefore allows to perform key
> encryption from userspace. The decrypted key material will be
> inaccessible from userspace.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yael Tiomkin <yaelt@google.com>

What is the use case for this?

BR, Jarkko
