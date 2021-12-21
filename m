Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5131E47BBCF
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhLUI2i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 03:28:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50276 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhLUI2i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 03:28:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00911B810B3;
        Tue, 21 Dec 2021 08:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461D4C36AE2;
        Tue, 21 Dec 2021 08:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640075315;
        bh=Y9ODSoNx6DadvX9fNZGxoPY1A+v8ZlafMT4guS8Wtb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mH8cmP3nYU9eVe+QPlNhxiwENe6gW45K/8vurhCOhv1ae1DV1Du73s00LdNsQZwaM
         7ZGzZe6c1YMEn8UdnEYfCq5ZWgwcZfgD97NG/Nqg/Lk/Ar1Mp10nTlC6pHWCyfZwqX
         wfX1sDrNRbgBQFoWDVfmILq4qFtI3e18OkLiThkwOg6WO1XWWWm/93MlTg6o7cA2Y7
         8UvXIOdDQQqR9zpTVIQSOp7JbaZ9MzqRMlztcgXddOLgSooApp+gSEaZq6KNWp6/5s
         X0PPc7vzI/6pDPpGtA0FI6gNGUstZ0vvjoKGEK4+WBz7qtRK/XfA588MLRHImDydJY
         UeI60K4Sn5Q/A==
Date:   Tue, 21 Dec 2021 10:28:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, corbet@lwn.net, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] Instantiate key with user-provided decrypted data.
Message-ID: <YcGQMScGMvBd+0+L@iki.fi>
References: <20211213192030.125091-1-yaelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213192030.125091-1-yaelt@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Dec 13, 2021 at 02:20:30PM -0500, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with

What is "the encrypted.c class"?

/Jarkko
