Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2B2FC945
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 04:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbhATDlg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Jan 2021 22:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730871AbhATDkO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jan 2021 22:40:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F4C622509;
        Wed, 20 Jan 2021 03:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611113973;
        bh=8ny0YdT7nC/riWxP8GCLjur6sgAwzB/GqDPXV5E+PSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9hn8pHSQ5Okh3y1QaYyUUxnMyC13YxTJt/9rG4pdby1t7UxGHXURNjDVhhbElbaQ
         HUG4xm/sfF9/OJIrdeipjJs0ImEMZjd/430T2jpDDFoyxid8BKaKwaEKjSzv5l4P2J
         7MEBeKSO2JKi9mnExmfkulV67+KAKnbsl/liu3MttLW4mKl7Gga0sKZ7+emYLYefm1
         GetCLP3QYCjvZXlwj61T7vMr1JkaykFDoZA5kKPyR3Ypc/L/ZUYU8a6ZF/++JMr6hY
         k/B3f5TVyV2I40zJ+U6l3EBubS2at3FhhyxM5xmxeNPTutMgA3JosTkcVF1NkYTS7o
         35PDzBsFC4XUg==
Date:   Wed, 20 Jan 2021 05:39:27 +0200
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
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Ben Boeckel <mathstuf@gmail.com>
Subject: Re: [PATCH v3 01/10] certs/blacklist: fix kernel doc interface issue
Message-ID: <YAel72yeCybbRmDN@kernel.org>
References: <20210114151909.2344974-1-mic@digikod.net>
 <20210114151909.2344974-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114151909.2344974-2-mic@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:19:00PM +0100, Mickaël Salaün wrote:
> From: Alex Shi <alex.shi@linux.alibaba.com>
> 
> certs/blacklist.c:84: warning: Function parameter or member 'hash' not
> described in 'mark_hash_blacklisted'
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Ben Boeckel <mathstuf@gmail.com>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
