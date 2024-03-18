Return-Path: <linux-integrity+bounces-1785-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F85887F05E
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 20:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B318D1F22788
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 19:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8825674C;
	Mon, 18 Mar 2024 19:23:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7557326
	for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2024 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.126.240.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789820; cv=none; b=liomr6KVD/vp0cv5CiHyz2oXHO333oNgKCUIwlBacwv0ozDMpd7H/dQUM9aSOmrsLbmivPpsW+8oeNpA2FdRN1pb/8dxOeEydxwaJUkr9EFSqbqiK+CXpfOFrsQbRw2EoMbPxyDfnbC5ffe0HVI9IOvCkqN6RoitR/71v2shNsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789820; c=relaxed/simple;
	bh=LzL1yEGGKmEzR8O/Gjpqkurct7yZ6apJNMIxAy891G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/UVV7LhJuTI8FKbMydN+7UXGDv1okywho/HHXeaLFB/tOIPgqo3uvDT+lqNygGGtgtuFNtzwghybhVN78ykiINOCD7v7o1sY6hC0voCvjWkrL8iZKjO0CBx1eGxLGp7inL62HRPhYuZ+rwTN23A6cb34+LdpzehDBsDm7Mf/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=codon.org.uk; arc=none smtp.client-ip=176.126.240.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 760E1407C8; Mon, 18 Mar 2024 19:16:55 +0000 (GMT)
Date: Mon, 18 Mar 2024 19:16:55 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, Alberto Mardegan <a.mardegan@omp.ru>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Eric Biggers <ebiggers@google.com>,
	Patrick Ohly <patrick.ohly@intel.com>,
	Patrick Uiterwijk <patrick@puiterwijk.org>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Matthew Garrett <mjg59@google.com>
Subject: Re: [ima-evm-utils: PATCH v2 1/1] Change license to
 LGPL-2.0-or-later and GPL-2.0-or-later
Message-ID: <ZfiTJw1JVNyS8e/G@srcf.ucam.org>
References: <103252ffff09c607e83c887cab2e0af5404d62ff.1710774200.git.dmitry.kasatkin@gmail.com>
 <CACE9dm8rjanQ8eKDJfD3Rj1GCYzk2MGidAkuiMo8ZZ4dduubQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACE9dm8rjanQ8eKDJfD3Rj1GCYzk2MGidAkuiMo8ZZ4dduubQg@mail.gmail.com>

On Mon, Mar 18, 2024 at 05:42:59PM +0200, Dmitry Kasatkin wrote:

> Hello,
> 
> Added all those who have not responded so far.
> Please respond.

All my contributions are owned by Google, not me, so I can't ack a 
relicense of them. opensource@google.com may be able to help you? Sorry 
about that!

