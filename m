Return-Path: <linux-integrity+bounces-3535-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE89753D4
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912B51F23B6A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37D01A263C;
	Wed, 11 Sep 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnEembFU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E41885B0;
	Wed, 11 Sep 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060888; cv=none; b=HqW06wm0B7sGIPrVIjVzLPDX9JTTvwUuouS0kJEEiXG9fF9g84eI7oL5w9ONh40GpOZKCBLHw9ZbB6KZ5V3pNLE17TBMZ8lBcHk4fPDvU8XAV3Kv47hNhZ8vPNSmlN9rOYcx/dPxUUHTDTEAhNv5YPyenzT/zUuARJykaZ7P5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060888; c=relaxed/simple;
	bh=TbVHJy4bJCxJfuiWIi6m91gsvFiiHKUCc8fAKp3rakI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BjfJ66cDq7eozC4uNhPu0tq31T9skX1jqYEraMEIxqAQZCQJNzwmn6ols7poG4E/hBXCpODv9olT3Xhh371zwY8JWcbPfiAAWzuzyqPAtWsbMOuZpWFm+I6xVqE6CsvypxKlv0kRILwLaIQhRPiF69hyrZn193P+1c4yQkLGTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnEembFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DC9C4CEC6;
	Wed, 11 Sep 2024 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726060888;
	bh=TbVHJy4bJCxJfuiWIi6m91gsvFiiHKUCc8fAKp3rakI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UnEembFULsTg8mkuCfg+ubTW79Ej8N+9k0sxwa9Ybr+KiTqWumvEs62Rvpq3kt1dp
	 P9QZg6etJFjnrL8oDcoHtmdcvXmp9MjAXDdrvGrkU0NgH2zTWLh8l95XuuHfuOHDge
	 F5JqYvNyusXWflUcfsdZkWsOTDUAQCOkH0vz44Q9F2o6X3ELEWPZpVrzH3wdXq7cvm
	 1C2vUJR9AX9XjYr1wrkKPUS0q1gRycL+JAjzn5XWRo5s0KJhBA0Cg3xJXKTPsSdunr
	 42E8qf8pWL6JRD4JO+4zo5SYKDkslB36c7LGBL1wChrukbKffuq8e4L3UA6c62nVro
	 uY971j1KkYDIA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 16:21:24 +0300
Message-Id: <D43HINLZGMXS.FYJOK0SVQFQW@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "Peter Huewe" <peterhuewe@gmx.de>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v6] tpm: Add new device/vendor ID 0x50666666
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jett Rink" <jettrink@chromium.org>, "LKML"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240910191117.1001581-1-jettrink@chromium.org>
In-Reply-To: <20240910191117.1001581-1-jettrink@chromium.org>

On Tue Sep 10, 2024 at 10:11 PM EEST, Jett Rink wrote:
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jett Rink <jettrink@chromium.org>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I applied this (will push later to my remote tree).

BR, Jarkko

