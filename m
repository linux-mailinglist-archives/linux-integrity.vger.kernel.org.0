Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0D4309063
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 00:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhA2W7w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 29 Jan 2021 17:59:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232747AbhA2W7w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Jan 2021 17:59:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D336264DED;
        Fri, 29 Jan 2021 22:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611961151;
        bh=RMzrLYS0dhIFza5IZGjzDLcAAAHAc2oc8FO0sqO3xJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evJaiOBztm/TbR7DtHnUCr6qIvlyko0D3G4vNnVnO7DBrXSaORnY1ZgLAjsKPaKZp
         AI1QhjWborSuJPu1aQPlJOz6e7MD7NRiv4k3Cf8hRaaYMw0VM6g70vpPg1LlgYgByB
         OdW0nezuxevHo6/HMHVRHUQDqMGMfFjCrKHHYfgtdMhWL/3hG2YYJme8VeL9ED+K6f
         57NoS1q8U9gTqKUUqjmQTKjRGg7/pS8KbhgYxFsHzidu06zj4S1Ym8t/SP/YqOHxw2
         Pm1Inq0FoGk4xcwrjDlfxB2XQzEVZUtNmXTdas5VlyoDWcZTImYdSOJRrSL+y3n+3K
         XFILrEDCqy8Hg==
Date:   Sat, 30 Jan 2021 00:59:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Majczak <lma@semihalf.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] tpm_tis: Add missing start/stop_tpm_chip calls
Message-ID: <YBSTOrlgTPpzoblY@kernel.org>
References: <20210123014247.989368-1-lma@semihalf.com>
 <20210125171846.GA31929@roeck-us.net>
 <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJ_xboNDcp-XrxfbrBjqTWjLZUdVWe1OJi4KK==ij+yivFeHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 26, 2021 at 04:46:07PM +0100, Łukasz Majczak wrote:
> Hi Jarkko, Guenter
> 
> Yes, here are the logs when failure occurs -
> https://gist.github.com/semihalf-majczak-lukasz/1575461f585f1e7fb1e9366b8eceaab9
> Look for a phrase "TPM returned invalid status"
> 
> Guenter - good suggestion - I will try to keep it as tight as possible.
> 
> Best regards,
> Lukasz

Is it possible for you try out with linux-next? Thanks. It's a known
issue, which ought to be fixed by now.

The log message is harmless, it'a warning not panic, and does not
endanger system stability. WARN()'s always dump stack trace. No oops
is happening.

/Jarkko
