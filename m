Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B542F052B
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Jan 2021 05:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAJE6A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 9 Jan 2021 23:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbhAJE6A (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Jan 2021 23:58:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5B4322BE8;
        Sun, 10 Jan 2021 04:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610254640;
        bh=IK3/xjM0zzN9SHLfPqLtfCKulyiYUQsXb1D9pfwab1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KEW1tb0oJLHB+Hh4qPKu/yrGiu0Fi5DWUwkkQvUcpriz2HTlJ5CMBMvMQCB4lLD/P
         qyzAud18YYmw6XIHpikjcOuEFvDYlItWq0db48UnlAGcndyOhD6LgKXk02qMZxdYFv
         K4h/TI1+2tpYoH5FeeYT8Mj1LEeM1jLI3UAMlDjV3eBSoVbITvh28lx0tWQngxXPIz
         k24GWL057ZO1f7OFM76byP4dsU0lMGrcLvpNjvJF6mcyKRo0eJ0x9bz20a9Zt45h3V
         7Z9Gpua3dvlX4Qy7S0EnezYfKrXoJeiu5kxuT3cCZPUZ4Ajisxx7q0qXARk8TajIfu
         ArkviRWIbbUnA==
Date:   Sun, 10 Jan 2021 06:57:10 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Enable root to update the blacklist keyring
Message-ID: <X/qJJsVe7+nP+gR6@kernel.org>
References: <20201211190330.2586116-1-mic@digikod.net>
 <67945fa6-2796-bfcd-5541-d54662e9802a@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67945fa6-2796-bfcd-5541-d54662e9802a@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 05, 2021 at 11:12:57AM +0100, Mickaël Salaün wrote:
> Jarkko, David, what is the status of this patch series? Do you need help
> to test it?

Hi, a leave/vacation and the holiday period badly mixed my schedules.

I'm testing this upcoming week.

/Jarkko
