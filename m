Return-Path: <linux-integrity+bounces-1541-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0F86EAAF
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 21:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA0B23E92
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Mar 2024 20:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8164535B9;
	Fri,  1 Mar 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOkTKbyN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291F535AE
	for <linux-integrity@vger.kernel.org>; Fri,  1 Mar 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326156; cv=none; b=Dn/XUfH+SNIoxVzgjP+SPme3zeKVOmcnKVkt6JK7/XftI6etO6z9vGkm1G7OEAjCcD7hxphjo89DeRIssBFkryxM4ua4aMi5cya2d7gkBdr36HWJKbZhcX0sX5p8In39Xd/ajTlyU3G2EDWkN00cbzhDnNAZT8+XUqGUAwwsbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326156; c=relaxed/simple;
	bh=oqTpUExjsprmUSKxgnE9dKR17auDKOqRf0mO53Mw4L0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=ZyYMbkJGocUX/clLL3BWxvqbuRJyJqsS4CsLNCx7kc4cs2mr6qc/njI1islgb02V6Ya60z9qyUh6BIdDMskOusmeSjSUYD6UNKd9EsKyZO/vUKy6lLKO1M/96izxQLfblaqccm0UH8fnxTxTporjPj6PjgMwvMHXLm0UkrGVOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOkTKbyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1D0C433F1;
	Fri,  1 Mar 2024 20:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709326156;
	bh=oqTpUExjsprmUSKxgnE9dKR17auDKOqRf0mO53Mw4L0=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=QOkTKbyNv/c/ohgbRCSa2rBEMWprh4Q1e+WuWy2tStTdF8r2hvrqxqk9fZqFHUZmv
	 URuDcfle7QSZM1MU/HzdF80jCFOyOLv0k3vuyAibbG0dWFEW7sp0sLbTu1X+ZNczcF
	 zSNpv0LNoVpFCjWDzTPE9kej7w0sYBUKRJbp3ILuvft5h1KZXrRNjtzoKCf15AIOEZ
	 kMEloLhjWpjRS8RBBYwaFt6nQAk4dqWLnncX2Ui1DZeRFcglM9iXBLjxWuow3HsE8G
	 z24MntZR9Vyka5hGEYBg+AnAFQ/dejU7fg20EL+9EcYKgNcj7iYuDDyiZNOgpZQgob
	 E1axC0YCRkXrA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Mar 2024 22:49:13 +0200
Message-Id: <CZIPJU62MHD6.QU71KYEKBQHN@suppilovahvero>
Subject: Re: TPM error path on probe
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, "Tim Harvey"
 <tharvey@gateworks.com>, <linux-integrity@vger.kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Linux
 ARM Mailing List" <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.15.2
References: <CAJ+vNU2irDtEn=VD7N2ySofr5wTeko6OHy-QD_SLLZudOwWj0A@mail.gmail.com> <6976a0ea-592b-4a04-81ac-9ed50a7f0a8f@gmx.de>
In-Reply-To: <6976a0ea-592b-4a04-81ac-9ed50a7f0a8f@gmx.de>

On Thu Feb 29, 2024 at 9:08 AM EET, Lino Sanfilippo wrote:
> I posted a fix for this issue a few weeks ago:
> https://lore.kernel.org/all/20240201113646.31734-1-l.sanfilippo@kunbus.co=
m/
>
> It is already included in Jarkos tree.

sanity checked, it is there! making pull request next week

>
> BR,
> Lino

BR, Jarkko

